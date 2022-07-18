import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tbr_test/app/app.dart';
import 'package:tbr_test/app/bloc_observer.dart';
import 'package:tbr_test/client/client.dart';

void main() async {
  final httpClient = Client();

  BlocOverrides.runZoned(
    () async {
      runApp(App(httpClient: httpClient));
    },
    blocObserver: AppBlocObserver(),
  );
}
