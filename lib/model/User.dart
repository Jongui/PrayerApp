
class User{
  final int idUser;
  final String email;
  final String userName;
  final String city;
  final String country;
  final int church;

  User({this.idUser, this.email, this.userName, this.city, this.country, this.church});

  factory User.fromJson(Map<String, dynamic> json){
    var value = json['value'];
    var userJson = value[0];
    return User(
      idUser: userJson['idUser'],
      email: userJson['email'],
      userName: userJson['userName'],
      city: userJson['city'],
      country: userJson['country'],
      church: userJson['church'],
    );
  }
}