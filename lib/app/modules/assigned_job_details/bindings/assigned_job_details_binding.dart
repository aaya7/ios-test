import 'package:get/get.dart';

import '../controllers/assigned_job_details_controller.dart';

class AssignedJobDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssignedJobDetailsController>(
      () => AssignedJobDetailsController(),
    );
  }
}
