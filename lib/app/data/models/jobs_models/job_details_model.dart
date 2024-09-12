// To parse this JSON data, do
//
//     final jobDetailsModel = jobDetailsModelFromJson(jsonString);

import 'dart:convert';

JobDetailsModel jobDetailsModelFromJson(String str) =>
    JobDetailsModel.fromJson(json.decode(str));

String jobDetailsModelToJson(JobDetailsModel data) =>
    json.encode(data.toJson());

class JobDetailsModel {
  String? uuid;
  String? merchantLogoUrl;
  String? merchantName;
  String? locationName;
  int? assignmentStatusId;
  String? lastUpdatedAt;
  int? isFullTime;
  int? availableSlots;
  String? jobName;
  String? productCategory;
  String? productRoleName;
  // String? basicSalary;
  // String? ratePerParcel;
  String? jobDescription;
  List<Requirement>? requirements;
  List<String>? requirementsString;
  bool? canSubmitPod;
  bool? isLM;
  String? examplePODImage;
  List<PodList>? podLists;
  bool? canApply;
  int? canQuit;
  double? wageAmount;
  String? wageUnit;
  List<Information>? informations;

  JobDetailsModel({
    this.uuid,
    this.merchantLogoUrl,
    this.merchantName,
    this.locationName,
    this.assignmentStatusId,
    this.lastUpdatedAt,
    this.isFullTime,
    this.availableSlots,
    this.jobName,
    this.productCategory,
    this.productRoleName,
    // this.basicSalary,
    // this.ratePerParcel,
    this.jobDescription,
    this.requirements,
    this.requirementsString,
    this.canSubmitPod,
    this.podLists,
    this.isLM,
    this.examplePODImage,
    this.canApply,
    this.canQuit,
    this.wageAmount,
    this.wageUnit,
    this.informations,
  });

  factory JobDetailsModel.fromJson(Map<String, dynamic> json) =>
      JobDetailsModel(
        uuid: json["uuid"],
        merchantLogoUrl: json["merchant_logo_url"],
        merchantName: json["merchant_name"],
        locationName: json["location_name"],
        assignmentStatusId: json["assignment_status_id"],
        lastUpdatedAt: json["last_updated_at"],
        isFullTime: json["is_full_time"],
        availableSlots: json["available_slots"],
        jobName: json["job_name"],
        productCategory: json["product_category"],
        productRoleName: json["product_role_name"],
        // basicSalary: json["basic_salary"],
        // ratePerParcel: json["rate_per_parcel"],
        isLM: json["product_type_is_lm"],
        examplePODImage: json["example_pod_url"],
        jobDescription: json["job_description"],
        canApply: json["can_apply"],
        requirements: json["requirements"] == null
            ? []
            : (json["requirements"] as List).every((element) => element is String) ? [] : List<Requirement>.from(
            json["requirements"]!.map((x) => Requirement.fromJson(x))),
        requirementsString: json["requirements"] == null
            ? []
            : !((json["requirements"] as List).every((element) => element is String)) ? [] : List<String>.from(
            json["requirements"]!.map((x) => x)),
        canSubmitPod: json["can_submit_pod"],
        canQuit: json["can_quit"],
        wageAmount: json["wage_amount"].toDouble(),
        wageUnit: json["wage_unit"],
        podLists: json["pod_lists"] == null ? [] : List<PodList>.from(
            json["pod_lists"]!.map((x) => PodList.fromJson(x))),
        informations: json["informations"] == null ? [] : List<Information>.from(json["informations"]!.map((x) => Information.fromJson(x))),
      );

  Map<String, dynamic> toJson() =>
      {
        "uuid": uuid,
        "merchant_logo_url": merchantLogoUrl,
        "merchant_name": merchantName,
        "location_name": locationName,
        "assignment_status_id": assignmentStatusId,
        "last_updated_at": lastUpdatedAt,
        "is_full_time": isFullTime,
        "available_slots": availableSlots,
        "job_name": jobName,
        "product_category": productCategory,
        "product_role_name": productRoleName,
        // "basic_salary": basicSalary,
        "can_apply": canApply,
        "product_type_is_lm": isLM,
        "example_pod_url": examplePODImage,
        // "rate_per_parcel": ratePerParcel,
        "job_description": jobDescription,
        "requirements": requirements == null ? [] : List<dynamic>.from(
            requirements!.map((x) => x.toJson())),
        "can_submit_pod": canSubmitPod,
        "can_quit": canQuit,
        "pod_lists": podLists == null ? [] : List<dynamic>.from(
            podLists!.map((x) => x.toJson())),
        "informations": informations == null ? [] : List<dynamic>.from(informations!.map((x) => x.toJson())),
      };
}

class PodList {
  String? uuid;
  int? jobStatusId;
  String? jobCode;
  String? jobStatusName;
  String? jobDate;
  bool? canEdit;
  String? podImageUrl;

  PodList({
    this.uuid,
    this.jobStatusId,
    this.jobCode,
    this.jobStatusName,
    this.jobDate,
    this.canEdit,
    this.podImageUrl,
  });

  factory PodList.fromJson(Map<String, dynamic> json) =>
      PodList(
        uuid: json["uuid"],
        jobStatusId: json["job_status_id"],
        jobCode: json["job_code"],
        jobStatusName: json["job_status_name"],
        jobDate: json["job_date"],
        canEdit: json["can_edit"],
        podImageUrl: json["pod_image_url"],
      );

  Map<String, dynamic> toJson() =>
      {
        "uuid": uuid,
        "job_status_id": jobStatusId,
        "job_status_name": jobStatusName,
        "job_code": jobCode,
        "job_date": jobDate,
        "can_edit": canEdit,
        "pod_image_url": podImageUrl,
      };
}

class Requirement {
  String? requirement;
  String? name;
  bool? checklistStatus;
  bool? hasVideo;

  Requirement({
    this.requirement,
    this.name,
    this.checklistStatus,
    this.hasVideo,
  });

  factory Requirement.fromJson(Map<String, dynamic> json) =>
      Requirement(
        requirement: json["requirement"],
        name: json["name"],
        checklistStatus: json["checklist_status"],
        hasVideo: json["have_video"],
      );

  Map<String, dynamic> toJson() =>
      {
        "requirement": requirement,
        "name": name,
        "checklist_status": checklistStatus,
        "have_video": hasVideo,
      };
}

class Information {
  String? title;
  String? value;

  Information({
    this.title,
    this.value,
  });

  factory Information.fromJson(Map<String, dynamic> json) => Information(
    title: json["title"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "value": value,
  };
}