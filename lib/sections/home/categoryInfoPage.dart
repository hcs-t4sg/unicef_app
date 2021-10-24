import 'package:flutter/material.dart';

//State for CategoryInfo Page
// State for Home Page
class CategoryInfoPage extends StatefulWidget {
  const CategoryInfoPage(
      {Key? key,
      required this.category,
      required this.country,
      required this.callback})
      : super(key: key);
  final String category;
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
          Text(widget.country),
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
                  searchBar = Text(widget.country);
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
                child: AppBar(
                  toolbarHeight: 40,
                  backgroundColor: Colors.lightGreen[900],
                  title: Text(
                    widget.category,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  automaticallyImplyLeading: false,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(50, 20, 50, 10),
                child: ElevatedButton(
                  onPressed: () {
                    _showSimpleModalDialog(context);
                  },
                  child: Text(
                    'Population Over 65',
                    style: TextStyle(height: 2.5, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(50, 10, 50, 20),
                child: ElevatedButton(
                  onPressed: () {
                    _showSimpleModalDialog(context);
                  },
                  child: Text(
                    'Population Over 18',
                    style: TextStyle(height: 2.5, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
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
                  AppBar(
                    title: Text("Afghanistan"),
                    leading: Icon(
                      Icons.cancel,
                    ),
                  ),
                  AppBar(
                    toolbarHeight: 40,
                    backgroundColor: Colors.lightGreen[900],
                    title: Text(
                      "Population",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    automaticallyImplyLeading: false,
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                          text: "Population under 18",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              color: Colors.black,
                              wordSpacing: 1)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "17,767",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 30,
                                color: Colors.black,
                                wordSpacing: 1)),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                          text: "thousands of people",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Colors.grey[800],
                              wordSpacing: 1)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                          text: "Source: NSIA",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Colors.grey[800],
                              wordSpacing: 1)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
