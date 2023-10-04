import 'package:event_hub/constants/app_colors.dart';
import 'package:event_hub/data/models/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/cubits/cubit/event_cubit.dart';

class Bookmarks extends StatefulWidget {
  const Bookmarks({super.key});

  @override
  State<Bookmarks> createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Bookmarks',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold)),
        ),
        body: BlocConsumer(
            bloc: BlocProvider.of<EventCubit>(context)..getBookmarkedEvents(),
            builder: (context, state) {
              if (state is BookmarkedEventsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is BookmarkedEventsLoaded) {
                return ListView.builder(
                    itemCount: state.bookmarks.length,
                    itemBuilder: (context, index) {
                      Event event = state.bookmarks[index].event!;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(event.image!,
                                    width: 50, height: 50, fit: BoxFit.cover),
                              ),
                              title: Text(event.name!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20,
                                      color: AppColors().primary)),
                              subtitle: Text(event.date.toString()!),
                              trailing: IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {},
                              )),
                        ),
                      );
                    });
              } else {
                return const Center(child: Text('Something went wrong'));
              }
            },
            listener: (context, state) {
              if (state is BookmarkedEventsError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            }));
  }
}
