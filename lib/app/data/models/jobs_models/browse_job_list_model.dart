// To parse this JSON data, do
//
//     final browseJobListModel = browseJobListModelFromJson(jsonString);

import 'dart:convert';

List<BrowseJobListModel> browseJobListModelFromJson(String str) => List<BrowseJobListModel>.from(json.decode(str).map((x) => BrowseJobListModel.fromJson(x)));

String browseJobListModelToJson(List<BrowseJobListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BrowseJobListModel {
  String? uuid;
  String? locationName;
  String? merchantName;
  String? merchantCode;
  String? productRoleName;
  String? productName;
  String? productCategory;
  int? isFullTime;
  String? city;
  String? merchantLogoUrl;

  BrowseJobListModel({
    this.uuid,
    this.locationName,
    this.merchantName,
    this.merchantCode,
    this.productRoleName,
    this.productName,
    this.productCategory,
    this.isFullTime,
    this.city,
    this.merchantLogoUrl,
  });

  factory BrowseJobListModel.fromJson(Map<String, dynamic> json) => BrowseJobListModel(
    uuid: json["uuid"],
    locationName: json["location_name"],
    merchantName: json["merchant_name"],
    merchantCode: json["merchant_code"],
    productRoleName: json["product_role_name"],
    productName: json["product_name"],
    productCategory: json["product_category"],
    isFullTime: json["is_full_time"],
    city: json["city"],
    merchantLogoUrl: json["merchant_logo_url"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "location_name": locationName,
    "merchant_name": merchantName,
    "merchant_code": merchantCode,
    "product_role_name": productRoleName,
    "product_name": productName,
    "product_category": productCategory,
    "is_full_time": isFullTime,
    "city": city,
    "merchant_logo_url": merchantLogoUrl,
  };
}
