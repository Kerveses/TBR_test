import 'dart:convert' show jsonDecode;
import 'package:http/http.dart' as http;
import 'package:tbr_test/country_code_selector/model/country.dart';

import 'package:tbr_test/config.dart';

class CountryParseError implements Exception {
  final String? message;

  CountryParseError(this.message);

  @override
  String toString() => "CountryParseError: $message";
}

class Client {
  static final url = Uri.parse(Config.apiUrl);

  Future<List<Country>> fetchCountries() async {
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<Country> countries = [];

      try {
        for (var country in jsonDecode(response.body)) {
          countries.add(Country.fromJson(country));
        }

        return Future.value(countries);
      } catch (e) {
        return Future.error(
          CountryParseError(e.toString()),
        );
      }
    } else {
      return Future.error(
        CountryParseError(jsonDecode(response.body)["message"]),
      );
    }
  }
}
