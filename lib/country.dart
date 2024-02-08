class Country {
  String flag;
  String name;
  String cca2;
  String capital;
  String region;
  String language;
  int population;

  Country.fromMap(Map<String, dynamic> countryMap)
      : flag = countryMap['flags']['png'] ?? '',
        name = countryMap['name']?['common'] ?? '',
        cca2 = countryMap['cca2'] ?? '',
        capital = (countryMap['capital'] as List<dynamic>).isNotEmpty ? countryMap['capital'][0] : '',
        region = countryMap['region'] ?? '',
        language =
            (countryMap['languages'] as Map<String, dynamic>).isNotEmpty ? (countryMap['languages'] as Map<String, dynamic>).entries.toList()[0].value : '',
        population = countryMap['population'];
}
