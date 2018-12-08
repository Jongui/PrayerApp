class Country{
  String code;
  String name;

  Country({this.code, this.name});

  factory Country.fromJson(Map<String, dynamic> countryJson, String language){

    var nameTranslations = countryJson["translations"];
    var countryName = nameTranslations[language.toLowerCase()];
    if(countryName == null)
      countryName = countryJson["name"];
    return Country(
      code: countryJson["alpha2Code"],
      name: countryName,
    );
  }

}