class User{
  int idUser;
  String email;
  String userName;
  String city;
  String country;
  String token;
  int church;

  User({this.idUser, this.email, this.userName, this.city, this.country, this.church, this.token});

  factory User.fromJson(Map<String, dynamic> userJson){
    return User(
      idUser: userJson['idUser'],
      email: userJson['email'],
      userName: userJson['userName'],
      city: userJson['city'],
      country: userJson['country'],
      church: userJson['church'],
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'idUser': idUser,
        'email': email,
        'userName': userName,
        'city': city,
        'country': country,
        'church': church
      };

}