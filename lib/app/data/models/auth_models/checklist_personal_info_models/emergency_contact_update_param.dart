// To parse this JSON data, do
//
//     final emergencyContactUpdateParam = emergencyContactUpdateParamFromJson(jsonString);

import 'dart:convert';
import 'dart:io';
import 'dart:io';
import 'dart:io';
import 'dart:io';

EmergencyContactUpdateParam emergencyContactUpdateParamFromJson(String str) => EmergencyContactUpdateParam.fromJson(json.decode(str));

String emergencyContactUpdateParamToJson(EmergencyContactUpdateParam data) => json.encode(data.toJson());

class EmergencyContactUpdateParam {
  String? nextOfKinName;
  String? nextOfKinNric;
  String? nextOfKinMobile;
  String? nextOfKinAddress;
  String? nextOfKinRelationship;
  String? secondaryNextOfKinName;
  String? secondaryNextOfKinNric;
  String? secondaryNextOfKinMobile;
  String? secondaryNextOfKinAddress;
  String? secondaryNextOfKinRelationship;
  File? nextOfKinFrontIcPhoto;
  File? nextOfKinBackIcPhoto;
  File? secondaryNextOfKinFrontIcPhoto;
  File? secondaryNextOfKinBackIcPhoto;

  EmergencyContactUpdateParam({
    this.nextOfKinName,
    this.nextOfKinNric,
    this.nextOfKinMobile,
    this.nextOfKinAddress,
    this.nextOfKinRelationship,
    this.secondaryNextOfKinName,
    this.secondaryNextOfKinNric,
    this.secondaryNextOfKinMobile,
    this.secondaryNextOfKinAddress,
    this.secondaryNextOfKinRelationship,
    this.nextOfKinFrontIcPhoto,
    this.nextOfKinBackIcPhoto,
    this.secondaryNextOfKinFrontIcPhoto,
    this.secondaryNextOfKinBackIcPhoto,
  });

  factory EmergencyContactUpdateParam.fromJson(Map<String, dynamic> json) => EmergencyContactUpdateParam(
    nextOfKinName: json["next_of_kin_name"],
    nextOfKinNric: json["next_of_kin_nric"],
    nextOfKinMobile: json["next_of_kin_mobile"],
    nextOfKinAddress: json["next_of_kin_address"],
    nextOfKinRelationship: json["next_of_kin_relationship"],
    secondaryNextOfKinName: json["secondary_next_of_kin_name"],
    secondaryNextOfKinNric: json["secondary_next_of_kin_nric"],
    secondaryNextOfKinMobile: json["secondary_next_of_kin_mobile"],
    secondaryNextOfKinAddress: json["secondary_next_of_kin_address"],
    secondaryNextOfKinRelationship: json["secondary_next_of_kin_relationship"],
    nextOfKinFrontIcPhoto: json["next_of_kin_front_ic_photo"],
    nextOfKinBackIcPhoto: json["next_of_kin_back_ic_photo"],
    secondaryNextOfKinFrontIcPhoto: json["secondary_next_of_kin_front_ic_photo"],
    secondaryNextOfKinBackIcPhoto: json["secondary_next_of_kin_back_ic_photo"],
  );

  Map<String, dynamic> toJson() => {
    "next_of_kin_name": nextOfKinName,
    "next_of_kin_nric": nextOfKinNric,
    "next_of_kin_mobile": nextOfKinMobile,
    "next_of_kin_address": nextOfKinAddress,
    "next_of_kin_relationship": nextOfKinRelationship,
    "secondary_next_of_kin_name": secondaryNextOfKinName,
    "secondary_next_of_kin_nric": secondaryNextOfKinNric,
    "secondary_next_of_kin_mobile": secondaryNextOfKinMobile,
    "secondary_next_of_kin_address": secondaryNextOfKinAddress,
    "secondary_next_of_kin_relationship": secondaryNextOfKinRelationship,
    "next_of_kin_front_ic_photo": nextOfKinFrontIcPhoto,
    "next_of_kin_back_ic_photo": nextOfKinBackIcPhoto,
    "secondary_next_of_kin_front_ic_photo": secondaryNextOfKinFrontIcPhoto,
    "secondary_next_of_kin_back_ic_photo": secondaryNextOfKinBackIcPhoto,
  };
}
