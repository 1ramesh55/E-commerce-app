import 'package:ecommerce/screen/constants.dart';
import 'package:ecommerce/widgets/ButtomTabs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late PageController _tabsPageController;
  int _selectedTab = 0;
  @override
  void initState() {
    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        SingleChildScrollView(
          child: Expanded(
            child: PageView(
              controller: _tabsPageController,
              onPageChanged: (num) {
                setState(() {
                  _selectedTab = num;
                });
              },
              children: [
                Container(
                  child: Center(
                    child: Text('Homepage'),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text('Search'),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text('saved'),
                  ),
                )
              ],
            ),
          ),
        ),
        ButtomTabs(
          selectedTab: _selectedTab,
          tabPressed: (num) {
            _tabsPageController.animateToPage(num,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeOutCubic);
          },
        )
      ]),
    ]));
  }
}
