import 'package:flutter/material.dart';
import 'package:template_flutter_app/Activities/Model/User.dart';
import 'RegisterStep2.dart';

class RegisterStep3 extends StatefulWidget {
  RegisterStep3({Key key, @required this.user}) : super(key: key);
  final User user;

  @override
  _RegisterStep3State createState() => _RegisterStep3State();
}




class _RegisterStep3State extends State<RegisterStep3> {
  final _formKey = new GlobalKey<FormState>();


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
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: "Password",
          icon: new Icon(Icons.person, color: Colors.grey),
        ),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => widget.user.username = value.trim(),
      ),
    );
  }

  Widget _firstNameField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: "Email",
          icon: new Icon(Icons.person, color: Colors.grey),
        ),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => widget.user.firstName = value.trim(),
      ),
    );
  }

  Widget _lastNameField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: "Email",
          icon: new Icon(Icons.person, color: Colors.grey),
        ),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => widget.user.lastName = value.trim(),
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterStep3(user: widget.user)),
              );
            },
          ),
        ));
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
