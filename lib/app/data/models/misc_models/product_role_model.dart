// To parse this JSON data, do
//
//     final productRoleModel = productRoleModelFromJson(jsonString);

import 'dart:convert';

ProductRoleModel productRoleModelFromJson(String str) => ProductRoleModel.fromJson(json.decode(str));

String productRoleModelToJson(ProductRoleModel data) => json.encode(data.toJson());

class ProductRoleModel {
  List<Time>? fullTime;
  List<Time>? partTime;

  ProductRoleModel({
    this.fullTime,
    this.partTime,
  });

  factory ProductRoleModel.fromJson(Map<String, dynamic> json) => ProductRoleModel(
    fullTime: json["full_time"] == null ? [] : List<Time>.from(json["full_time"]!.map((x) => Time.fromJson(x))),
    partTime: json["part_time"] == null ? [] : List<Time>.from(json["part_time"]!.map((x) => Time.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "full_time": fullTime == null ? [] : List<dynamic>.from(fullTime!.map((x) => x.toJson())),
    "part_time": partTime == null ? [] : List<dynamic>.from(partTime!.map((x) => x.toJson())),
  };
}

class Time {
  String? name;
  List<ProductRole>? productRoles;

  Time({
    this.name,
    this.productRoles,
  });

  factory Time.fromJson(Map<String, dynamic> json) => Time(
    name: json["name"],
    productRoles: json["product_roles"] == null ? [] : List<ProductRole>.from(json["product_roles"]!.map((x) => ProductRole.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "product_roles": productRoles == null ? [] : List<dynamic>.from(productRoles!.map((x) => x.toJson())),
  };
}

class ProductRole {
  String? uuid;
  int? productId;
  String? name;
  Product? product;

  ProductRole({
    this.uuid,
    this.productId,
    this.name,
    this.product,
  });

  factory ProductRole.fromJson(Map<String, dynamic> json) => ProductRole(
    uuid: json["uuid"],
    productId: json["product_id"],
    name: json["name"],
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "product_id": productId,
    "name": name,
    "product": product?.toJson(),
  };
}

class Product {
  int? id;
  String? name;

  Product({
    this.id,
    this.name,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
