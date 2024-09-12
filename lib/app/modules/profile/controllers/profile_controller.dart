import 'dart:developer';

import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ProfileController extends GetxController {

  final versionName = "1.0.0".obs;

  @override
  void onInit() {
    super.onInit();
    getVersionName();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getVersionName() async{
    try{


      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      String version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;

      versionName.value = "$version+$buildNumber";

    }catch(error){
      log("xxx error get version $error");
    }
  }

}
