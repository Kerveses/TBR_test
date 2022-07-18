import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tbr_test/common/assets.dart';
import 'package:tbr_test/country_code_selector/bloc/country_code_search_bloc.dart';
import 'package:tbr_test/country_code_selector/model/country.dart';
import 'package:tbr_test/widgets/country_flag_widget.dart';

class CountrySelectSearchListWidget extends StatefulWidget {
  const CountrySelectSearchListWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<CountrySelectSearchListWidget> createState() =>
      _CountrySelectSearchListWidgetState();
}

class _CountrySelectSearchListWidgetState
    extends State<CountrySelectSearchListWidget> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0) - const EdgeInsets.only(bottom: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Country code',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              CloseButton(
                onTap: () {
                  context
                      .read<CountryCodeSearchBloc>()
                      .onCountryCodeFilterClear();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          CountrySearchField(controller: _controller),
          const SizedBox(height: 12.0),
          const CountrySelectListView(),
        ],
      ),
    );
  }
}

class CountrySearchField extends StatelessWidget {
  const CountrySearchField({
    Key? key,
    required TextEditingController controller,
  })  : _controller = controller,
        super(key: key);

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 48.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F5FF).withOpacity(0.4),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Row(
        children: [
          SvgPicture.asset(Assets.searchIcon),
          const SizedBox(width: 8.0),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
                hintStyle: Theme.of(context).textTheme.bodyMedium,
              ),
              style: Theme.of(context).textTheme.bodyMedium,
              onChanged: (value) {
                context
                    .read<CountryCodeSearchBloc>()
                    .onCountryCodeFilterChanged(filter: value);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CloseButton extends StatelessWidget {
  const CloseButton({
    Key? key,
    this.onTap,
  }) : super(key: key);

  final VoidCallback? onTap;

  static const double _size = 20.0;
  static final _borderRadius = BorderRadius.circular(6.0);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: _borderRadius,
      child: Container(
        height: _size,
        width: _size,
        padding: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: const Color(0xFFF4F5FF).withOpacity(0.4),
          borderRadius: _borderRadius,
        ),
        child: Center(
          child: SvgPicture.asset(Assets.crossIcon),
        ),
      ),
    );
  }
}

class CountrySelectListView extends StatelessWidget {
  const CountrySelectListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountryCodeSearchBloc, CountryCodeSearchState>(
      builder: (context, state) {
        if (state.status == CountryCodeSearchStatus.success) {
          final countries =
              state.searchResult.isEmpty ? state.countries : state.searchResult;

          return Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(
                bottom: 20.0 + MediaQuery.of(context).padding.bottom,
              ),
              itemCount: countries.length,
              itemBuilder: (BuildContext context, int index) {
                final country = countries[index];
                return CountrySelectListItem(
                  country: country,
                  onTap: () {
                    context
                        .read<CountryCodeSearchBloc>()
                        .onCountryCodeFilterInitialSelected(country);
                    context
                        .read<CountryCodeSearchBloc>()
                        .onCountryCodeFilterClear();
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          );
        } else if (state.status == CountryCodeSearchStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.status == CountryCodeSearchStatus.failure) {
          return Center(
            child: Text(
              state.errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class CountrySelectListItem extends StatelessWidget {
  const CountrySelectListItem({
    Key? key,
    required this.country,
    this.onTap,
  }) : super(key: key);

  final Country country;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            CountryFlagWidget(country.flag),
            const SizedBox(width: 12.0),
            Text(
              "+${country.countryCode}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Text(
                country.name,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
