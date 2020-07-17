import 'package:flutter/material.dart';
import 'package:template_flutter_app/Activities/Model/User.dart';
import 'RegisterStep2.dart';



class RegisterStep1 extends StatelessWidget {
  final User user;
  final _formKey = new GlobalKey<FormState>();

  RegisterStep1({Key key, @required this.user}) : super(key: key);

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

  Widget _userNameField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
//        keyboardType: TextInputType.t,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: "User Name",
          icon: new Icon(Icons.person, color: Colors.grey),
        ),
        validator: (value) => value.isEmpty ? 'Username can\'t be empty' : null,
        onSaved: (value) => user.username = value.trim(),
      ),
    );
  }

  Widget _firstNameField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: "First Name",
          icon: new Icon(Icons.person, color: Colors.grey),
        ),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => user.firstName = value.trim(),
      ),
    );
  }

  Widget _lastNameField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: "Last Name",
          icon: new Icon(Icons.person, color: Colors.grey),
        ),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => user.lastName = value.trim(),
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.blue,
            child: new Text('Next',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: (){
              if(validateAndSave())
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterStep2(user: user)),
                  );
            },
          ),
        ));
  }
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
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
            Text('Login',
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

  Widget _fieldsWidget() {
    return Column(
      children: <Widget>[
        _userNameField(),
        _lastNameField(),
        _firstNameField(),
      ],
    );
  }

  Widget _showForm(BuildContext  context) {
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              _showLogo(),
              _fieldsWidget(),
              _submitButton(context),
              _loginAccountLabel(context),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Flutter Registration'),
        ),
        body: Stack(
          children: <Widget>[
            _showForm(context),
//            _showCircularProgress(),
          ],
        ));
  }



//
//  @override
//  Widget build(BuildContext context) {
//    TextEditingController _titleController = new TextEditingController();
//    _titleController.text = "Step1";
//
//    return Scaffold(
//        appBar: AppBar(
//          title: Text('Create Trip - Location'),
//        ),
//        body: Center(
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Text("Enter a Location"),
//              Padding(
//                padding: const EdgeInsets.all(30.0),
//                child: TextField(
//                  controller: _titleController,
//                  autofocus: true,
//                ),
//              ),
//              RaisedButton(
//                child: Text("Continue"),
//                onPressed: () {
////                  trip.title = _titleController.text;
//                  Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) => NewTripDateView(user: user)),
//                  );
//                },
//              ),
//            ],
//          )
//        )
//    );
//  }


}
