// To parse this JSON data, do
//
//     final emergencyContactStatusModel = emergencyContactStatusModelFromJson(jsonString);

import 'dart:convert';

EmergencyContactStatusModel emergencyContactStatusModelFromJson(String str) => EmergencyContactStatusModel.fromJson(json.decode(str));

String emergencyContactStatusModelToJson(EmergencyContactStatusModel data) => json.encode(data.toJson());

class EmergencyContactStatusModel {
  bool? checklistStatus;
  String? nextOfKinName;
  String? nextOfKinRelationship;
  String? nextOfKinMobile;
  String? nextOfKinAddress;
  String? nextOfKinNric;
  String? nextOfKinNameFrontIcUrl;
  String? nextOfKinNameBackIcUrl;
  String? secondaryNextOfKinName;
  String? secondaryNextOfKinNric;
  String? secondaryNextOfKinMobile;
  String? secondaryNextOfKinAddress;
  String? secondaryNextOfKinRelationship;
  String? secondaryNextOfKinFrontIcUrl;
  String? secondaryNextOfKinBackIcUrl;

  EmergencyContactStatusModel({
    this.checklistStatus,
    this.nextOfKinName,
    this.nextOfKinRelationship,
    this.nextOfKinMobile,
    this.nextOfKinAddress,
    this.nextOfKinNric,
    this.nextOfKinNameFrontIcUrl,
    this.nextOfKinNameBackIcUrl,
    this.secondaryNextOfKinName,
    this.secondaryNextOfKinNric,
    this.secondaryNextOfKinMobile,
    this.secondaryNextOfKinAddress,
    this.secondaryNextOfKinRelationship,
    this.secondaryNextOfKinFrontIcUrl,
    this.secondaryNextOfKinBackIcUrl,
  });

  factory EmergencyContactStatusModel.fromJson(Map<String, dynamic> json) => EmergencyContactStatusModel(
    checklistStatus: json["checklist_status"],
    nextOfKinName: json["next_of_kin_name"],
    nextOfKinRelationship: json["next_of_kin_relationship"],
    nextOfKinMobile: json["next_of_kin_mobile"],
    nextOfKinAddress: json["next_of_kin_address"],
    nextOfKinNric: json["next_of_kin_nric"],
    nextOfKinNameFrontIcUrl: json["next_of_kin_name_front_ic_url"],
    nextOfKinNameBackIcUrl: json["next_of_kin_name_back_ic_url"],
    secondaryNextOfKinName: json["secondary_next_of_kin_name"],
    secondaryNextOfKinNric: json["secondary_next_of_kin_nric"],
    secondaryNextOfKinMobile: json["secondary_next_of_kin_mobile"],
    secondaryNextOfKinAddress: json["secondary_next_of_kin_address"],
    secondaryNextOfKinRelationship: json["secondary_next_of_kin_relationship"],
    secondaryNextOfKinFrontIcUrl: json["secondary_next_of_kin_front_ic_url"],
    secondaryNextOfKinBackIcUrl: json["secondary_next_of_kin_back_ic_url"],
  );

  Map<String, dynamic> toJson() => {
    "checklist_status": checklistStatus,
    "next_of_kin_name": nextOfKinName,
    "next_of_kin_relationship": nextOfKinRelationship,
    "next_of_kin_mobile": nextOfKinMobile,
    "next_of_kin_address": nextOfKinAddress,
    "next_of_kin_nric": nextOfKinNric,
    "next_of_kin_name_front_ic_url": nextOfKinNameFrontIcUrl,
    "next_of_kin_name_back_ic_url": nextOfKinNameBackIcUrl,
    "secondary_next_of_kin_name": secondaryNextOfKinName,
    "secondary_next_of_kin_nric": secondaryNextOfKinNric,
    "secondary_next_of_kin_mobile": secondaryNextOfKinMobile,
    "secondary_next_of_kin_address": secondaryNextOfKinAddress,
    "secondary_next_of_kin_relationship": secondaryNextOfKinRelationship,
    "secondary_next_of_kin_front_ic_url": secondaryNextOfKinFrontIcUrl,
    "secondary_next_of_kin_back_ic_url": secondaryNextOfKinBackIcUrl,
  };
}
