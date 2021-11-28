import 'package:flutter/material.dart';
import './help.dart';
import './sources.dart';
import './about.dart';
import './../../model.dart';

class MorePage extends StatefulWidget {
  MorePage({
    Key? key,
  });

  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  List<String> _sourceNames = [];
  List<String> _sourceLinks = [];
  List<String> _sourceIDs = [];

  @override
  void initState() {
    super.initState();
    _getSources();
  }

  void _getSources() async {
    final List<Map> sources = await SQLiteDbProvider.db.getAllSources();
    setState(() {
      _sourceIDs = sources
          .map((source) => (source.values.toList()[0]).toString())
          .toList();
      _sourceNames = sources
          .map((source) => source.values.toList()[1].toString())
          .toList();
      _sourceLinks = sources
          .map((source) => source.values.toList()[2].toString())
          .toList();
    });
  }

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
              child: SourcesPage(
                _sourceIDs,
                _sourceNames,
                _sourceLinks,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
