import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero/app/core/widgets/common_widget.dart';
import 'package:hero/app/data/models/message_models/notification_model.dart';
import 'package:hero/app/data/repositories/message_repositories/message_repository.dart';

class MessagesController extends GetxController with GetSingleTickerProviderStateMixin {
  late final TabController tabController;

  final notificationList = <NotificationModel>[].obs;
  final isNotificationLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    fetchNotificationList();
  }

  @override
  void onReady() {
    super.onReady();
    tabController.animateTo(1);
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> fetchNotificationList() async{

    try{
      isNotificationLoading(true);
      notificationList(await MessageRepository.instance.notificationList());
      isNotificationLoading(false);
    }catch(error, st){
      isNotificationLoading(false);
      snackBarFailed(context: Get.context!, content: "Failed to get notification list");
    }

  }

}
