import 'package:flutter/material.dart';
import './countryTag.dart';

//State for Country Page
// State for Home Page
class CountryPage extends StatefulWidget {
  const CountryPage({Key? key}) : super(key: key);
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  Icon searchBarIcon = const Icon(Icons.search);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ListView(
            children: [
              CountryTag("Afghanistan", 'assets/flags/Afghanistan.jpg'),
              CountryTag("Bangladesh", 'assets/flags/Bangladesh.png'),
              CountryTag("Bhutan", 'assets/flags/Bhutan.png')
            ],
          ),
        ),
      ),
    );
  }
}
