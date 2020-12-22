import 'package:flutter/cupertino.dart';

class User{
  int _id;
  String _username;
  String _password;
  String _email;
  String _token;

  User(this._username, this._password, this._email);

  User.fromMap(dynamic obj){
    this._username = obj['username'];
    this._password = obj['_password'];
    this._email = obj['_email'];
    this._token = obj['_token'];
  }

  String get username => _username;
  String get password => _password;
  String get email => _email;
  String get token => _token;



  Map<String, dynamic> toDatabaseJson() => {
    "id": this._id,
    "username": this.username,
    "email": this.email,
    "token": this._token
  };


  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();
    map["username"] = _username;
    map["password"] = _password;
    map["email"] = _email;
    map["token"] = _token;
    return map;
  }
}