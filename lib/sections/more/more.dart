import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import './help.dart';

class MorePage extends StatefulWidget {
  MorePage({
    Key? key,
  });

  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'More',
          ),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: 'SOURCES'),
              Tab(text: 'HELP'),
              Tab(text: 'ABOUT US'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                child: Center(
                  child: Column(
                    children: [
                      Text("This is the page with extra info",
                          textScaleFactor: 2),
                      Icon(MdiIcons.helpCircleOutline,
                          size: 150, color: Colors.blue),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: HelpPage(),
            ),
            Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                child: Center(
                  child: Column(
                    children: [
                      Text("This is the page with extra info",
                          textScaleFactor: 2),
                      Icon(MdiIcons.helpCircleOutline,
                          size: 150, color: Colors.blue),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
