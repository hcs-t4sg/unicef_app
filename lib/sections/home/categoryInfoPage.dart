import 'package:flutter/material.dart';
import './categoryInfo.dart';

// SECOND LAYER
// List of categories (eg. population)
class CategoryInfoPage extends StatelessWidget {
  // No state (like list of countries), return list of tags
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ListView(
          children: [
            CategoryInfo("Population Under 18"),
            CategoryInfo("Population Over 65")
          ],
        ),
      ),
    );
  }
}
