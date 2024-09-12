// To parse this JSON data, do
//
//     final personalInfoStatusModel = personalInfoStatusModelFromJson(jsonString);

import 'dart:convert';

PersonalInfoStatusModel personalInfoStatusModelFromJson(String str) => PersonalInfoStatusModel.fromJson(json.decode(str));

String personalInfoStatusModelToJson(PersonalInfoStatusModel data) => json.encode(data.toJson());

class PersonalInfoStatusModel {
  bool? status;
  String? identificationNo;
  String? address;
  String? city;
  String? state;
  String? postalCode;
  String? mediaFrontIcUrl;
  String? mediaBackIcUrl;
  bool? checklistStatus;
  String? name;
  String? mobile;
  String? email;

  PersonalInfoStatusModel({
    this.status,
    this.identificationNo,
    this.address,
    this.city,
    this.state,
    this.postalCode,
    this.mediaFrontIcUrl,
    this.mediaBackIcUrl,
    this.checklistStatus,
    this.name,
    this.mobile,
    this.email,
  });

  factory PersonalInfoStatusModel.fromJson(Map<String, dynamic> json) => PersonalInfoStatusModel(
    status: json["status"],
    identificationNo: json["identification_no"],
    address: json["address"],
    city: json["city"],
    state: json["state"],
    postalCode: json["postal_code"],
    mediaFrontIcUrl: json["media_front_ic_url"],
    mediaBackIcUrl: json["media_back_ic_url"],
    checklistStatus: json["checklist_status"],
    name: json["name"],
    mobile: json["mobile"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "identification_no": identificationNo,
    "address": address,
    "city": city,
    "state": state,
    "postal_code": postalCode,
    "media_front_ic_url": mediaFrontIcUrl,
    "media_back_ic_url": mediaBackIcUrl,
    "checklist_status": checklistStatus,
    "name": name,
    "email": email,
    "mobile": mobile,
  };
}
