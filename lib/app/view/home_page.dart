import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tbr_test/app/view/components/button_next.dart';
import 'package:tbr_test/country_code_selector/%D1%81ountry_selector_button.dart';
import 'package:tbr_test/country_code_selector/bloc/country_code_search_bloc.dart';
import 'package:tbr_test/country_code_selector/model/country.dart';
import 'package:tbr_test/app/view/components/phone_input_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = TextEditingController();

  ValueNotifier<bool> active = ValueNotifier(false);

  @override
  void initState() {
    controller.addListener(() {
      active.value = controller.text.length >= 14;
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 36.0, 20.0, 20.0),
          child: BlocBuilder<CountryCodeSearchBloc, CountryCodeSearchState>(
            builder: (context, state) {
              if (state.status == CountryCodeSearchStatus.success) {
                return buildSuccessView(
                  context,
                  state.initialCountry,
                  controller,
                  active,
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
          ),
        ),
      ),
    );
  }

  Column buildSuccessView(BuildContext context, Country initialValue,
      TextEditingController controller, ValueNotifier<bool> active) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Get Started',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CountrySelectorButton(
              initialValue: initialValue,
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: PhoneInputField(
                controller: controller,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: active,
              builder: (BuildContext context, bool active, Widget? _) {
                return ButtonNext(
                  active: active,
                  onTap: () {
                    final countryCode = context
                        .read<CountryCodeSearchBloc>()
                        .state
                        .initialCountry
                        .countryCode;

                    if (kDebugMode) {
                      print("+$countryCode ${controller.text}");
                    }

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                );
              },
            ),
          ],
        )
      ],
    );
  }

  static const snackBar = SnackBar(
    content: IntrinsicHeight(
      child: Center(child: Text("Phone number input success!")),
    ),
  );
}
