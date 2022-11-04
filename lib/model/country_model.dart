class Country {
  String? name;
  final String countryPhoneCode;
  final String countryName;

  Country({
    required this.name,
    required this.countryPhoneCode,
    required this.countryName,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
        name: json['name'] as String,
        countryPhoneCode: json['e164_cc'].toString(),
        countryName: json['iso2_cc'] as String);
  }

  Map<String, Object?> toMap() {
    return {
      'name': name,
      'e164_cc': countryPhoneCode,
      'iso2_cc': countryName,
    };
  }
}
