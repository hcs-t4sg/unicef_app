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
    "UNICEF. The State of the World's Children 2019-statistical tables & UNICEF GLobal Data Warehouse. Data.unicef.org",
    "UNDP. 2019 Human Development Report",
    "World Bank. World Development Indicators Database",
    "UNAIDS online AIDSInfo Database",
    "UNDP, Human Development Indices and Indicators",
    "UNESCAP; ADB; UNDP. Making it Happen: Technology, Finance and Statistics for Sustainable Development in Asia and the Pacific. Asia-Pacific Regional MDGs Report. 2014/2015.",
  ];
  List<String> _sourceLinks = [
    "https://data.unicef.org/resources/state-worlds-children-2017-statistical-tables",
    "http://www.hdr.undp.org/sites/default/files/hdr2019.pdf",
    "https://data.worldbank.org/country",
    "https://aidsinfo.unaids.org/",
    "http://hdr.undp.org/en/indicators/21806",
    "https://issuu.com/undpasiapacific/docs/rbap-rmdg-report-2014-2015",
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
