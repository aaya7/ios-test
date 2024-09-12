// To parse this JSON data, do
//
//     final dropdownModel = dropdownModelFromJson(jsonString);

import 'dart:convert';

List<DropdownModel> dropdownModelFromJson(String str) => List<DropdownModel>.from(json.decode(str).map((x) => DropdownModel.fromJson(x)));

String dropdownModelToJson(List<DropdownModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DropdownModel {
  String? uuid;
  String? name;
  String? code;
  String? logoURL;
  int? isFullTime;

  DropdownModel({
    this.uuid,
    this.name,
    this.code,
    this.logoURL,
    this.isFullTime,
  });

  factory DropdownModel.fromJson(Map<String, dynamic> json) => DropdownModel(
    uuid: json["uuid"],
    name: json["name"],
    code: json["code"] ?? (json["value"]),
    logoURL: json["logo_url"],
    isFullTime: json["is_full_time"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "name": name,
    "code": code,
    "logo_url": logoURL,
    "is_full_time": isFullTime,
  };
}
