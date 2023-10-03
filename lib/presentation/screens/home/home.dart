import 'package:event_hub/constants/app_colors.dart';
import 'package:event_hub/presentation/screens/home/events/add_event.dart';
import 'package:event_hub/presentation/screens/home/events/fetch_events.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    const Events(),
    const Text('Events'),
    const Text(''),
    const Text('bookmarks'),
    const Text('Profile'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          backgroundColor: AppColors().primary,
          centerTitle: true,
          title: const Column(children: [
            Text('Current Location',
                style: TextStyle(fontSize: 13, color: Colors.white)),
            Text('New York, USA',
                style: TextStyle(fontSize: 16, color: Colors.white)),
          ]),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Image.asset('assets/images/menu.png'),
                color: Colors.redAccent,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Image.asset('assets/images/bell.png',
                  width: 40, height: 80, color: Colors.white),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 300,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        Image.asset('assets/images/search.png',
                            width: 20, height: 20, color: Colors.black),
                        const SizedBox(width: 10),
                        const Text('Search',
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
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
