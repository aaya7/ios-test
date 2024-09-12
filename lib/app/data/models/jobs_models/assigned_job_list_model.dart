// To parse this JSON data, do
//
//     final assignedJobListModel = assignedJobListModelFromJson(jsonString);

import 'dart:convert';

List<AssignedJobListModel> assignedJobListModelFromJson(String str) => List<AssignedJobListModel>.from(json.decode(str).map((x) => AssignedJobListModel.fromJson(x)));

String assignedJobListModelToJson(List<AssignedJobListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AssignedJobListModel {
  String? uuid;
  String? merchantLogoUrl;
  String? merchantName;
  String? locationName;
  int? assignmentStatusId;
  String? productName;
  String? productRoleName;
  int? isFullTime;
  double? wageAmount;
  String? wageUnit;

  AssignedJobListModel({
    this.uuid,
    this.merchantLogoUrl,
    this.merchantName,
    this.locationName,
    this.assignmentStatusId,
    this.productName,
    this.productRoleName,
    this.isFullTime,
    this.wageUnit,
    this.wageAmount,
  });

  factory AssignedJobListModel.fromJson(Map<String, dynamic> json) => AssignedJobListModel(
    uuid: json["uuid"],
    merchantLogoUrl: json["merchant_logo_url"],
    merchantName: json["merchant_name"],
    locationName: json["location_name"],
    assignmentStatusId: json["assignment_status_id"],
    productName: json["product_name"],
    productRoleName: json["product_role_name"],
    isFullTime: json["is_full_time"],
    wageAmount: json["wage_amount"].toDouble(),
    wageUnit: json["wage_unit"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "merchant_logo_url": merchantLogoUrl,
    "merchant_name": merchantName,
    "location_name": locationName,
    "assignment_status_id": assignmentStatusId,
    "product_name": productName,
    "product_role_name": productRoleName,
    "is_full_time": isFullTime,
    "wage_amount": wageAmount,
    "wage_unit": wageUnit,
  };
}
