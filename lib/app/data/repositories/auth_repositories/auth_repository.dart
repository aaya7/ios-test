import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart' as getx;
import 'package:dio/dio.dart';
import 'package:hero/app/core/core_index.dart';
import 'package:hero/app/data/constants/endpoints_constant.dart';
import 'package:hero/app/data/models/auth_models/profile_model.dart';
import 'package:hero/app/data/models/auth_models/registration_checklist_status_model.dart';

class AuthRepository {
  static AuthRepository get instance => getx.Get.find<AuthRepository>();

  Future<Response> register(
      {required String name,
      required String email,
      required String mobile,
      required String state,
      required String city,
      required String password,
      required String passwordConfirmation, required String source}) async {
    try {
      var formData = FormData.fromMap({
        "name": name,
        "email": email,
        "mobile": mobile,
        "state": state,
        "city": city,
        "password": password,
        "password_confirmation": passwordConfirmation,
        "source":source,
      });

      Response response = await APIService.instance
          .post(formData, endpoint: EndpointConstant.register);

      return response;
    } catch (error, st) {
      log("xxxx register repo $error $st");
      rethrow;
    }
  }

  Future<Response> login({
    required String email,
    required String password,
  }) async {
    try {
      var formData = FormData.fromMap({
        "email": email,
        "password": password,
        "device_token": await FirebaseMessaging.instance.getToken(),
      });

      Response response = await APIService.instance
          .post(formData, endpoint: EndpointConstant.login);

      LocalDBService.instance.setToken(response.data["token"]);
      LocalDBService.instance.setIsLoggedIn(response.data["token"] != null);

      if (response.data["user"] != null) {
        var user = response.data["user"];

        LocalDBService.instance.setAvatar(user["profile_photo_url"]);
        LocalDBService.instance.setUid(user["uuid"]);
        LocalDBService.instance.setID((user["id"]).toString());
        LocalDBService.instance.setEmail(user["email"]);
        LocalDBService.instance.setUsername(user["name"]);
      }

      //profile_photo_url
      //uuid
      //name
      //email
      //id

      return response;
    } catch (error, st) {
      log("xxxx register repo $error $st");
      rethrow;
    }
  }

  Future<ProfileModel> getUserProfile() async{
    try{
      Response response = await APIService.instance
          .get( endpoint: EndpointConstant.profile);
      
      var json = jsonEncode(response.data["data"]);

      return profileModelFromJson(json);

    }catch(error, st){
      throw Exception(error);
    }
  }

  Future<RegistrationChecklistStatusModel> checklistStatus() async {
    try {
      Response response = await APIService.instance
          .post({}, endpoint: EndpointConstant.checklistStatus);

      var json = jsonEncode(response.data);

      return registrationChecklistStatusModelFromJson(json);
    } catch (error, st) {
      log("xxxx register repo $error $st");
      rethrow;
    }
  }

  Future<void> lastLoginUpdate() async {
    try {
      Response response = await APIService.instance
          .post({}, endpoint: EndpointConstant.lastLogin);

    } catch (error, st) {
      log("xxxx lastLoginUpdate repo $error $st");
      rethrow;
    }
  }

  Future<Response> forgotPassword({required String email}) async {
    try {
      var formData = FormData.fromMap({
        "email": email,
      });
      Response response = await APIService.instance
          .post(formData, endpoint: EndpointConstant.forgotPassword);

      return response;
    } catch (error, st) {
      log("xxxx $error $st");
      rethrow;
    }
  }

  Future<Response> uploadProfilePicture({required File avatar}) async {
    try {
      var formData = FormData.fromMap({
        "profile_image": MultipartFile.fromFileSync(avatar.path),
      });
      Response response = await APIService.instance
          .post(formData, endpoint: EndpointConstant.profileAvatar);

      return response;
    } catch (error, st) {
      log("xxxx $error $st");
      rethrow;
    }
  }

  Future<Response> changePreferWorkingArea({required String city}) async {
    try {
      var formData = FormData.fromMap({
        "city": city,
      });
      Response response = await APIService.instance
          .post(formData, endpoint: EndpointConstant.changePreferWorkingArea);

      return response;
    } catch (error, st) {
      log("xxxx $error $st");
      rethrow;
    }
  }
}
