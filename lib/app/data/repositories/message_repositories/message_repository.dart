import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:hero/app/data/models/message_models/notification_detail_model.dart';
import 'package:hero/app/data/models/message_models/notification_model.dart';

import '../../../core/services/http_services/http_services.dart';
import '../../constants/endpoints_constant.dart';

class MessageRepository {
  static MessageRepository get instance => getx.Get.find<MessageRepository>();

  Future<List<NotificationModel>> notificationList() async {
    try {
      Response response = await APIService.instance
          .get(endpoint: EndpointConstant.notificationList);

      var json = jsonEncode(response.data["data"]);

      return notificationModelFromJson(json);
    } catch (error, st) {
      log("xxxx notification list repo $error $st");
      rethrow;
    }
  }

  Future<NotificationDetailsModel> notificationDetail(
      {required String uuid}) async {
    try {
      Response response = await APIService.instance
          .post({}, endpoint: EndpointConstant.notificationDetail(uuid));

      var json = jsonEncode(response.data["data"]);

      return notificationDetailsModelFromJson(json);
    } catch (error, st) {
      log("xxxx notification detail repo $error $st");
      rethrow;
    }
  }
}
