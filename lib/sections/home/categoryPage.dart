import 'package:flutter/material.dart';
import './categoryTag.dart';

//State for Category Page
// State for Home Page
class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  Icon searchBarIcon = const Icon(Icons.search);
  Widget searchBar = const Text('Search category by name');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ListView(
            children: [CategoryTag("Population"), CategoryTag("Mortality")],
          ),
        ),
      ),
    );
  }
}
