// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:event_hub/constants/app_colors.dart';
import 'package:event_hub/widgets/button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/event.dart';
import 'buy_ticket.dart';

class EventDetails extends StatefulWidget {
  final Event? event;
  const EventDetails({
    Key? key,
    this.event,
  }) : super(key: key);

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                child: Image(
                  image: NetworkImage(widget.event!.image!),
                  fit: BoxFit.cover,
                  height: 250,
                  width: double.infinity,
                ),
              ),
              Positioned(
                top: 30,
                left: 10,
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Event Details",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.event!.name!,
              style: const TextStyle(
                fontSize: 30,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: 380,
              height: 80,
              child: Card(
                child: Row(children: [
                  const SizedBox(width: 20),
                  Icon(Icons.location_on, size: 30, color: AppColors().primary),
                  const SizedBox(width: 10),
                  Text(
                    widget.event!.address!,
                    style: const TextStyle(fontSize: 20),
                  ),
                ]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: 380,
              height: 80,
              child: Card(
                child: Column(
                  children: [
                    Row(children: [
                      const SizedBox(width: 20),
                      Image.asset('assets/images/calendar.png',
                          height: 30, color: AppColors().primary),
                      const SizedBox(width: 10),
                      Text(
                        widget.event!.date.toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ]),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const SizedBox(width: 40),
                        Text(
                          widget.event!.startTime!,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          widget.event!.endTime!,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'About Event',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.event!.description!,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 10.0),
            child: Button(
                title: 'Buy Ticket ${widget.event!.price}',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BuyTicket()));
                },
                backgroundColor: AppColors().primary,
                foregroundColor: Colors.white,
                isLoading: false),
          ),
          const SizedBox(height: 20),
        ]),
      ),
    ));
  }
}
