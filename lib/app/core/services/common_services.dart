import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../routes/app_pages.dart';
import '../widgets/common_widget.dart';
import 'local_db_services/local_db_services.dart';
import 'push_notification_services/local_notification_services.dart';

class CommonService {
  static void goNextScreen() {
    Future.delayed(2000.milliseconds, () {
      if (LocalDBService.instance.isLoggedIn()) {
        Get.offNamed(Routes.MAIN);
      } else {
        Get.offNamed(Routes.WELCOME);
      }
    });
  }

  static changeStatusBarIconColor({required bool isDark}) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarColor: Colors.transparent,
        systemStatusBarContrastEnforced: false,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness:
            isDark ? Brightness.light : Brightness.dark,
      ),
    );
  }

  static Future pickImage({required Function(File) image}) async {
    try {
      final file = await ImagePicker().pickImage(imageQuality: 60, source: ImageSource.gallery);

      if(file == null) return;

      File converted = File(file.path ?? '');

      image(converted);

    } on PlatformException catch (e) {
      snackBarFailed(
          context: Get.context!, content: 'Failed to pick image: $e');
    }
  }

  static Future pickImageC({required Function(File) image}) async {
    try {
      final file = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 60);

      if (file == null) return;

      File converted = File(file.path);

      image(converted);

    } on PlatformException catch (e) {
      snackBarFailed(
          context: Get.context!, content: 'Failed to pick image: $e');
    }
  }

  static Future pickFile({required Function(File) file}) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['pdf', 'docx', 'doc'],
      );

      if (result == null) return;

      if(result.files.isNotEmpty){
        File converted = File(result.files.first.path ?? '');
        file(converted);
      }
    } catch (error) {
      snackBarFailed(
          context: Get.context!, content: 'Failed to pick file: $error');
    }
  }


  static bool isDarkColor(Color color) {
    return ThemeData.estimateBrightnessForColor(color) == Brightness.light ||
            color == Colors.transparent
        ? false
        : true;
  }

  static void firebaseMessageHandler() {
    ///gives you the message on which user taps
    ///and it opened the app from terminated state
    ///

    NotificationService notificationService = NotificationService();
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        log('xxx Message on Terminated : ${jsonEncode(message.data)}');
      }
    });

    ///foreground work
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        log('xxx Message on Foreground :');
        notificationService.showNotification(message.notification.hashCode,
            message.notification?.title ?? '', message.notification?.body ?? '',message.notification?.title ?? '');
      }else{
        notificationService.showNotification(message.data.hashCode,
            message.data['title'], message.data['body'], message.data['title']);
      }


    });

    ///When the app is in background but opened and user taps
    ///on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message.notification != null) {
        log('xxx Message on Background : ${jsonEncode(message.data)}');
      }
    });
  }

  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    final notiService = NotificationService();

    log("Handling a background message: ${jsonEncode(message.data)}");
    notiService.showNotification(message.hashCode, message.data['title'],
        message.data['body'], message.data['title']);
  }
}
