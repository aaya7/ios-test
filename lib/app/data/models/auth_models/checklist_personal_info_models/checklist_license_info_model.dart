// To parse this JSON data, do
//
//     final licenseInfoStatusModel = licenseInfoStatusModelFromJson(jsonString);

import 'dart:convert';

LicenseInfoStatusModel licenseInfoStatusModelFromJson(String str) => LicenseInfoStatusModel.fromJson(json.decode(str));

String licenseInfoStatusModelToJson(LicenseInfoStatusModel data) => json.encode(data.toJson());

class LicenseInfoStatusModel {
  bool? checklistStatus;
  License? drivingLicense;
  License? vocationalLicense;

  LicenseInfoStatusModel({
    this.checklistStatus,
    this.drivingLicense,
    this.vocationalLicense,
  });

  factory LicenseInfoStatusModel.fromJson(Map<String, dynamic> json) => LicenseInfoStatusModel(
    checklistStatus: json["checklist_status"],
    drivingLicense: json["driving_license"] == null ? null : License.fromJson(json["driving_license"]),
    vocationalLicense: json["vocational_license"] == null ? null : License.fromJson(json["vocational_license"]),
  );

  Map<String, dynamic> toJson() => {
    "checklist_status": checklistStatus,
    "driving_license": drivingLicense?.toJson(),
    "vocational_license": vocationalLicense?.toJson(),
  };
}

class License {
  String? licenseNumber;
  String? licenseExpiry;
  List<LicenseClass>? licenseClasses;
  String? licensePhoto;

  License({
    this.licenseNumber,
    this.licenseExpiry,
    this.licenseClasses,
    this.licensePhoto,
  });

  factory License.fromJson(Map<String, dynamic> json) => License(
    licenseNumber: json["license_number"],
    licenseExpiry: json["license_expiry"],
    licenseClasses: json["license_classes"] == null ? [] : List<LicenseClass>.from(json["license_classes"]!.map((x) => LicenseClass.fromJson(x))),
    licensePhoto: json["license_photo"],
  );

  Map<String, dynamic> toJson() => {
    "license_number": licenseNumber,
    "license_expiry": licenseExpiry,
    "license_classes": licenseClasses == null ? [] : List<dynamic>.from(licenseClasses!.map((x) => x.toJson())),
    "license_photo": licensePhoto,
  };
}

class LicenseClass {
  String? licenseTypeUuid;
  String? licenseType;

  LicenseClass({
    this.licenseTypeUuid,
    this.licenseType,
  });

  factory LicenseClass.fromJson(Map<String, dynamic> json) => LicenseClass(
    licenseTypeUuid: json["license_type_uuid"],
    licenseType: json["license_type"],
  );

  Map<String, dynamic> toJson() => {
    "license_type_uuid": licenseTypeUuid,
    "license_type": licenseType,
  };
}
