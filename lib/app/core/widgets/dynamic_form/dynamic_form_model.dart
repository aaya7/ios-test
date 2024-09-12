// To parse this JSON data, do
//
//     final dynamicFormModel = dynamicFormModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/constants/constant.dart';
import 'dynamic_form.dart';

DynamicFormModel dynamicFormModelFromJson(String str) => DynamicFormModel.fromJson(json.decode(str));

String dynamicFormModelToJson(DynamicFormModel data) => json.encode(data.toJson());

class DynamicFormModel {
  DynamicFormModel({
    this.data,
  });

  List<Datum>? data;

  factory DynamicFormModel.fromJson(Map<String, dynamic> json) => DynamicFormModel(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.type,
    this.subtype,
    this.label,
    this.values,
    this.userData,
    this.textEditingController,
    this.checkBoxValue,
    this.tempValue,
    this.files,
    this.componentType,
    this.required,
    this.enabled,
  });

  String? type;
  String? subtype;
  String? label;
  List<Value>? values;
  List<dynamic>? userData;
  TextEditingController? textEditingController;
  Rx<bool>? checkBoxValue;
  dynamic tempValue;
  RxList<dynamic>? files;
  ComponentType? componentType;
  bool? required;
  bool? enabled;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    type: json["type"],
    subtype: json["subtype"],
    label: json["label"],
    userData: json["userData"] == null
        ? <dynamic>[]
        : List<dynamic>.from(json["userData"]!.map((x) => x)),
    values: json["value"] == null ? [] : List<Value>.from(json["value"]!.map((x) => Value.fromJson(x))),
    textEditingController: TextEditingController(),
    checkBoxValue: false.obs,
    componentType: getComponentType(json["type"]),
    required: json["required"],
    enabled: json["enabled"] ?? true,
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "subtype": subtype,
    "label": label,
    "userData":
    userData == null ? [] : List<dynamic>.from(userData!.map((x) => x)),
    "value": values == null ? [] : List<dynamic>.from(values!.map((x) => x.toJson())),
  };
}

class Value {
  Value({
    this.id,
    this.text,
  });

  String? id;
  String? text;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
    id: json["id"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "text": text,
  };
}
