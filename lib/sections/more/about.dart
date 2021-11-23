import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AboutPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      child: Image.asset(
                        'assets/unicef.png',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Container(
                      child: Text(
                        "UNICEF",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text(
                        "UNICEF’s Regional Office for South Asia works with all eight Country Offices to help design, deliver, and demonstrate results for children in the region.",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 12),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      padding: EdgeInsets.fromLTRB(10.0, 10, 10, 0.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(color: Colors.grey, width: 0.5),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Icon(MdiIcons.facebook,
                                color: Colors.blue, size: 30),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Icon(MdiIcons.twitter,
                                color: Colors.blue, size: 30),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Icon(MdiIcons.web,
                                color: Colors.blue, size: 30),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Icon(MdiIcons.phoneOutline,
                                color: Colors.blue, size: 30),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      child: Image.asset(
                        'assets/t4sg_logo.png',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    Container(
                      child: Text(
                        "Tech for Social Good",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text(
                        "This app was developed by Harvard Computer Society Tech for Social Good. T4SG leverages Harvard talent to partner with nonprofits, government agencies, and social impact organizations to amplify their impact through technology.",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 12),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin:
                          EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
                      padding: EdgeInsets.fromLTRB(10.0, 10, 10, 0.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(color: Colors.grey, width: 0.5),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Icon(MdiIcons.facebook,
                                color: Colors.blue, size: 30),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Icon(MdiIcons.web,
                                color: Colors.blue, size: 30),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
