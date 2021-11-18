import 'package:flutter/material.dart';

//State for CategoryInfo Page
// State for Home Page
class CategoryInfoPage extends StatefulWidget {
  const CategoryInfoPage(
      {Key? key,
      required this.category,
      required this.country,
      required this.callback,})
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
      body: Center(
        child: ListView(
          children: [
            Container(
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                ),
                margin: EdgeInsets.only(bottom: 10),
                height: 30,
                alignment: Alignment.center,
                child: Text(
                  widget.category,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                )),

            /*
            Container(
              child: ListView(
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: widget.indicators
                    .map(
                      (indicator) => Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 4,
                              blurRadius: 3,
                              offset:
                                  Offset(0, 1), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.fromLTRB(30.0, 0.0, 0, 0),
                            ),
                          ),
                          onPressed: () {
                            _showSimpleModalDialog(
                                context,
                                indicator.value,
                                indicator.index,
                                indicator.units,
                                indicator.category,
                                indicator.country,
                                indicator.source);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 8, 6, 8),
                                width: 180,
                                alignment: Alignment.centerLeft,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          indicator.category,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          indicator.index,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          (indicator.units != "N/A")
                                              ? indicator.units
                                              : "",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Text(
                                    indicator.value,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            )
            */
          ],
        ),
      ),
    );
  }
}

_showSimpleModalDialog(context, String value, String index, String units,
    String category, String country, String source) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
        child: Container(
          constraints: BoxConstraints(maxHeight: 350),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 350,
                child: Row(
                  children: [
                    Positioned(
                      left: 0.0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Icon(Icons.close, color: Colors.white),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        country,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                color: Colors.blue,
              ),
              Container(
                width: 350,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    category,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
                color: Colors.blue[400],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    text: index,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Colors.black,
                      wordSpacing: 1,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                width: 350,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: value,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 45,
                        color: Colors.black,
                        wordSpacing: 1),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    text: units == "N/A" ? "" : units,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Colors.black,
                      wordSpacing: 1,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    text: "Source: " + source,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                      color: Colors.black,
                      wordSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
