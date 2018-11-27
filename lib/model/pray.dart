class Pray{
  int idPray;
  String description;
  DateTime beginDate;
  DateTime endDate;
  int idUser;

  Pray({this.idPray, this.description, this.beginDate, this.endDate, this.idUser});

  factory Pray.fromJson(Map<String, dynamic> churchJson){
    return Pray(
      idPray: churchJson['idPray'],
      description: churchJson['description'],
      beginDate: churchJson['beginDate'],
      endDate: churchJson['endDate'],
      idUser: churchJson['creator'],
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'idPray': idPray,
        'description': description,
        'beginDate': beginDate.millisecondsSinceEpoch,
        'endDate': endDate.millisecondsSinceEpoch,
        'creator': idUser
      };


}