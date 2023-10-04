import 'package:event_hub/presentation/screens/home/events/past_events.dart';
import 'package:event_hub/presentation/screens/home/events/upcoming_events.dart';
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
          bottom: const TabBar(
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
            UpcomingEvents(),
            PastEvents(),
          ],
        ),
      ),
    );
  }
}
