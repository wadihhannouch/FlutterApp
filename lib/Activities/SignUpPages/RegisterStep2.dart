import 'package:flutter/material.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:template_flutter_app/Activities/Model/User.dart';
import 'package:template_flutter_app/Activities/SignUpPages/RegisterStep3.dart';

class RegisterStep2 extends StatefulWidget {

  RegisterStep2({Key key, @required this.user}) : super(key: key);
  final User user;
  @override
  _RegisterStep2State createState() => _RegisterStep2State();

}

class _RegisterStep2State extends State<RegisterStep2> {

  final _formKey = new GlobalKey<FormState>();

  Country _selectedOriginCountry;
  Country _selectedCurrentCountry;

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

  Widget _countryOrigin() {

    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child:  CountryPicker(
        dense: false,
        showFlag: true,  //displays flag, true by default
        showDialingCode: false, //displays dialing code, false by default
        showName: true, //displays country name, true by default
        showCurrency: false, //eg. 'British pound'
        showCurrencyISO: true, //eg. 'GBP'
        onChanged: (Country country) {
          setCountry(country,true);
        },
        selectedCountry: _selectedOriginCountry,
      ),
    );
  }


  Widget _countryCurrent() {

    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
      child:  CountryPicker(
        dense: false,
        showFlag: true,  //displays flag, true by default
        showDialingCode: false, //displays dialing code, false by default
        showName: true, //displays country name, true by default
        showCurrency: false, //eg. 'British pound'
        showCurrencyISO: true, //eg. 'GBP'
        onChanged: (Country country) {
          setCountry(country,false);
        },
        selectedCountry: _selectedCurrentCountry,
      ),
    );
  }

  setCountry(Country country,bool isCurrent){
    setState(){
      isCurrent?  _selectedCurrentCountry = country : _selectedOriginCountry = country;
    }
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
              widget.user.origin = _selectedOriginCountry.name.toString();
              widget.user.location = _selectedCurrentCountry.name.toString();
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
        _countryOrigin(),
        _countryCurrent(),
//        _firstNameField(),
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
