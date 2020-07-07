import 'package:another_flutter/widgets/todo_widget.dart';
import 'package:flutter/material.dart';
import 'package:another_flutter/widgets/cases_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final PageStorageBucket bucket = PageStorageBucket();

  static List<Widget> _widgetOptions = <Widget>[
    CasesWidget(key: PageStorageKey('CasesWidget')),
    TodoWidget(key: PageStorageKey('TodoWidget')),
  ];

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          )
        ],
      ),
      body: PageStorage(
        bucket: bucket,
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.book), title: Text('案例')),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance), title: Text('法规')),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
