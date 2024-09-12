import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationSettingController extends GetxController {

  final incomingNewMessage = true.obs;
  final newJobAlert = true.obs;
  final jobsForMe = false.obs;
  final fcmTokenTextController = TextEditingController();

  @override
  void onInit() async{
    super.onInit();
    fcmTokenTextController.text = await FirebaseMessaging.instance.getToken() ?? '';
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

}
