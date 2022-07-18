import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tbr_test/client/client.dart';
import 'package:tbr_test/country_code_selector/bloc/country_code_search_bloc.dart';
import 'package:tbr_test/app/view/home_page.dart';

class App extends StatelessWidget {
  const App({Key? key, required this.httpClient}) : super(key: key);

  final Client httpClient;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CountryCodeSearchBloc(httpClient: httpClient)
            ..onCountryCodesSubscriptionRequested(),
        ),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: const Color(0xFF8EAAFB),
        primaryColor: const Color(0xFFF4F5FF),
        scaffoldBackgroundColor: const Color(0xFF8EAAFB),
        fontFamily: "Inter",
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 32.0,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
          bodyMedium: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
            color: Color(0xFF594C74),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
