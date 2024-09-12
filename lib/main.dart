import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:hero/app/data/repositories/auth_repositories/auth_repository.dart';
import 'package:hero/app/data/repositories/auth_repositories/register_checklist_repository.dart';
import 'package:hero/app/data/repositories/job_repositories/job_repository.dart';
import 'package:hero/app/data/repositories/message_repositories/message_repository.dart';
import 'package:hero/app/modules/jobs/controllers/jobs_controller.dart';
import 'package:hero/app/modules/messages/controllers/messages_controller.dart';
import 'package:hero/app/modules/profile/controllers/profile_controller.dart';
import 'package:hero/app/modules/register_checklist/controllers/register_checklist_controller.dart';

import 'app/core/core_index.dart';
import 'app/data/repositories/misc_repositories/misc_repository.dart';
import 'app/modules/home/controllers/home_controller.dart';
import 'app/modules/register_checklist/controllers/checklist_bank_info_controller.dart';
import 'app/modules/register_checklist/controllers/checklist_emergency_info_controller.dart';
import 'app/modules/register_checklist/controllers/checklist_license_info_controller.dart';
import 'app/modules/register_checklist/controllers/checklist_personal_info_controller.dart';
import 'app/modules/register_checklist/controllers/checklist_product_info_controller.dart';
import 'app/modules/register_checklist/controllers/checklist_vehicle_info_controller.dart';
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await initDependencies();
  await initNotificationServices();

  runApp(
    GetMaterialApp(
      title: "Carpedia",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      /**
       * THEMES
       */
      theme: ThemesData.lightTheme,
      // darkTheme: ThemesData.darkTheme,
      // themeMode: ThemesData().theme,

      /**
       * LANGUAGES
       */
      locale: LocalizationService.getLocaleFromLanguage(
          LocalDBService.instance.getLanguage()),
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
    ),
  );
}

Future<void> initDependencies() async {
  try {
    /**
     * enable this for firebase notification
     */

    FirebaseServices().init(DefaultFirebaseOptions.currentPlatform);
    await Get.putAsync(() => LocalDBService().initService(), permanent: true);
    Get.put(APIService(), permanent: true);

    /**
     * Screen Controller Dependencies
     */
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<JobsController>(() => JobsController(), fenix: true);
    Get.lazyPut<RegisterChecklistController>(
        () => RegisterChecklistController(),
        fenix: true);
    Get.lazyPut<MessagesController>(() => MessagesController(), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);

    Get.lazyPut<ChecklistPersonalInfoController>(
        () => ChecklistPersonalInfoController(),
        fenix: true);

    Get.lazyPut<ChecklistBankInfoController>(
        () => ChecklistBankInfoController(),
        fenix: true);

    Get.lazyPut<ChecklistEmergencyInfoController>(
        () => ChecklistEmergencyInfoController(),
        fenix: true);

    Get.lazyPut<ChecklistLicenseInfoController>(
        () => ChecklistLicenseInfoController(),
        fenix: true);

    Get.lazyPut<ChecklistVehicleInfoController>(
        () => ChecklistVehicleInfoController(),
        fenix: true);

    Get.lazyPut<ChecklistProductInfoController>(
        () => ChecklistProductInfoController(),
        fenix: true);

    /**
     * Repositories Dependencies
     */
    Get.lazyPut<AuthRepository>(() => AuthRepository(), fenix: true);
    Get.lazyPut<MiscRepository>(() => MiscRepository(), fenix: true);
    Get.lazyPut<RegisterChecklistRepository>(
        () => RegisterChecklistRepository(),
        fenix: true);
    Get.lazyPut<JobRepository>(() => JobRepository(), fenix: true);
    Get.lazyPut<MessageRepository>(() => MessageRepository(), fenix: true);
  } catch (error) {
    log("Init Dependencies Error : $error");
  }
}

Future<void> initNotificationServices() async {
  try {
    NotificationService notificationService = NotificationService();
    await notificationService.init();
    await notificationService.requestIOSPermissions();
    await notificationService.requestAndroidPermission();

    /**
     * enable this for firebase notification
     */
    FirebaseMessaging.onBackgroundMessage(
        CommonService.firebaseMessagingBackgroundHandler);
  } catch (error) {
    log("Init Notification Service Failed : $error");
  }
}
