import 'package:get/get.dart';

import '../controllers/work_preference_controller.dart';

class WorkPreferenceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WorkPreferenceController>(
      () => WorkPreferenceController(), fenix: true
    );
  }
}
