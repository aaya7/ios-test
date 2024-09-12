import 'package:get/get.dart';
import 'package:hero/app/core/widgets/common_widget.dart';
import 'package:hero/app/data/models/message_models/notification_detail_model.dart';
import 'package:hero/app/data/repositories/message_repositories/message_repository.dart';
import 'package:intl/intl.dart';

class NotificationDetailController extends GetxController {
  String? uuid;

  final notificationDetail = NotificationDetailsModel().obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments["uuid"] != null) {
        uuid = Get.arguments["uuid"];
      }
    }

    fetchNotification();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> fetchNotification() async {
    try {
      isLoading(true);
      notificationDetail(await MessageRepository.instance
          .notificationDetail(uuid: uuid ?? ''));
    } catch (error, st) {
      snackBarFailed(
          context: Get.context!, content: "Failed to fetch notification");
    } finally {
      isLoading(false);
    }
  }

  String parseDateTime(String? value){
    DateTime time = DateTime.parse(value ?? DateTime.now().toString());
    return DateFormat('MMM dd, yyyy hh:mm a').format(time);
  }
}
