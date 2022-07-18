part of 'country_code_search_bloc.dart';

abstract class CountryCodeSearchEvent extends Equatable {
  const CountryCodeSearchEvent();

  @override
  List<Object> get props => [];
}

class CountryCodesSubscriptionRequested extends CountryCodeSearchEvent {
  const CountryCodesSubscriptionRequested();
}

class CountryCodeFilterChanged extends CountryCodeSearchEvent {
  const CountryCodeFilterChanged(this.filter);

  final String filter;

  @override
  List<Object> get props => [filter];
}

class CountryCodeFilterInitialSelected extends CountryCodeSearchEvent {
  const CountryCodeFilterInitialSelected(this.initialValue);

  final Country initialValue;

  @override
  List<Object> get props => [initialValue];
}

class CountryCodeFilterClear extends CountryCodeSearchEvent {
  const CountryCodeFilterClear();
}
