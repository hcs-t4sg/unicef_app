import 'package:flutter/material.dart';
import './help.dart';
import './sources.dart';
import './about.dart';

class MorePage extends StatefulWidget {
  MorePage({
    Key? key,
  });

  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  List<String> _sourceNames = [
    "source1",
    "source2",
    "source3",
    "source1",
    "source2",
    "source3",
    "source1",
    "source2",
    "source3",
    "source1",
    "source2",
    "source3",
  ];
  List<String> _sourceLinks = [
    "link1",
    "link2",
    "link3",
    "link1",
    "link2",
    "link3",
    "link1",
    "link2",
    "link3",
    "link1",
    "link2",
    "link3",
  ];
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
              Tab(text: 'ABOUT US'),
              Tab(text: 'HELP'),
              Tab(text: 'SOURCES'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: AboutPage()),
            Center(
              child: HelpPage(),
            ),
            Center(
              child: SourcesPage(_sourceNames, _sourceLinks),
            ),
          ],
        ),
      ),
    );
  }
}
