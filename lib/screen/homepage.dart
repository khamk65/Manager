
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:manage/screen/apps.dart';
import 'package:manage/screen/chat_screen.dart';
import 'package:manage/screen/stream.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/main_app';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  int page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (i) => setState(
          () => _currentIndex = i,
        ),
        selectedItemColor: Colors.blue[500],
        unselectedItemColor: Colors.grey[400],
        showUnselectedLabels: true,
        iconSize: 24,
        selectedLabelStyle: TextStyle(fontSize: 12, color: Colors.blue[500]),
        unselectedLabelStyle: TextStyle(fontSize: 12, color: Colors.grey[400]),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.house,
              size: 20,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.grid_3x3,
              size: 20,
            ),
            label: "Control",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
              size: 20,
            ),
            label: "Class",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.solidUser,
              size: 20,
            ),
            label: "Profile",
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          Apps(),
          //Notification(),
          ChatScreen(),
          StreamExample(),
          Container(),
        ],
      ),
    );
  }
}
