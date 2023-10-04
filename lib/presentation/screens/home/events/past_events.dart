import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/app_colors.dart';
import '../../../../data/models/event.dart';
import '../../../../logic/events/cubit/user_events_cubit.dart';

class PastEvents extends StatefulWidget {
  const PastEvents({super.key});

  @override
  State<PastEvents> createState() => _PastEventsState();
}

class _PastEventsState extends State<PastEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer(
            bloc: BlocProvider.of<UserEventsCubit>(context)..getPastEvents(),
            builder: (context, state) {
              if (state is PastEventsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PastEventsLoaded) {
                return ListView.builder(
                    itemCount: state.events.length,
                    itemBuilder: (context, index) {
                      Event event = state.events[index];
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
              if (state is PastEventsError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message!)));
              }
            }));
  }
}
