class UserPray{
  int idUser;
  int idPray;
  DateTime acceptanceDate;
  DateTime endDate;
  int rate;
  
  UserPray({this.idUser, this.idPray, this.acceptanceDate, this.endDate, this.rate});
  
  factory UserPray.fromJson(Map<String, dynamic> userPrayJson){
    return UserPray(
      idUser: userPrayJson['user'],
      idPray: userPrayJson['pray'],
      acceptanceDate: DateTime.fromMillisecondsSinceEpoch(userPrayJson['acceptanceDate']),
        endDate: DateTime.fromMillisecondsSinceEpoch(userPrayJson['exitDate']),
      rate: userPrayJson['rate']
    );
  }

  Map<String, dynamic> toJson() => {
    'user': idUser,
    'pray': idPray,
    'acceptanceDate': acceptanceDate.millisecondsSinceEpoch,
    'exitDate': endDate.millisecondsSinceEpoch,
    'rate': rate
  };
  
}