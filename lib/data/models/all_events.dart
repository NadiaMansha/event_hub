// To parse this JSON data, do
//
//     final allEvents = allEventsFromJson(jsonString);

import 'dart:convert';

import 'package:event_hub/data/models/event.dart';

AllEvents allEventsFromJson(String str) => AllEvents.fromJson(json.decode(str));

String allEventsToJson(AllEvents data) => json.encode(data.toJson());

class AllEvents {
  String? message;
  List<Event>? popularEvents;
  List<Event>? nearbyEvents;
  List<Event>? upcomingEvents;

  AllEvents({
    this.message,
    this.popularEvents,
    this.nearbyEvents,
    this.upcomingEvents,
  });

  factory AllEvents.fromJson(Map<String, dynamic> json) => AllEvents(
        message: json["message"],
        popularEvents: json["popularEvents"] == null
            ? []
            : List<Event>.from(
                json["popularEvents"].map((x) => Event.fromJson(x))),
        nearbyEvents: json["nearbyEvents"] == null
            ? []
            : List<Event>.from(
                json["nearbyEvents"].map((x) => Event.fromJson(x))),
        upcomingEvents: json["upcomingEvents"] == null
            ? []
            : List<Event>.from(
                json["upcomingEvents"].map((x) => Event.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "popularEvents": popularEvents ?? [],
        "nearbyEvents": nearbyEvents ?? [],
        "upcomingEvents": upcomingEvents ?? []
      };
}
