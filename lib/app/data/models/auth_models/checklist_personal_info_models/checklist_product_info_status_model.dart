// To parse this JSON data, do
//
//     final productInfoStatusModel = productInfoStatusModelFromJson(jsonString);

import 'dart:convert';

ProductInfoStatusModel productInfoStatusModelFromJson(String str) => ProductInfoStatusModel.fromJson(json.decode(str));

String productInfoStatusModelToJson(ProductInfoStatusModel data) => json.encode(data.toJson());

class ProductInfoStatusModel {
  List<Product>? products;

  ProductInfoStatusModel({
    this.products,
  });

  factory ProductInfoStatusModel.fromJson(Map<String, dynamic> json) => ProductInfoStatusModel(
    products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

class Product {
  int? id;
  String? uuid;
  String? crmId;
  String? name;
  String? category;
  dynamic description;
  String? createdAt;
  String? updatedAt;
  List<ProductRole>? productRoles;
  bool? checklistStatus;

  Product({
    this.id,
    this.uuid,
    this.crmId,
    this.name,
    this.category,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.productRoles,
    this.checklistStatus,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    uuid: json["uuid"],
    crmId: json["crm_id"],
    name: json["name"],
    category: json["category"],
    description: json["description"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    productRoles: json["product_roles"] == null ? [] : List<ProductRole>.from(json["product_roles"]!.map((x) => ProductRole.fromJson(x))),
    checklistStatus: json["checklist_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "crm_id": crmId,
    "name": name,
    "category": category,
    "description": description,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "product_roles": productRoles == null ? [] : List<dynamic>.from(productRoles!.map((x) => x.toJson())),
    "checklist_status": checklistStatus,
  };
}

class ProductRole {
  int? productRoleId;
  String? productRoleUuid;
  String? productRoleName;
  bool? checklistStatus;
  List<Requirement>? requirements;

  ProductRole({
    this.productRoleId,
    this.productRoleUuid,
    this.productRoleName,
    this.checklistStatus,
    this.requirements,
  });

  factory ProductRole.fromJson(Map<String, dynamic> json) => ProductRole(
    productRoleId: json["product_role_id"],
    productRoleUuid: json["product_role_uuid"],
    productRoleName: json["product_role_name"],
    checklistStatus: json["checklist_status"],
    requirements: json["requirements"] == null ? [] : List<Requirement>.from(json["requirements"]!.map((x) => Requirement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "product_role_id": productRoleId,
    "product_role_uuid": productRoleUuid,
    "product_role_name": productRoleName,
    "checklist_status": checklistStatus,
    "requirements": requirements == null ? [] : List<dynamic>.from(requirements!.map((x) => x.toJson())),
  };
}

class Requirement {
  String? requirement;
  String? name;
  bool? checklistStatus;

  Requirement({
    this.requirement,
    this.name,
    this.checklistStatus,
  });

  factory Requirement.fromJson(Map<String, dynamic> json) => Requirement(
    requirement: json["requirement"],
    name: json["name"],
    checklistStatus: json["checklist_status"],
  );

  Map<String, dynamic> toJson() => {
    "requirement": requirement,
    "name": name,
    "checklist_status": checklistStatus,
  };
}
