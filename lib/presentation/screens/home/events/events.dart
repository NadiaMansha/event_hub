import 'package:flutter/material.dart';

class UserEvents extends StatefulWidget {
  const UserEvents({super.key});

  @override
  State<UserEvents> createState() => _UserEventsState();
}

class _UserEventsState extends State<UserEvents> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Upcomig',
              ),
              Tab(
                text: 'Past',
              ),
            ],
          ),
          title: const Text(' Events',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold)),
        ),
        body: const TabBarView(
          children: [
            Center(
              child: Text('Upcoming Events'),
            ),
            Center(
              child: Text('Past Events'),
            ),
          ],
        ),
      ),
    );
  }
}
