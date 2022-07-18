part of 'country_code_search_bloc.dart';

enum CountryCodeSearchStatus { initial, loading, success, failure }

class CountryCodeSearchState extends Equatable {
  const CountryCodeSearchState({
    this.status = CountryCodeSearchStatus.initial,
    this.initialCountry = const Country(name: '', flag: '', countryCode: ''),
    this.countries = const [],
    this.filter = '',
    this.searchResult = const [],
    this.errorMessage = '',
  });

  final CountryCodeSearchStatus status;
  final Country initialCountry;
  final List<Country> countries;
  final String filter;
  final List<Country> searchResult;
  final String errorMessage;

  CountryCodeSearchState copyWith({
    CountryCodeSearchStatus Function()? status,
    Country Function()? initialCountry,
    List<Country> Function()? countries,
    String Function()? filter,
    List<Country> Function()? searchResult,
    String Function()? errorMessage,
  }) {
    return CountryCodeSearchState(
      status: status != null ? status() : this.status,
      initialCountry:
          initialCountry != null ? initialCountry() : this.initialCountry,
      countries: countries != null ? countries() : this.countries,
      filter: filter != null ? filter() : this.filter,
      searchResult: searchResult != null ? searchResult() : this.searchResult,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        initialCountry,
        countries,
        filter,
        searchResult,
        errorMessage,
      ];
}
