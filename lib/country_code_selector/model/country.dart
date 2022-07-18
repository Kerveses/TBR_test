import 'package:equatable/equatable.dart';

class Country extends Equatable {
  final String name;
  final String flag;
  final String countryCode;

  const Country({
    required this.name,
    required this.flag,
    required this.countryCode,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    final name = json['name'] as String;
    final countryCode = (json['callingCodes'] as List<dynamic>).first;
    final flag = (json['flags'] as Map<String, dynamic>)['svg'];

    return Country(
      name: name,
      flag: flag,
      countryCode: countryCode,
    );
  }

  @override
  List<Object?> get props => [name, flag, countryCode];
}
