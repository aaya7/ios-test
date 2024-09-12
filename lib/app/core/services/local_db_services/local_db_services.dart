import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../../data/constants/constant.dart';
import '../../../data/constants/local_db_constant.dart';
import 'hive_encryption_service.dart';

class LocalDBService extends GetxService {
  static LocalDBService get instance => Get.find<LocalDBService>();
  final _encryptionService = HiveEncryptionService();

  Future<LocalDBService> initService() async {
    if (!GetPlatform.isWeb) {
      final document = await getApplicationDocumentsDirectory();
      Hive
        .init(document.path);

      /**
       * register adapter for hive database
       */

      // ..registerAdapter(ToDoModelAdapter());
    }
    await Hive.openBox(ConstantValue.dbName);
    await Hive.openBox(ConstantValue.sysDbName);

    if (Hive.box(ConstantValue.dbName).isEmpty) {
      Hive.box(ConstantValue.dbName).put(DBConstant.KEY_IS_FIRST_TIME, true);
      Hive.box(ConstantValue.dbName).put(DBConstant.KEY_IS_LOGGED_IN, false);
    }

    setDeviceModel(await getDeviceInfo());
    // if(getFCMToken().isEmpty){
    //   final fcmToken = await FirebaseMessaging.instance.getToken();
    //   saveFirebaseToken(fcmToken);
    //   log('xxxx Firebase Token Saved');
    // }
    log('xxxx LOCAL DB INITIALIZED');
    return this;
  }

  void saveFirebaseToken(String? token) {
    Hive.box(ConstantValue.sysDbName).put(DBConstant.KEY_FIREBASE_TOKEN, token);
    return;
  }

  String getFCMToken() {
    return Hive.box(ConstantValue.sysDbName)
        .get(DBConstant.KEY_FIREBASE_TOKEN, defaultValue: "");
  }

  void setIsFirstTime(bool val) {
    Hive.box(ConstantValue.dbName).put(DBConstant.KEY_IS_FIRST_TIME, val);
    return;
  }

  void setIsLoggedIn(bool val) {
    Hive.box(ConstantValue.dbName).put(DBConstant.KEY_IS_LOGGED_IN, val);
    return;
  }

  void setUsername(String val) {
    Hive.box(ConstantValue.dbName).put(DBConstant.KEY_USERNAME, val);
    return;
  }

  void setLanguage(String val) {
    Hive.box(ConstantValue.dbName).put(DBConstant.KEY_LANGUAGE, val);
    return;
  }

  void setLocationCode(String val) {
    Hive.box(ConstantValue.dbName).put(DBConstant.KEY_LOCATION_CODE, val);
    return;
  }

  void setEmail(String val) {
    Hive.box(ConstantValue.dbName).put(DBConstant.KEY_EMAIL, val);
    return;
  }


  void setDeviceModel(String val) {
    Hive.box(ConstantValue.dbName).put(DBConstant.KEY_DEVICE_MODEL, val);
    return;
  }

  void setPassword(String val) {
    final encryptedPassword = _encryptionService.encrypt(val);
    Hive.box(ConstantValue.dbName)
        .put(DBConstant.KEY_PASSWORD, encryptedPassword);
    return;
  }

  bool isFullUser() {
    return getEmail() == 'full@insurance.com';
  }


  void setID(String val) {
    Hive.box(ConstantValue.dbName).put(DBConstant.KEY_ID, val);
    return;
  }

  void setUid(String val) {
    Hive.box(ConstantValue.dbName).put(DBConstant.KEY_UID, val);
    return;
  }

  void setAvatar(String val) {
    Hive.box(ConstantValue.dbName).put(DBConstant.KEY_AVATAR, val);
    return;
  }


  String getToken() {
    return Hive.box(ConstantValue.dbName)
        .get(DBConstant.KEY_TOKEN, defaultValue: "");
  }

  String getUsername() {
    return Hive.box(ConstantValue.dbName)
        .get(DBConstant.KEY_USERNAME, defaultValue: "");
  }

  String getLanguage() {
    return Hive.box(ConstantValue.dbName)
        .get(DBConstant.KEY_LANGUAGE, defaultValue: "English");
  }

  String getLocationCode() {
    return Hive.box(ConstantValue.dbName)
        .get(DBConstant.KEY_LOCATION_CODE, defaultValue: "KMV069");
  }

  String getEmail() {
    return Hive.box(ConstantValue.dbName)
        .get(DBConstant.KEY_EMAIL, defaultValue: "");
  }

  String getDeviceModel() {
    return Hive.box(ConstantValue.dbName)
        .get(DBConstant.KEY_DEVICE_MODEL, defaultValue: "");
  }

  String getPassword() {
    final encryptedPassword = Hive.box(ConstantValue.dbName)
        .get(DBConstant.KEY_PASSWORD, defaultValue: "");

    log('xxxx encrypted password : $encryptedPassword');

    return _encryptionService.decrypt(encryptedPassword);
  }

  String getUid() {
    return Hive.box(ConstantValue.dbName).get(DBConstant.KEY_UID,
        defaultValue: "");
  }

  String getID() {
    return Hive.box(ConstantValue.dbName).get(DBConstant.KEY_ID,
        defaultValue: "");
  }

  String getAvatar() {
    return Hive.box(ConstantValue.dbName).get(DBConstant.KEY_AVATAR,
        defaultValue: "");
  }

  bool isFirstTime() {
    return Hive.box(ConstantValue.dbName)
        .get(DBConstant.KEY_IS_FIRST_TIME, defaultValue: true);
  }

  bool isLoggedIn() {
    return Hive.box(ConstantValue.dbName)
        .get(DBConstant.KEY_IS_LOGGED_IN, defaultValue: false);
  }

  void setToken(String token) {
    Hive.box(ConstantValue.dbName).put(DBConstant.KEY_TOKEN, token);
    return;
  }

  bool isDarkMode() {
    return Hive.box(ConstantValue.dbName)
        .get(DBConstant.KEY_DARK_MODE, defaultValue: false);
  }

  void setDarkMode(bool isDark) {
    Hive.box(ConstantValue.dbName).put(DBConstant.KEY_DARK_MODE, isDark);
    return;
  }

  String getStringValue({required constantName, String? dbname}) {
    return Hive.box(dbname ?? ConstantValue.dbName)
        .get(constantName, defaultValue: "") as String;
  }

  bool getBoolValue({required constantName, String? dbname}) {
    return Hive.box(dbname ?? ConstantValue.dbName)
        .get(constantName, defaultValue: false) as bool;
  }

  int getIntValue({required constantName, String? dbname}) {
    return Hive.box(dbname ?? ConstantValue.dbName)
        .get(constantName, defaultValue: 0) as int;
  }

  dynamic getValue({required constantName, String? dbname}) {
    return Hive.box(dbname ?? ConstantValue.dbName).get(constantName);
  }

  Future<void> clearDB() async {
    await Hive.box(ConstantValue.dbName).clear();
  }
}
