// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  PaymentOption? paymentOption;
  String? id;
  String? username;
  String? email;
  String? password;
  String? role;
  String? createdAt;
  num? v;
  String? city;
  String? state;
  String? country;
  num? latitud;
  num? longitude;
  String? avatar;
  bool? isEmailNotificationEnabled;
  bool? isPushNotificationEnabled;
  String? name;
  List<dynamic>? tickets;
  String? fcm;
  bool? isBussinessApproved;
  List<String>? communities;
  List<dynamic>? events;

  User({
    this.paymentOption,
    this.id,
    this.username,
    this.email,
    this.password,
    this.role,
    this.createdAt,
    this.v,
    this.city,
    this.state,
    this.country,
    this.latitud,
    this.longitude,
    this.avatar,
    this.isEmailNotificationEnabled,
    this.isPushNotificationEnabled,
    this.name,
    this.tickets,
    this.fcm,
    this.isBussinessApproved,
    this.communities,
    this.events,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        paymentOption: json["paymentOption"] == null
            ? null
            : PaymentOption.fromJson(json["paymentOption"]),
        id: json["_id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        role: json["role"] ?? '',
        country: json["country"] ?? '',
        state: json["state"] ?? '',
        city: json["city"] ?? '',
        longitude: json["longitude"] ?? 0,
        latitud: json["latitude"] ?? 0,
        avatar: json["avatar"] ?? '',
        isPushNotificationEnabled: json["isPushNotificationEnabled"] ?? false,
        isEmailNotificationEnabled: json["isEmailNotificationEnabled"] ?? false,
        createdAt: json["createdAt"],
        tickets: json["tickets"] == null
            ? []
            : List<Ticket>.from(json["tickets"].map((x) => Ticket.fromJson(x))),
        v: json["__v"],
        fcm: json["fcm"],
        isBussinessApproved: json["isBussinessApproved"] ?? false,
        communities: json["communities"] == null
            ? []
            : List<String>.from(json["communities"].map((x) => x)),
        events: json["events"] == null
            ? []
            : List<dynamic>.from(json["events"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "paymentOption": paymentOption!.toJson(),
        "_id": id,
        "name": name,
        "username": username,
        "email": email,
        "password": password,
        "role": role,
        "country": country,
        "state": state,
        "city": city,
        "longitude": longitude,
        "latitude": latitud,
        "avatar": avatar,
        "isPushNotificationEnabled": isPushNotificationEnabled,
        "isEmailNotificationEnabled": isEmailNotificationEnabled,
        "createdAt": createdAt,
        "tickets": List<dynamic>.from(tickets!.map((x) => x.toJson())),
        "__v": v,
        "fcm": fcm,
        "isBussinessApproved": isBussinessApproved,
        "communities": communities,
        "events": events
      };
}

class BankDetails {
  String? accountNumber;
  String? bankName;
  String? iban;

  BankDetails({
    this.accountNumber,
    this.bankName,
    this.iban,
  });

  factory BankDetails.fromJson(Map<String, dynamic> json) => BankDetails(
        accountNumber: json["accountNumber"],
        bankName: json["bankName"],
        iban: json["IBAN"],
      );

  Map<String, dynamic> toJson() => {
        "accountNumber": accountNumber,
        "bankName": bankName,
        "IBAN": iban,
      };
}

class PaymentOption {
  String? token;
  String? customerId;

  PaymentOption({
    this.token,
    this.customerId,
  });

  factory PaymentOption.fromJson(Map<String, dynamic> json) => PaymentOption(
        token: json["token"],
        customerId: json["customerId"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "customerId": customerId,
      };
}

class Ticket {
  List<String>? ticketImage;
  String? id;
  String? ticketId;

  Ticket({
    this.ticketImage,
    this.id,
    this.ticketId,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        ticketImage: List<String>.from(json["ticketImage"].map((x) => x)),
        id: json["_id"],
        ticketId: json["ticketId"],
      );

  Map<String, dynamic> toJson() => {
        "ticketImage": ticketImage,
        "_id": id,
        "ticketId": ticketId,
      };
}
