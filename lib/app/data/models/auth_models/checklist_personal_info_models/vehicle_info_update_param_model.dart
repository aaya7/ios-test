// To parse this JSON data, do
//
//     final vehicleInfoUpdateParamModel = vehicleInfoUpdateParamModelFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

VehicleInfoUpdateParamModel vehicleInfoUpdateParamModelFromJson(String str) => VehicleInfoUpdateParamModel.fromJson(json.decode(str));

String vehicleInfoUpdateParamModelToJson(VehicleInfoUpdateParamModel data) => json.encode(data.toJson());

class VehicleInfoUpdateParamModel {
  String? uuid;
  String? transportationTypeId;
  String? model;
  String? plateNumber;
  String? color;
  String? year;
  String? roadTaxExpiryDate;
  File? transportationPhoto;
  File? roadTaxPhoto;

  VehicleInfoUpdateParamModel({
    this.uuid,
    this.transportationTypeId,
    this.model,
    this.plateNumber,
    this.color,
    this.year,
    this.roadTaxExpiryDate,
    this.transportationPhoto,
    this.roadTaxPhoto,
  });

  factory VehicleInfoUpdateParamModel.fromJson(Map<String, dynamic> json) => VehicleInfoUpdateParamModel(
    uuid: json["uuid"],
    transportationTypeId: json["transportation_type_id"],
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
    "transportation_type_id": transportationTypeId,
    "model": model,
    "plate_number": plateNumber,
    "color": color,
    "year": year,
    "road_tax_expiry_date": roadTaxExpiryDate,
    "transportation_photo": transportationPhoto,
    "road_tax_photo": roadTaxPhoto,
  };
}
