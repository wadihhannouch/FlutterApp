import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import '../Auth/authentication.dart';
import '../Widget/bezierContainer.dart';

import 'package:google_fonts/google_fonts.dart';

class SignUpPage1 extends StatefulWidget {
  SignUpPage1({this.auth, this.registrationCallback});

  final BaseAuth auth;

  final VoidCallback registrationCallback;



  @override
  _SignUpPageState1 createState() => _SignUpPageState1();
}

class _SignUpPageState1 extends State<SignUpPage1> {
  Country _selected;
  String _password;
  String _email;
  String _username;
  bool _isLoading = false;
  final _formKey = new GlobalKey<FormState>();

  Widget _countryPicker(){
    return new CountryPicker(
      dense: false,
      showFlag: true,  //displays flag, true by default
      showDialingCode: true, //displays dialing code, false by default
      showName: true, //displays country name, true by default
      showCurrency: false, //eg. 'British pound'
      showCurrencyISO: true, //eg. 'GBP'
      onChanged: (Country country) {
        setState(() {
          _selected = country ;
        });
      },
      selectedCountry: _selected,
    );
  }

  Widget _backButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _userNameField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: "Username",
          icon: new Icon(Icons.account_circle, color: Colors.grey),
        ),
        validator: (value) => value.isEmpty ? 'Username can\'t be empty' : null,
        onSaved: (value) => _username = value.trim(),
      ),
    );
  }

  Widget _passwordField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: "Password",
          icon: new Icon(Icons.vpn_key, color: Colors.grey),
        ),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }

  Widget _emailField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: "Email",
          icon: new Icon(Icons.email, color: Colors.grey),
        ),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget _submitButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.blue,
            child: new Text('Sign up',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: (){},//validateAndSubmit,
          ),
        ));
  }

  Widget _loginAccountLabel(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showLogo() {
    return new Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 48.0,
          child: Image.asset('assets/ic_launcher.png'),
        ),
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _userNameField(),
        _countryPicker(),
//        _passwordField(),
      ],
    );
  }

  Widget _showForm() {
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              _showLogo(),
              _emailPasswordWidget(),
              _submitButton(),
              _loginAccountLabel(context),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Flutter login demo'),
        ),
        body: Stack(
          children: <Widget>[
            _showForm(),
            _showCircularProgress(),
          ],
        ));
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  void validateAndSubmit() async {
    setState(() {
      _isLoading = true;
    });
    String userId = "";
    if (validateAndSave()) {
      try {
        userId = await widget.auth.signUp(_email, _password);
        widget.auth.sendEmailVerification();
        print('Signed up user: $userId');
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _formKey.currentState.reset();
        });
      }
    }
    setState(() {
      _isLoading = false;
    });
    if (userId.length > 0 && userId != null) {
      widget.registrationCallback();
    }
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
