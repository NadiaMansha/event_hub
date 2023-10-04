import 'dart:convert';
import 'dart:io';

import 'package:event_hub/data/models/all_events.dart';
import 'package:event_hub/data/models/event.dart';
import 'package:event_hub/presentation/screens/home/events/bookmarks.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/token.dart';
import '../models/bookmark.dart';

class EventRepository {
  String url = 'http://107.21.221.2:5000/events';
  final Token token = Token();
  //get all events
  Future<AllEvents> getAllEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('token');

    final response = await http
        .get(Uri.parse('$url/getAllEvents?lat=43&lng=34'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == 200) {
      var res = const JsonCodec().decode(response.body);

      return AllEvents.fromJson(res);
    } else {
      print(response.body);
      throw Exception('Failed to load events');
    }
  }

  //create event
  Future<Map> createEvent(
      {required String name,
      required String description,
      required DateTime date,
      required String startTime,
      required String endTime,
      required String address,
      required String price,
      required String capacity,
      required File image}) async {
    String token = await this.token.getToken();
    String formattedDate = date.toIso8601String();
    final request =
        http.MultipartRequest('POST', Uri.parse('$url/createEvent'));

    request.fields.addAll({
      'name': name,
      'description': description,
      'date': formattedDate,
      'startTime': startTime,
      'endTime': endTime,
      'address': address,
      'price': price,
      'capacity': capacity,
    });
    request.files.add(await http.MultipartFile.fromPath('image', image.path));

    request.headers.addEntries([
      MapEntry('Authorization', 'Bearer $token'),
    ]);

    final http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode == 201) {
      return {
        'status': true,
        'message': 'Event created successfully',
      };
    } else {
      var res = const JsonCodec().decode(response.body);
      print(res);
      throw Exception('Failed to create event');
    }
  }

  //bookmark event
  Future<Map> bookmarkEvent({required String eventId}) async {
    String token = await this.token.getToken();

    final response = await http.put(
      Uri.parse('$url/saveEvent/$eventId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      return {
        'status': true,
        'message': 'Event bookmarked successfully',
      };
    } else {
      var res = const JsonCodec().decode(response.body);
      print(res);
      throw Exception('Failed to bookmark event');
    }
  }

  //unbookmark event
  Future<Map> unbookmarkEvent({required String eventId}) async {
    String token = await this.token.getToken();

    final response = await http.put(
      Uri.parse('$url/unsaveEvent/$eventId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      return {
        'status': true,
        'message': 'Event unbookmarked successfully',
      };
    } else {
      var res = const JsonCodec().decode(response.body);
      print(res);
      throw Exception('Failed to unbookmark event');
    }
  }

  //get bookmarked events
  Future<List<Datum>> getBookmarkedEvents() async {
    String token = await this.token.getToken();
    final response = await http.get(Uri.parse('$url/getSavedEvents'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == 200) {
      var res = const JsonCodec().decode(response.body);
      var data = res['data'];

      List<Datum> bookmarks = [];
      for (var item in data) {
        bookmarks.add(Datum.fromMap(item));
      }
      return bookmarks;
    } else {
      print(response.body);
      throw Exception('Failed to load events');
    }
  }
}
