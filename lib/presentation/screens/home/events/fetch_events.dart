import 'package:event_hub/data/models/event.dart';
import 'package:event_hub/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/app_colors.dart';
import '../../../../data/models/user.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../../../../logic/cubits/cubit/event_cubit.dart';
import 'event_details.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  User? user;

  @override
  void initState() {
    AuthRepository().getLogin().then((value) {
      user = value;
    }).whenComplete(() {
      setState(() {});
    });
    super.initState();
  }

  final ToastMessage toastMessage = ToastMessage();
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
          title: Text(
            'Welcome ${user?.name ?? 'name'}',
            style: const TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.w400),
          ),
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Popular Events',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              BlocConsumer<EventCubit, EventState>(
                bloc: BlocProvider.of<EventCubit>(context)..getAllEvents(),
                listener: (context, state) {
                  if (state is EventError) {
                    toastMessage.failedToast(state.message);
                  }
                },
                builder: (context, state) {
                  if (state is EventLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is EventLoaded) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 320,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.allEvents.popularEvents!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EventDetails(
                                              event: state.allEvents
                                                  .popularEvents![index])));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Container(
                                    width: 250,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 5),
                                          IconButton(
                                            onPressed: () async {
                                              await BlocProvider.of<EventCubit>(
                                                      context)
                                                  .bookmarkEvent(
                                                      id: state
                                                          .allEvents
                                                          .popularEvents![index]
                                                          .id!);
                                            },
                                            icon: state
                                                        .allEvents
                                                        .popularEvents![index]
                                                        .isSaved ==
                                                    true
                                                ? const Icon(
                                                    Icons.bookmark,
                                                    color: Colors.redAccent,
                                                  )
                                                : const Icon(
                                                    Icons
                                                        .bookmark_border_outlined,
                                                    color: Colors.redAccent,
                                                  ),
                                          ),
                                          const SizedBox(height: 1),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              state.allEvents
                                                  .popularEvents![index].image!,
                                              height: 200,
                                              width: 220,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Text(
                                              state.allEvents
                                                  .popularEvents![index].name!,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                              state
                                                  .allEvents
                                                  .popularEvents![index]
                                                  .address!,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          'Nearby Events',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 300,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.allEvents.nearbyEvents!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EventDetails(
                                              event: state.allEvents
                                                  .nearbyEvents![index])));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Container(
                                    width: 250,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 10),
                                          Image.network(
                                            state.allEvents.nearbyEvents![index]
                                                .image!,
                                            height: 200,
                                            width: 200,
                                            fit: BoxFit.cover,
                                          ),
                                          Text(
                                              state.allEvents
                                                  .nearbyEvents![index].name!,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                              state
                                                  .allEvents
                                                  .nearbyEvents![index]
                                                  .address!,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    );
                  } else {
                    return const Center(
                      child: Text('No Events'),
                    );
                  }
                },
              ),
            ],
          ),
        ));
  }
}
