import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tbr_test/country_code_selector/bloc/country_code_search_bloc.dart';
import 'package:tbr_test/country_code_selector/model/country.dart';
import 'package:tbr_test/widgets/country_flag_widget.dart';

import 'view/country_select_search_list_widget.dart';

class CountrySelectorButton extends StatelessWidget {
  const CountrySelectorButton({
    Key? key,
    this.initialValue,
  }) : super(key: key);

  final Country? initialValue;

  static final _borderRadius = BorderRadius.circular(16.0);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showCountrySelectorBottomSheet(context),
      borderRadius: _borderRadius,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14.0),
        constraints: const BoxConstraints(
          maxHeight: 48,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFF4F5FF).withOpacity(0.4),
          borderRadius: _borderRadius,
        ),
        child: Center(
          child: Row(
            children: [
              if (initialValue != null) ...[
                CountryFlagWidget(initialValue!.flag),
                const SizedBox(width: 4.0),
                Text(
                  "+${initialValue!.countryCode}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<Country?> showCountrySelectorBottomSheet(
      BuildContext inheritedContext) {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: inheritedContext,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: () {
              context.read<CountryCodeSearchBloc>().onCountryCodeFilterClear();
              Navigator.of(context).pop();
            },
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: DraggableScrollableSheet(
              initialChildSize: .90,
              builder: (BuildContext context, ScrollController controller) {
                return Directionality(
                  textDirection: Directionality.of(context),
                  child: Container(
                    decoration: const ShapeDecoration(
                      color: Color(0xFF8EAAFB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                    ),
                    child: const CountrySelectSearchListWidget(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
