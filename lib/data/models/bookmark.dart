// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:event_hub/data/models/event.dart';

class Datum {
  String? id;
  String? user;
  Event? event;
  DateTime? date;
  int? v;

  Datum({
    this.id,
    this.user,
    this.event,
    this.date,
    this.v,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user': user,
      'event': event?.toJson(),
      'date': date?.millisecondsSinceEpoch,
      'v': v,
    };
  }

  factory Datum.fromMap(Map<String, dynamic> map) {
    return Datum(
      id: map['id'] != null ? map['_id'] as String : null,
      user: map['user'] != null ? map['user'] as String : null,
      event: map['event'] != null
          ? Event.fromJson((map['event']) as Map<String, dynamic>)
          : null,
      date: map['date'] != null
          ? map['date'] is String
              ? DateTime.parse(map['date'].toString())
              : DateTime.fromMillisecondsSinceEpoch(
                  map['date'] as int,
                )
          : null,
      v: map['v'] != null ? map['v'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Datum.fromJson(String source) =>
      Datum.fromMap(json.decode(source) as Map<String, dynamic>);
}
