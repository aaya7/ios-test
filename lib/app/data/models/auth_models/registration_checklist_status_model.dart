// To parse this JSON data, do
//
//     final registrationChecklistStatusModel = registrationChecklistStatusModelFromJson(jsonString);

import 'dart:convert';

RegistrationChecklistStatusModel registrationChecklistStatusModelFromJson(
        String str) =>
    RegistrationChecklistStatusModel.fromJson(json.decode(str));

String registrationChecklistStatusModelToJson(
        RegistrationChecklistStatusModel data) =>
    json.encode(data.toJson());

class RegistrationChecklistStatusModel {
  List<ChecklistStatus>? checklistStatuses;
  int? incompleteChecklistCount;

  RegistrationChecklistStatusModel({
    this.checklistStatuses,
    this.incompleteChecklistCount,
  });

  factory RegistrationChecklistStatusModel.fromJson(
          Map<String, dynamic> json) =>
      RegistrationChecklistStatusModel(
        checklistStatuses: json["checklist_statuses"] == null
            ? []
            : List<ChecklistStatus>.from(json["checklist_statuses"]!
                .map((x) => ChecklistStatus.fromJson(x))),
        incompleteChecklistCount: json["incomplete_checklist_count"],
      );

  Map<String, dynamic> toJson() => {
        "checklist_statuses": checklistStatuses == null
            ? []
            : List<dynamic>.from(checklistStatuses!.map((x) => x.toJson())),
        "incomplete_checklist_count": incompleteChecklistCount,
      };
}

enum ChecklistType {
  license,
  personal,
  bank,
  emergencyContact,
  transportation,
}

class ChecklistStatus {
  String? name;

  // String? type;
  ChecklistType? type;

  ChecklistStatus({
    this.name,
    this.type,
  });

  factory ChecklistStatus.fromJson(Map<String, dynamic> json) =>
      ChecklistStatus(
        name: json["name"],
        type: _parseChecklistType(json['type']),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": '${type.toString().split('.').last}_info',
      };


  static ChecklistType? _parseChecklistType(String? type) {
    switch (type) {
      case 'license_info':
        return ChecklistType.license;
      case 'personal_info':
        return ChecklistType.personal;
      case 'bank_info':
        return ChecklistType.bank;
      case 'emergency_contact_info':
        return ChecklistType.emergencyContact;
      case 'transportation_info':
        return ChecklistType.transportation;
      default:
        return null;
    }
  }
}
