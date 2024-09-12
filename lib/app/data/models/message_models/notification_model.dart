// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

List<NotificationModel> notificationModelFromJson(String str) => List<NotificationModel>.from(json.decode(str).map((x) => NotificationModel.fromJson(x)));

String notificationModelToJson(List<NotificationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationModel {
  String? uuid;
  String? title;
  String? body;
  String? image;
  dynamic readAt;
  String? createdAt;

  NotificationModel({
    this.uuid,
    this.title,
    this.body,
    this.image,
    this.readAt,
    this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
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
