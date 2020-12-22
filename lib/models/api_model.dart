class UserLogin {
  String username;
  String password;
  String email;

  UserLogin({this.username, this.password, this.email});

  Map <String, dynamic> toDatabaseJson() => {
    "username": this.username,
    "password": this.password,
    "email": this.email
  };
}

class Token{
  String token;

  Token({this.token});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
        token: json['token']
    );
  }
}