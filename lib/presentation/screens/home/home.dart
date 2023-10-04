import 'package:event_hub/constants/app_colors.dart';
import 'package:event_hub/presentation/screens/home/events/add_event.dart';
import 'package:event_hub/presentation/screens/home/events/events.dart';
import 'package:event_hub/presentation/screens/home/events/fetch_events.dart';
import 'package:event_hub/presentation/screens/home/profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/login.dart';
import 'events/bookmarks.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    const Events(),
    const UserEvents(),
    const Text(''),
    const Bookmarks(),
    const Profile()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          currentIndex: _currentIndex,
          selectedItemColor: AppColors().primary,
          unselectedItemColor: Colors.grey,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image.asset('assets/images/compass.png'),
              label: 'Explore',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/images/calendar.png',
                  color: AppColors().primary),
              label: 'Events',
              backgroundColor: Colors.white,
            ),
            const BottomNavigationBarItem(icon: SizedBox(), label: ''),
            const BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border_outlined),
              label: 'bookmarks',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/images/profile.png',
                  color: AppColors().primary),
              label: 'Profile',
              backgroundColor: Colors.white,
            ),
          ],
        ),
        body: _children[_currentIndex],
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddEvent()));
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: AppColors().primary,
          child: Image.asset(
            'assets/images/add.png',
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: AppColors().primary,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {},
              ),
              ListTile(
                title: const Text('Logout'),
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance()
                          as SharedPreferences;
                  prefs.clear();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                },
              ),
            ],
          ),
        ));
  }
}
