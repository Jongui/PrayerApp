class Pray{
  int idPray;
  String description;
  DateTime beginDate;
  DateTime endDate;
  int idUser;

  Pray({this.idPray, this.description, this.beginDate, this.endDate, this.idUser});

  factory Pray.fromJson(Map<String, dynamic> prayJson){
    return Pray(
      idPray: prayJson['idPray'],
      description: prayJson['description'],
      beginDate: DateTime.fromMicrosecondsSinceEpoch(prayJson['beginDate']),
      endDate: DateTime.fromMicrosecondsSinceEpoch(prayJson['endDate']),
      idUser: prayJson['creator'],
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