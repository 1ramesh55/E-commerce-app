import 'package:flutter/material.dart';

class ButtomTabs extends StatefulWidget {
  final int? selectedTab;
  final Function(int)? tabPressed;

  const ButtomTabs({Key? key, this.selectedTab, this.tabPressed})
      : super(key: key);

  @override
  _ButtomTabsState createState() => _ButtomTabsState();
}

class _ButtomTabsState extends State<ButtomTabs> {
  int _selectedTab = 0;
  @override
  void initState() {
    _selectedTab = widget.selectedTab ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.selectedTab ?? 0;

    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                spreadRadius: 1.0,
                blurRadius: 30.0,
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtomTabbtn(
              imagePath: 'assets/images/tab_home.png',
              selected: _selectedTab == 0 ? true : false,
              onPressed: () {
                //setState(() {});
                widget.tabPressed!(0);
              },
            ),
            ButtomTabbtn(
              imagePath: 'assets/images/tab_search.png',
              selected: _selectedTab == 1 ? true : false,
              onPressed: () {
                widget.tabPressed!(1);
              },
            ),
            ButtomTabbtn(
              imagePath: 'assets/images/tab_saved.png',
              selected: _selectedTab == 2 ? true : false,
              onPressed: () {
                widget.tabPressed!(2);
              },
            ),
            ButtomTabbtn(
              imagePath: 'assets/images/tab_logout.png',
              selected: _selectedTab == 3 ? true : false,
              onPressed: () {
                widget.tabPressed!(3);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ButtomTabbtn extends StatelessWidget {
  const ButtomTabbtn(
      {Key? key, this.imagePath, required this.selected, this.onPressed})
      : super(key: key);
  final String? imagePath;
  final bool? selected;
  final Function? onPressed;
  @override
  Widget build(BuildContext context) {
    bool _selected = selected ?? false;
    return GestureDetector(
      onTap: onPressed!(),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 28.0,
          vertical: 24.0,
        ),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: _selected
                        ? Theme.of(context).accentColor
                        : Colors.transparent,
                    width: 2.0))),
        child: Image(
          image: AssetImage(imagePath ?? 'assets/images/tab_home.png'),
          width: 26.0,
          height: 26.0,
          color: _selected ? Theme.of(context).accentColor : Colors.black,
        ),
      ),
    );
  }
}
