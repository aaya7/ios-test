// To parse this JSON data, do
//
//     final notificationDetailsModel = notificationDetailsModelFromJson(jsonString);

import 'dart:convert';

NotificationDetailsModel notificationDetailsModelFromJson(String str) => NotificationDetailsModel.fromJson(json.decode(str));

String notificationDetailsModelToJson(NotificationDetailsModel data) => json.encode(data.toJson());

class NotificationDetailsModel {
  String? uuid;
  String? title;
  String? body;
  String? image;
  dynamic readAt;
  String? createdAt;

  NotificationDetailsModel({
    this.uuid,
    this.title,
    this.body,
    this.image,
    this.readAt,
    this.createdAt,
  });

  factory NotificationDetailsModel.fromJson(Map<String, dynamic> json) => NotificationDetailsModel(
    uuid: json["uuid"],
    title: json["title"],
    body: json["body"],
    image: json["image"],
    readAt: json["read_at"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "title": title,
    "body": body,
    "image": image,
    "read_at": readAt,
    "created_at": createdAt,
  };
}
