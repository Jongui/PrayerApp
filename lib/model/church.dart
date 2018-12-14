class Church{
  int idChurch;
  String name;
  String city;
  String region;
  String country;
  int createdBy;
  DateTime createdAt;

  Church({this.idChurch, this.name, this.city, this.region, this.country, this.createdBy,
    this.createdAt});

  factory Church.fromJson(Map<String, dynamic> churchJson){
    return Church(
      idChurch: churchJson['idChurch'],
      name: churchJson['name'],
      city: churchJson['city'],
      region: churchJson['region'],
      country: churchJson['country'],
      createdBy: churchJson['createdBy'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(churchJson['createdAt']),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'idChurch': idChurch,
        'name': name,
        'city': city,
        'region': region,
        'country': country,
        'createdBy': createdBy,
        'createdAt': createdAt.millisecondsSinceEpoch
      };


}