import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

const String _twitter_url =
    "https://twitter.com/UNICEFROSA?ref_src=twsrc%5Egoogle%7Ctwcamp%5Eserp%7Ctwgr%5Eauthor";
const String _facebook_url = "https://www.facebook.com/UNICEFSouthAsia/";
const String _site_url = "https://www.unicef.org/rosa/";
const String _phone = "tel:+9779805556200";

class AboutPage extends StatelessWidget {
  void _launchTwitterURL() async {
    if (!await launch(_twitter_url)) throw 'Could not launch $_twitter_url';
  }

  void _launchFacebookURL() async {
    if (!await launch(_facebook_url)) throw 'Could not launch $_facebook_url';
  }

  void _launchSiteURL() async {
    if (!await launch(_site_url)) throw 'Could not launch $_site_url';
  }

  _launchCaller() async {
    if (!await launch(_phone)) throw 'Could not launch $_phone';
  }

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
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 0),
                            child: TextButton(
                              onPressed: _launchFacebookURL,
                              child: Icon(MdiIcons.facebook,
                                  color: Colors.blue, size: 30),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 0),
                            child: TextButton(
                              onPressed: _launchTwitterURL,
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                              ),
                              child: Icon(MdiIcons.twitter,
                                  color: Colors.blue, size: 30),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 0),
                            child: TextButton(
                              onPressed: _launchSiteURL,
                              child: Icon(MdiIcons.web,
                                  color: Colors.blue, size: 30),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 0),
                            child: TextButton(
                              onPressed: _launchCaller,
                              child: Icon(MdiIcons.phoneOutline,
                                  color: Colors.blue, size: 30),
                            ),
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
                    // Container(
                    //   child: Text(
                    //     "Tech for Social Good",
                    //     style: TextStyle(
                    //         fontWeight: FontWeight.bold, fontSize: 20),
                    //   ),
                    // ),
                    // Container(
                    //   padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    //   child: Text(
                    //     "This app was developed by Harvard Computer Society Tech for Social Good. T4SG leverages Harvard talent to partner with nonprofits, government agencies, and social impact organizations to amplify their impact through technology.",
                    //     style: TextStyle(
                    //         fontWeight: FontWeight.w400, fontSize: 12),
                    //   ),
                    // ),
                    // Container(
                    //   width: double.infinity,
                    //   margin:
                    //       EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
                    //   padding: EdgeInsets.fromLTRB(10.0, 10, 10, 0.0),
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     border: Border(
                    //       top: BorderSide(color: Colors.grey, width: 0.5),
                    //     ),
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       Container(
                    //         padding: EdgeInsets.all(5),
                    //         child: Icon(MdiIcons.facebook,
                    //             color: Colors.blue, size: 30),
                    //       ),
                    //       Container(
                    //         padding: EdgeInsets.all(5),
                    //         child: Icon(MdiIcons.web,
                    //             color: Colors.blue, size: 30),
                    //       ),
                    //     ],
                    //   ),
                    // )
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
