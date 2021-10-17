import 'package:flutter/material.dart';

//State for CategoryInfo Page
// State for Home Page
class CategoryInfoPage extends StatefulWidget {
  const CategoryInfoPage(
      {Key? key, required this.country, required this.callback})
      : super(key: key);
  final Function callback;
  final String country;
  @override
  _CategoryInfoPageState createState() => _CategoryInfoPageState();
}

class _CategoryInfoPageState extends State<CategoryInfoPage> {
  Icon searchBarIcon = const Icon(Icons.search);
  Widget searchBar = const Text('Search');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                widget.callback(widget.country);
                Navigator.pop(context);
              }),
          searchBar,
        ]),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (searchBarIcon.icon == Icons.search) {
                  searchBarIcon = const Icon(Icons.cancel);
                  searchBar = const ListTile(
                    leading: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 28,
                    ),
                    title: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for country',
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                } else {
                  searchBarIcon = const Icon(Icons.search);
                  searchBar = const Text('Search country by name');
                }
              });
            },
            icon: searchBarIcon,
          )
        ],
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: ElevatedButton(
                  onPressed: () {
                    _showSimpleModalDialog(context);
                  },
                  child: Text('Population Over 65'),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: ElevatedButton(
                  onPressed: () {
                    _showSimpleModalDialog(context);
                  },
                  child: Text('Population Under 18'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_showSimpleModalDialog(context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Container(
            constraints: BoxConstraints(maxHeight: 350),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: "More Info Here",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.black,
                            wordSpacing: 1)),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
