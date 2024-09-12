// To parse this JSON data, do
//
//     final podDetailModel = podDetailModelFromJson(jsonString);

import 'dart:convert';

PodDetailModel podDetailModelFromJson(String str) => PodDetailModel.fromJson(json.decode(str));

String podDetailModelToJson(PodDetailModel data) => json.encode(data.toJson());

class PodDetailModel {
  String? jobCode;
  String? jobStatusName;
  String? jobDate;
  int? parcelsReceivedCount;
  int? parcelsDeliveredCount;
  dynamic notes;
  String? podImageUrl;
  int? jobStatusId;
  dynamic externalId;
  bool? canEdit;

  PodDetailModel({
    this.jobCode,
    this.jobStatusName,
    this.jobDate,
    this.parcelsReceivedCount,
    this.parcelsDeliveredCount,
    this.notes,
    this.podImageUrl,
    this.jobStatusId,
    this.externalId,
    this.canEdit,
  });

  factory PodDetailModel.fromJson(Map<String, dynamic> json) => PodDetailModel(
    jobCode: json["job_code"],
    jobStatusName: json["job_status_name"],
    jobDate: json["job_date"],
    parcelsReceivedCount: json["parcels_received_count"],
    parcelsDeliveredCount: json["parcels_delivered_count"],
    notes: json["notes"],
    podImageUrl: json["pod_image_url"],
    jobStatusId: json["job_status_id"],
    externalId: json["external_id"],
    canEdit: json["can_edit"],
  );

  Map<String, dynamic> toJson() => {
    "job_code": jobCode,
    "job_status_name": jobStatusName,
    "job_date": jobDate,
    "parcels_received_count": parcelsReceivedCount,
    "parcels_delivered_count": parcelsDeliveredCount,
    "notes": notes,
    "pod_image_url": podImageUrl,
    "job_status_id": jobStatusId,
    "external_id": externalId,
    "can_edit": canEdit,
  };
}
