import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tbr_test/client/client.dart';
import 'package:tbr_test/country_code_selector/model/country.dart';

part 'country_code_search_event.dart';
part 'country_code_search_state.dart';

class CountryCodeSearchBloc
    extends Bloc<CountryCodeSearchEvent, CountryCodeSearchState> {
  CountryCodeSearchBloc({required Client httpClient})
      : _httpClient = httpClient,
        super(const CountryCodeSearchState()) {
    on<CountryCodesSubscriptionRequested>(_countryCodesSubscriptionRequested);
    on<CountryCodeFilterChanged>(_countryCodeFilterChanged);
    on<CountryCodeFilterInitialSelected>(_countryCodeFilterInitialSelected);
    on<CountryCodeFilterClear>(_countryCodeFilterClear);
  }

  final Client _httpClient;

  Future<void> _countryCodesSubscriptionRequested(
    CountryCodesSubscriptionRequested event,
    Emitter<CountryCodeSearchState> emit,
  ) async {
    emit(state.copyWith(status: () => CountryCodeSearchStatus.loading));

    try {
      final countries = await _httpClient.fetchCountries();
      emit(state.copyWith(
        status: () => CountryCodeSearchStatus.success,
        countries: () => countries,
        initialCountry: () => countries.first,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: () => CountryCodeSearchStatus.failure,
        errorMessage: () => e.toString(),
      ));
    }
  }

  Future<void> _countryCodeFilterChanged(
    CountryCodeFilterChanged event,
    Emitter<CountryCodeSearchState> emit,
  ) async {
    emit(state.copyWith(
      status: () => CountryCodeSearchStatus.loading,
      filter: () => event.filter,
    ));

    final searchResult = state.countries
        .where((element) =>
            element.name.toLowerCase().contains(state.filter.toLowerCase()) ||
            "+${element.countryCode.toLowerCase()}"
                .contains(state.filter.toLowerCase()))
        .toList();

    if (searchResult.isNotEmpty) {
      emit(state.copyWith(
        status: () => CountryCodeSearchStatus.success,
        searchResult: () => searchResult,
      ));
    } else {
      emit(state.copyWith(
        status: () => CountryCodeSearchStatus.failure,
        errorMessage: () => 'no countries found',
        searchResult: () => [],
      ));
    }
  }

  Future<void> _countryCodeFilterClear(
    CountryCodeFilterClear event,
    Emitter<CountryCodeSearchState> emit,
  ) async {
    emit(state.copyWith(
      status: () => CountryCodeSearchStatus.success,
      filter: () => '',
      searchResult: () => [],
    ));
  }

  Future<void> _countryCodeFilterInitialSelected(
    CountryCodeFilterInitialSelected event,
    Emitter<CountryCodeSearchState> emit,
  ) async {
    emit(state.copyWith(
      status: () => CountryCodeSearchStatus.success,
      filter: () => '',
      searchResult: () => [],
      initialCountry: () => event.initialValue,
    ));
  }

  void onCountryCodesSubscriptionRequested() async {
    add(const CountryCodesSubscriptionRequested());
  }

  void onCountryCodeFilterChanged({String filter = ''}) async {
    add(CountryCodeFilterChanged(filter));
  }

  void onCountryCodeFilterInitialSelected(Country country) async {
    add(CountryCodeFilterInitialSelected(country));
  }

  void onCountryCodeFilterClear() async {
    add(const CountryCodeFilterClear());
  }
}
