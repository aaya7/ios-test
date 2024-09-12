// To parse this JSON data, do
//
//     final vehicleInfoStatusModel = vehicleInfoStatusModelFromJson(jsonString);

import 'dart:convert';

VehicleInfoStatusModel vehicleInfoStatusModelFromJson(String str) => VehicleInfoStatusModel.fromJson(json.decode(str));

String vehicleInfoStatusModelToJson(VehicleInfoStatusModel data) => json.encode(data.toJson());

class VehicleInfoStatusModel {
  List<Transportation>? transportations;
  bool? checklistStatus;

  VehicleInfoStatusModel({
    this.transportations,
    this.checklistStatus,
  });

  factory VehicleInfoStatusModel.fromJson(Map<String, dynamic> json) => VehicleInfoStatusModel(
    transportations: json["transportations"] == null ? [] : List<Transportation>.from(json["transportations"]!.map((x) => Transportation.fromJson(x))),
    checklistStatus: json["checklist_status"],
  );

  Map<String, dynamic> toJson() => {
    "transportations": transportations == null ? [] : List<dynamic>.from(transportations!.map((x) => x.toJson())),
    "checklist_status": checklistStatus,
  };
}

class Transportation {
  String? uuid;
  String? transportationType;
  String? model;
  String? plateNumber;
  String? color;
  String? year;
  String? roadTaxExpiryDate;
  String? transportationPhoto;
  String? roadTaxPhoto;

  Transportation({
    this.uuid,
    this.transportationType,
    this.model,
    this.plateNumber,
    this.color,
    this.year,
    this.roadTaxExpiryDate,
    this.transportationPhoto,
    this.roadTaxPhoto,
  });

  factory Transportation.fromJson(Map<String, dynamic> json) => Transportation(
    uuid: json["uuid"],
    transportationType: json["transportation_type"],
    model: json["model"],
    plateNumber: json["plate_number"],
    color: json["color"],
    year: json["year"],
    roadTaxExpiryDate: json["road_tax_expiry_date"],
    transportationPhoto: json["transportation_photo"],
    roadTaxPhoto: json["road_tax_photo"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "transportation_type": transportationType,
    "model": model,
    "plate_number": plateNumber,
    "color": color,
    "year": year,
    "road_tax_expiry_date": roadTaxExpiryDate,
    "transportation_photo": transportationPhoto,
    "road_tax_photo": roadTaxPhoto,
  };
}
