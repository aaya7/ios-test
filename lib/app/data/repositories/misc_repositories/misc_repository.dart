import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart' as getx;
import 'package:dio/dio.dart';
import 'package:hero/app/core/core_index.dart';
import 'package:hero/app/data/constants/endpoints_constant.dart';
import 'package:hero/app/data/models/misc_models/dropdown_model.dart';
import 'package:hero/app/data/models/misc_models/product_role_model.dart';

class MiscRepository {
  static MiscRepository get instance => getx.Get.find<MiscRepository>();

  Future<List<String>> getState() async {
    try {
      Response response =
          await APIService.instance.get(endpoint: EndpointConstant.states);

      var json = jsonEncode(response.data["states"]);

      return List<String>.from(jsonDecode(json).map((x) => x));
    } catch (error, st) {
      log("xxxx getState repo $error $st");
      throw Exception(error);
    }
  }

  Future<List<DropdownModel>> getCities({required String state}) async {
    try {
      Response response = await APIService.instance
          .post({"state": state}, endpoint: EndpointConstant.cities);

      var json = jsonEncode(response.data["cities"]);

      return dropdownModelFromJson(json);
    } catch (error, st) {
      log("xxxx getCities repo $error $st");
      throw Exception(error);
    }
  }

  Future<List<DropdownModel>> getTransportationType() async {
    try {
      Response response = await APIService.instance
          .get(endpoint: EndpointConstant.transportationTypes);

      var json = jsonEncode(response.data["data"]);

      return dropdownModelFromJson(json);
    } catch (error, st) {
      log("xxxx getTransportationType repo $error $st");
      throw Exception(error);
    }
  }

  Future<List<DropdownModel>> getBankNameList() async {
    try {
      Response response =
          await APIService.instance.get(endpoint: EndpointConstant.bankName);

      var json = jsonEncode(response.data["banks"]);

      return dropdownModelFromJson(json);
    } catch (error, st) {
      log("xxxx getBankName repo $error $st");
      throw Exception(error);
    }
  }

  Future<List<DropdownModel>> getProductRoleListing() async {
    try {
      Response response =
      await APIService.instance.get(endpoint: EndpointConstant.productRole);

      var json = jsonEncode(response.data["product_roles"]);

      return dropdownModelFromJson(json);
    } catch (error, st) {
      log("xxxx getBankName repo $error $st");
      throw Exception(error);
    }
  }

  Future<List<DropdownModel>> getVDLLicenseType() async {
    try {
      Response response =
          await APIService.instance.get(endpoint: EndpointConstant.vdlLicense);

      var json = jsonEncode(response.data["data"]);

      return dropdownModelFromJson(json);
    } catch (error, st) {
      log("xxxx getLicenseType repo $error $st");
      throw Exception(error);
    }
  }

  Future<List<DropdownModel>> getCDLLicenseType() async {
    try {
      Response response =
          await APIService.instance.get(endpoint: EndpointConstant.cdlLicense);

      var json = jsonEncode(response.data["data"]);

      return dropdownModelFromJson(json);
    } catch (error, st) {
      log("xxxx getLicenseType repo $error $st");
      throw Exception(error);
    }
  }

  Future<List<DropdownModel>> getMerchantList() async {
    try {
      Response response =
      await APIService.instance.get(endpoint: EndpointConstant.merchants);

      var json = jsonEncode(response.data["merchants"]);

      return dropdownModelFromJson(json);
    } catch (error, st) {
      log("xxxx getLicenseType repo $error $st");
      throw Exception(error);
    }
  }

  Future<List<String>> getAvailableLocationStates() async {
    try {
      Response response =
      await APIService.instance.get(endpoint: EndpointConstant.availableLocationState);

      var json = jsonEncode(response.data);

      return List<String>.from(jsonDecode(json).map((x) => x));
    } catch (error, st) {
      log("xxxx getBankName repo $error $st");
      throw Exception(error);
    }
  }

  Future<List<String>> getContactRelationshipList() async {
    try {
      Response response =
      await APIService.instance.get(endpoint: EndpointConstant.contactRelationship);

      var json = jsonEncode(response.data['relationships']);

      return List<String>.from(jsonDecode(json).map((x) => x));
    } catch (error, st) {
      log("xxxx getContactRelationshipList repo $error $st");
      throw Exception(error);
    }
  }

  Future<List<String>> getAvailableLocationCities({required String state}) async {
    try {
      Response response =
      await APIService.instance.post( {
        "state" : state,
      }, endpoint: EndpointConstant.availableLocationCities);

      var json = jsonEncode(response.data);

      return List<String>.from(jsonDecode(json).map((x) => x));
    } catch (error, st) {
      log("xxxx getAvailableLocationCities repo $error $st");
      throw Exception(error);
    }
  }

  Future<List<DropdownModel>> getRegistrationSource() async {
    try {
      Response response =
      await APIService.instance.get(endpoint: EndpointConstant.registrationSource);

      var json = jsonEncode(response.data["sources"]);

      return dropdownModelFromJson(json);
    } catch (error, st) {
      log("xxxx getLicenseType repo $error $st");
      throw Exception(error);
    }
  }

  Future<ProductRoleModel> getProductRoleList() async {
    try {
      Response response =
      await APIService.instance.get(endpoint: EndpointConstant.productRole2);

      var json = jsonEncode(response.data);

      return productRoleModelFromJson(json);
    } catch (error, st) {
      log("xxxx getLicenseType repo $error $st");
      throw Exception(error);
    }
  }
}
