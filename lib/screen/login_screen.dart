import 'package:flutter/material.dart';
import 'package:projectest/models/user.dart';
import 'package:projectest/screen/home_page.dart';
import 'package:projectest/services/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginPageState extends State<LoginPage> implements LoginCallBack {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  String _username, _password;

  LoginResponse _response;

  _LoginPageState() {
    _response = new LoginResponse(this);
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _response.doLogin(_username, _password);
      });
    }
  }


  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
    ));
  }

  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");

      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null);
      preferences.commit();
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        _ctx = context;
        var loginBtn = new RaisedButton(
          onPressed: _submit,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50)
          ),
          child: new Text("Login"),
            color: Color.fromRGBO(49, 39, 79, 1)
        );
        var loginForm = new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200,
              child: Stack(children: <Widget>[
                Positioned(
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/1.png")
                        )
                    ),
                  ),
                )
              ],),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Welcome ! \nWe are glad to see you again",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            new Form(
              key: formKey,
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: new TextFormField(
                      style: TextStyle(color: Colors.white),
                      onSaved: (val) => _username = val,
                      decoration: InputDecoration(
                          //border: InputBorder.none,
                          hintText: "Username",

                          hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  Container(
                    child: new Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: new TextFormField(
                        style: TextStyle(color: Colors.white),
                        obscureText: true,
                        onSaved: (val) => _password = val,
                        decoration: InputDecoration(
                            //border: InputBorder.none,
                            hintText: "Password",
                            focusColor: Colors.white,
                            hintStyle: TextStyle(color: Colors.grey)
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            loginBtn,
            SizedBox(
              height: 40,
            ),
            Center(
              child: Text("Forgot password?",style: TextStyle(
                color: Colors.pink[200],
              ),),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text("Create Account",style: TextStyle(
                color: Colors.pink[200],
              ),),
            )
          ],
        );

        return new Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color(0xff21254A),
          key: scaffoldKey,
          body: new Container(
            child: new Center(
              child: loginForm,
            ),
          ),
        );
        break;
      case LoginStatus.signIn:
        return HomeScreen(signOut);
        break;
    }
  }

  savePref(int value,String user, String pass) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("user", user);
      preferences.setString("pass", pass);
      preferences.commit();
    });
  }

  @override
  void onLoginError(String error) {
    _showSnackBar(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginSuccess(User user) async {

    if(user != null){
      savePref(1,user.username, user.password);
      _loginStatus = LoginStatus.signIn;
    }else{
      _showSnackBar("Login Gagal, Silahkan Periksa Login Anda");
      setState(() {
        _isLoading = false;
      });
    }

  }
}