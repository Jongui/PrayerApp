class Church{
  int idChurch;
  String name;
  String city;
  String region;
  String country;

  Church({this.idChurch, this.name, this.city, this.region, this.country});

  factory Church.fromJson(Map<String, dynamic> churchJson){
    return Church(
      idChurch: churchJson['idChurch'],
      name: churchJson['name'],
      city: churchJson['city'],
      region: churchJson['region'],
      country: churchJson['country'],
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'idChurch': idChurch,
        'name': name,
        'city': city,
        'region': region,
        'country': country
      };


}