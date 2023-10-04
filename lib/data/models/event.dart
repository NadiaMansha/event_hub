// To parse this JSON data, do
//
//     final event = eventFromJson(jsonString);

import 'dart:convert';

import 'package:event_hub/data/models/user.dart';

Event eventFromJson(String str) => Event.fromJson(json.decode(str));

String eventToJson(Event data) => json.encode(data.toJson());

class Event {
  String? name;
  User? Organiser;
  String? description;
  DateTime? date;
  String? startTime;
  String? endTime;
  String? address;
  double? lat;
  double? lng;
  String? postcode;
  String? city;
  String? state;
  int? price;
  String? image;
  List<dynamic>? users;
  int? capacity;
  List<dynamic>? ratings;

  bool? isSaved;
  bool? isJoined;
  String? status;
  int? seatsBooked;
  String? id;
  int? v;

  Event({
    this.name,
    this.Organiser,
    this.description,
    this.date,
    this.startTime,
    this.endTime,
    this.address,
    this.lat,
    this.lng,
    this.postcode,
    this.city,
    this.state,
    this.price,
    this.image,
    this.users,
    this.capacity,
    this.ratings,
    this.isSaved,
    this.isJoined,
    this.status,
    this.seatsBooked,
    this.id,
    this.v,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        name: json["name"] ?? "",
        Organiser:
            json["Organiser"] != null ? User.fromJson(json["Organiser"]) : null,
        description: json["description"] ?? "",
        date: json['date'] != null
            ? json['date'] is String
                ? DateTime.parse(json['date'].toString())
                : DateTime.fromMillisecondsSinceEpoch(
                    json['date'] as int,
                  )
            : null,
        startTime: json["startTime"] ?? "",
        endTime: json["endTime"] ?? "",
        address: json["address"] ?? "",
        lat: json["lat"] ?? 0.0,
        lng: json["lng"] ?? 0.0,
        postcode: json["postcode"] ?? "",
        city: json["city"] ?? "",
        state: json["state"] ?? "",
        price: json["price"] ?? 0,
        image: json["image"] ?? "",
        users: json["users"] != null
            ? List<dynamic>.from(json["users"].map((x) => x))
            : [],
        ratings: json["ratings"] != null
            ? List<dynamic>.from(json["ratings"].map((x) => x))
            : [],
        isSaved: json["isSaved"] ?? false,
        isJoined: json["isJoined"] ?? false,
        status: json["status"] ?? "",
        seatsBooked: json["seatsBooked"] ?? 0,
        id: json["_id"] ?? "",
        v: json["__v"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "Organiser": Organiser,
        "description": description,
        "date": date.toString(),
        "startTime": startTime,
        "endTime": endTime,
        "address": address,
        "lat": lat,
        "lng": lng,
        "postcode": postcode,
        "city": city,
        "state": state,
        "price": price,
        "images": image ?? "",
        "users": users ?? [],
        "ratings": ratings ?? [],
        "isSaved": isSaved,
        "capacity": capacity,
        "isJoined": isJoined,
        "status": status,
        "seatsBooked": seatsBooked,
        "_id": id,
        "__v": v,
      };
}
