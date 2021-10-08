import 'package:flutter/material.dart';
import './categoryInfo.dart';

//State for CategoryInfo Page
// State for Home Page
class CategoryInfoPage extends StatefulWidget {
  const CategoryInfoPage({Key? key}) : super(key: key);
  @override
  _CategoryInfoPageState createState() => _CategoryInfoPageState();
}

class _CategoryInfoPageState extends State<CategoryInfoPage> {
  Icon searchBarIcon = const Icon(Icons.search);
  Widget searchBar = const Text('Search country by name');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ListView(
            children: [
              CategoryInfo("Population Over 65"),
              CategoryInfo("Population Under 18"),
            ],
          ),
        ),
      ),
    );
  }
}
