class Church{
  int idChurch;
  String name;
  String city;
  String region;
  String country;
  int createdBy;
  DateTime createdAt;
  int changedBy;
  DateTime changedAt;

  Church({this.idChurch, this.name, this.city, this.region, this.country, this.createdBy,
    this.createdAt, this.changedBy, this.changedAt});

  factory Church.fromJson(Map<String, dynamic> churchJson){
    return Church(
      idChurch: churchJson['idChurch'],
      name: churchJson['name'],
      city: churchJson['city'],
      region: churchJson['region'],
      country: churchJson['country'],
      createdBy: churchJson['createdBy'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(churchJson['createdAt']),
      changedBy: churchJson['changedBy'],
      changedAt: churchJson['changedAt'] != null ? DateTime.fromMillisecondsSinceEpoch(churchJson['changedAt'])
            : null
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
        'createdAt': createdAt.millisecondsSinceEpoch,
        'changedBy': changedBy != null ? changedBy : '',
        'changedAt': changedAt != null ? changedAt.millisecondsSinceEpoch : ''
      };


}