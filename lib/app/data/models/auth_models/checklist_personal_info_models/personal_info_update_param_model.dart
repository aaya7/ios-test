// To parse this JSON data, do
//
//     final personalInfoUpdateParam = personalInfoUpdateParamFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

PersonalInfoUpdateParam personalInfoUpdateParamFromJson(String str) => PersonalInfoUpdateParam.fromJson(json.decode(str));

String personalInfoUpdateParamToJson(PersonalInfoUpdateParam data) => json.encode(data.toJson());

class PersonalInfoUpdateParam {
  String? identificationNo;
  String? address;
  String? state;
  String? city;
  String? postalCode;
  String? name;
  String? mobile;
  File? icFrontImage;
  File? icBackImage;

  PersonalInfoUpdateParam({
    this.identificationNo,
    this.address,
    this.state,
    this.city,
    this.postalCode,
    this.icFrontImage,
    this.icBackImage,
    this.name,
    this.mobile,
  });

  factory PersonalInfoUpdateParam.fromJson(Map<String, dynamic> json) => PersonalInfoUpdateParam(
    identificationNo: json["identification_no"],
    address: json["address"],
    state: json["state"],
    city: json["city"],
    postalCode: json["postal_code"],
    icFrontImage: json["ic_front_image"],
    icBackImage: json["ic_back_image"],
    name: json["name"],
    mobile: json["mobile"],
  );

  Map<String, dynamic> toJson() => {
    "identification_no": identificationNo,
    "address": address,
    "state": state,
    "city": city,
    "postal_code": postalCode,
    "ic_front_image": icFrontImage,
    "ic_back_image": icBackImage,
    "mobile": mobile,
    "name": name,
  };
}
