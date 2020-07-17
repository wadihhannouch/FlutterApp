import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:template_flutter_app/Activities/HomePage.dart';
import 'package:template_flutter_app/Activities/SignupSteps/SignUpPage.dart';
import 'package:template_flutter_app/Activities/SignupSteps/SignUpPage1.dart';

import 'Auth/authentication.dart';
import 'loginPage.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
  REGISTERED
}

class RootPage extends StatefulWidget {
  RootPage({this.auth});
  final BaseAuth auth;


  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";

  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.uid;
        }
        authStatus =
        user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
      });
    });
  }


  void loginCallback() {

    widget.auth.getCurrentUser().then((user) {
      setState(() {
        _userId = user.uid.toString();
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
    });
  }

  void registrationCallback() {

    widget.auth.getCurrentUser().then((user) {
      setState(() {
        _userId = user.uid.toString();
      });
    });
    setState(() {
      authStatus = AuthStatus.REGISTERED;
    });
  }

 bool isGoogleSignIn = false;

  void googleLogoutCallback() {

    setState(() {
      isGoogleSignIn = true;
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }

  void logoutCallback() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }

  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
          return new LoginSignupPage(
            auth: widget.auth,
            loginCallback: loginCallback,
            registrationCallback : registrationCallback
          );
        break;
      case AuthStatus.REGISTERED:
        print("user is registerd");
        return new SignUpPage1(auth: widget.auth,
            registrationCallback : registrationCallback
        );
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          return new HomePage(
            userId: _userId,
            auth: widget.auth,
            logoutCallback: logoutCallback,
            isGoogleSignin: false,
          );
        } else
          return buildWaitingScreen();
        break;
      default:
        return buildWaitingScreen();
    }
  }
}