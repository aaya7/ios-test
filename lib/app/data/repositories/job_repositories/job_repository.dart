import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart' as getx;
import 'package:dio/dio.dart';
import 'package:hero/app/core/core_index.dart';
import 'package:hero/app/data/constants/endpoints_constant.dart';
import 'package:hero/app/data/models/jobs_models/assigned_job_list_model.dart';
import 'package:hero/app/data/models/jobs_models/browse_job_list_model.dart';
import 'package:hero/app/data/models/jobs_models/pod_detail_model.dart';
import 'package:hero/app/modules/jobs/views/jobs_view.dart';

import '../../models/jobs_models/job_details_model.dart';

class JobRepository {
  static JobRepository get instance => getx.Get.find<JobRepository>();

  Future<List<BrowseJobListModel>> getBrowseJob({
    String? page,
    List<String>? productRoleUUIDs,
    List<String>? locations,
    List<String>? merchantCodes,
    String? sortByLocation,
    List<String>? jobTypes,
  }) async {
    try {
      var formData = FormData.fromMap({
        "page": page ?? "1",
        if (sortByLocation != null) "sort_by_location": sortByLocation,
      });

      for (var location in locations ?? <String>[]) {
        formData.fields.add(MapEntry("location[]", location));
      }
      for (var productRoleUUID in productRoleUUIDs ?? <String>[]) {
        formData.fields.add(MapEntry("product_role_uuid[]", productRoleUUID));
      }

      for (var merchantCode in merchantCodes ?? <String>[]) {
        formData.fields.add(MapEntry("merchant_code[]", merchantCode));
      }

      for (var jobType in jobTypes ?? <String>[]) {
        formData.fields.add(MapEntry("job_type[]", jobType));
      }

      Response response = await APIService.instance
          .post(formData, endpoint: EndpointConstant.jobList);

      var str = jsonEncode(response.data["browse_jobs"]);

      return browseJobListModelFromJson(str);
    } catch (error, st) {
      log("xxxx getBrowseJob repo $error $st");
      throw Exception(error);
    }
  }

  Future<List<AssignedJobListModel>> getAssignedJobs() async {
    try {
      var formData = FormData.fromMap({});

      Response response = await APIService.instance
          .post(formData, endpoint: EndpointConstant.assignedJobList);

      var str = jsonEncode(response.data["assignments"]);

      return assignedJobListModelFromJson(str);
    } catch (error, st) {
      log("xxxx getBrowseJob repo $error $st");
      throw Exception(error);
    }
  }

  Future<List<BrowseJobListModel>> getDashboardBrowseJob() async {
    try {
      var formData = FormData.fromMap({});

      Response response = await APIService.instance
          .post(formData, endpoint: EndpointConstant.dashboardJob);

      var str = jsonEncode(response.data["browse_jobs"]);

      return browseJobListModelFromJson(str);
    } catch (error, st) {
      log("xxxx getDashboardBrowseJob repo $error $st");
      throw Exception(error);
    }
  }

  Future<List<AssignedJobListModel>> getDashboardAssignedJob() async {
    try {
      var formData = FormData.fromMap({});

      Response response = await APIService.instance
          .post(formData, endpoint: EndpointConstant.dashboardAssignedJob);

      var str = jsonEncode(response.data["assignments"]);

      return assignedJobListModelFromJson(str);
    } catch (error, st) {
      log("xxxx getDashboardAssignedJob repo $error $st");
      throw Exception(error);
    }
  }

  Future<JobDetailsModel> getJobDetails({required String jobUUID}) async {
    try {
      var formData = FormData.fromMap({});

      Response response = await APIService.instance
          .post(formData, endpoint: EndpointConstant.jobDetail(id: jobUUID));

      var str = jsonEncode(response.data);

      return jobDetailsModelFromJson(str);
    } catch (error, st) {
      log("xxx getJobDetails $error $st");
      throw Exception(error);
    }
  }

  Future<JobDetailsModel> getAssignedJobDetail(
      {required String jobUUID}) async {
    try {
      var formData = FormData.fromMap({});

      Response response = await APIService.instance.post(formData,
          endpoint: EndpointConstant.assignedJobDetail(id: jobUUID));

      var str = jsonEncode(response.data);

      return jobDetailsModelFromJson(str);
    } catch (error, st) {
      log("xxx getJobDetails $error $st");
      throw Exception(error);
    }
  }

  Future<Response> quitAssignment(
      {required String jobUUID}) async {
    try {
      var formData = FormData.fromMap({});

      Response response = await APIService.instance.post(formData,
          endpoint: EndpointConstant.assignedJobQuit(id: jobUUID));

      return response;
    } catch (error, st) {
      log("xxx getJobDetails $error $st");
      throw Exception(error);
    }
  }

  Future<Response> applyJob(
      {required String jobUUID, required String startDate}) async {
    try {
      var formData = FormData.fromMap({
        "estimated_start_date": startDate
      });

      Response response = await APIService.instance
          .post(formData, endpoint: EndpointConstant.jobsApply(id: jobUUID));

      return response;
    } catch (error, st) {
      log("xxx getJobDetails $error $st");
      rethrow;
    }
  }

  Future<Response> submitPOD(
      {required String jobUUID,
      required File? podImage,
      required String jobDate,
      required String parcelReceived,
      required String parcelDelivered,
      String? externalID,
      String? notes,
      required bool noParcel}) async {
    try {
      var formData = FormData.fromMap({
        "job_date": jobDate,
        if(podImage != null)
        'pod_image': MultipartFile.fromFileSync(podImage.path ?? ''),
        'parcels_received': parcelReceived,
        'parcels_delivered': parcelDelivered,
        if (externalID != null) 'external_id': externalID,
        if (notes != null) 'notes': notes,
        'no_parcel_available': noParcel ? 1:0
      });

      Response response = await APIService.instance
          .post(formData, endpoint: EndpointConstant.podSubmit(id: jobUUID));

      return response;
    } catch (error, st) {
      log("xxx getJobDetails $error $st");
      rethrow;
    }
  }

  Future<PodDetailModel> getPODDetail(
      {required String jobUUID, required String podUUID}) async {
    try {
      var formData = FormData.fromMap({});

      Response response = await APIService.instance.post(formData,
          endpoint: EndpointConstant.podView(id: jobUUID, podID: podUUID));

      var str = jsonEncode(response.data);

      return podDetailModelFromJson(str);
    } catch (error, st) {
      log("xxx getJobDetails $error $st");
      throw Exception(error);
    }
  }

  Future<Response> deletePOD(
      {required String jobUUID, required String podUUID}) async {
    try {
      var formData = FormData.fromMap({});

      Response response = await APIService.instance.post(formData,
          endpoint: EndpointConstant.podDelete(id: jobUUID, podID: podUUID));

      return response;
    } catch (error, st) {
      log("xxx getJobDetails $error $st");
      throw Exception(error);
    }
  }

  Future<Response> updatePOD(
      {required String jobUUID,
      required String podUUID,
      required String jobDate,
      required String parcelReceived,
      required String parcelDelivered,
      String? externalID,
      String? notes}) async {
    try {
      var formData = FormData.fromMap({
        "job_date": jobDate,
        'parcels_received': parcelReceived,
        'parcels_delivered': parcelDelivered,
        if (externalID != null) 'external_id': externalID,
        if (notes != null) 'notes': notes,
      });

      Response response = await APIService.instance.post(formData,
          endpoint: EndpointConstant.podUpdate(id: jobUUID, podID: podUUID));

      return response;
    } catch (error, st) {
      log("xxx getJobDetails $error $st");
      rethrow;
    }
  }
}
