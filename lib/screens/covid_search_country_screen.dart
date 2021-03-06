import '../screens/covid_specific_country_screen.dart';
import 'package:flutter/material.dart';
import '../components/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import '../components/alert_dialog.dart';

class SearchScreen extends StatefulWidget {
  List<String> countries = [];
  SearchScreen({this.countries});

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<SearchScreen> {
  String selectedCountry;
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Image.asset(
                  'images/covid_19_icon.png',
                  width: 150,
                  height: 150,
                ),
              ),
            ),
            SimpleAutoCompleteTextField(
              controller: _controller,
              key: key,
              suggestions: widget.countries,
              clearOnSubmit: false,
              textSubmitted: (text) => setState(() {
                selectedCountry = text;
              }),
              decoration: InputDecoration(
                filled: true,
                hintText: 'Enter Country Name',
                focusColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            RoundedButton(
              color: Colors.blueAccent,
              title: 'Search',
              onPressed: () {
                if (selectedCountry == null) {
                  showAlertDialog(context,
                      isDismissible: true,
                      title: 'Country Name Issue',
                      content: 'Please Enter Your Country Name Properly',
                      buttonText: 'Ok', onPressed: () {
                    Navigator.pop(context);
                  });
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => COVIDCountryScreen(
                        selectedCountry: selectedCountry,
                      ),
                    ),
                  ).then(
                    (_) => {
                      selectedCountry = null,
                      _controller.clear(),
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
