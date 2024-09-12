import 'package:get/get.dart';

import '../controllers/pod_detail_controller.dart';

class PodDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PodDetailController>(
      () => PodDetailController(),
    );
  }
}
