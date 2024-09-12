import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart' as getx;
import 'package:dio/dio.dart';
import 'package:hero/app/core/core_index.dart';
import 'package:hero/app/data/constants/endpoints_constant.dart';
import 'package:hero/app/data/models/auth_models/checklist_personal_info_models/checklist_bank_info_model.dart';
import 'package:hero/app/data/models/auth_models/checklist_personal_info_models/checklist_emergency_contact_status_model.dart';
import 'package:hero/app/data/models/auth_models/checklist_personal_info_models/checklist_license_info_model.dart';
import 'package:hero/app/data/models/auth_models/checklist_personal_info_models/checklist_onboarding_quizes_model.dart';
import 'package:hero/app/data/models/auth_models/checklist_personal_info_models/checklist_personal_info_model.dart';
import 'package:hero/app/data/models/auth_models/checklist_personal_info_models/checklist_product_info_status_model.dart';
import 'package:hero/app/data/models/auth_models/checklist_personal_info_models/emergency_contact_update_param.dart';
import 'package:hero/app/data/models/auth_models/checklist_personal_info_models/personal_info_update_param_model.dart';
import 'package:hero/app/data/models/auth_models/checklist_personal_info_models/checklist_vehicle_info_status_model.dart';
import 'package:hero/app/data/models/auth_models/checklist_personal_info_models/quiz_onboarding_result_model.dart';
import 'package:hero/app/data/models/auth_models/checklist_personal_info_models/vehicle_info_update_param_model.dart';

import '../../models/auth_models/checklist_personal_info_models/checklist_onboarding_model.dart';

class RegisterChecklistRepository {
  static RegisterChecklistRepository get instance =>
      getx.Get.find<RegisterChecklistRepository>();

  Future<PersonalInfoStatusModel> getPersonalInfoStatus() async {
    try {
      Response response = await APIService.instance
          .get(endpoint: EndpointConstant.personalInfoStatus);

      var json = jsonEncode(response.data);

      return personalInfoStatusModelFromJson(json);
    } catch (error, st) {
      log("xxxx getPersonalInfoStatus $error", stackTrace: st);
      rethrow;
    }
  }

  Future<Response> updatePersonalInfo(
      {required PersonalInfoUpdateParam param}) async {
    try {
      var formData = FormData.fromMap({
        "identification_no": param.identificationNo,
        "address": param.address,
        "state": param.state,
        "city": param.city,
        "name": param.name,
        "mobile": param.mobile,
        "postal_code": param.postalCode,
        if (param.icFrontImage != null)
          "ic_front_image":
              MultipartFile.fromFileSync(param.icFrontImage!.path),
        if (param.icBackImage != null)
          "ic_back_image": MultipartFile.fromFileSync(param.icBackImage!.path),
      });

      Response response = await APIService.instance
          .post(formData, endpoint: EndpointConstant.personalInfoUpdate);

      return response;
    } catch (error, st) {
      log("xxxx register repo $error $st");
      rethrow;
    }
  }

  Future<Response> personalInfoRemoveFrontIC() async {
    try {
      var formData = FormData.fromMap({});

      Response response = await APIService.instance
          .post(formData, endpoint: EndpointConstant.personalInfoRemoveFrontIc);

      return response;
    } catch (error, st) {
      log("xxxx register repo $error $st");
      rethrow;
    }
  }

  Future<Response> personalInfoRemoveBackIC() async {
    try {
      var formData = FormData.fromMap({});

      Response response = await APIService.instance
          .post(formData, endpoint: EndpointConstant.personalInfoRemoveBackIc);

      return response;
    } catch (error, st) {
      log("xxxx register repo $error $st");
      rethrow;
    }
  }

  ///---------------------------------------------------------------------------

  Future<LicenseInfoStatusModel> getLicenseInfoStatus() async {
    try {
      Response response = await APIService.instance
          .get(endpoint: EndpointConstant.licenseInfoStatus);

      var json = jsonEncode(response.data);

      return licenseInfoStatusModelFromJson(json);
    } catch (error, st) {
      log("xxxx getLicenseInfoStatus $error", stackTrace: st);
      rethrow;
    }
  }

  Future<Response> licenseCDLAdd({required String licenseUUID}) async {
    try {
      var formData =
          FormData.fromMap({"driving_license_type_uuid": licenseUUID});

      Response response = await APIService.instance
          .post(formData, endpoint: EndpointConstant.licenseCDLAdd);

      return response;
    } catch (error, st) {
      log("xxxx licenseCDLAdd repo $error $st");
      rethrow;
    }
  }

  Future<Response> licenseCDLUpdate(
      {required String licenseNumber,
      required String expiry,
      required File? licensePhoto}) async {
    try {
      var formData = FormData.fromMap({
        "driving_license_number": licenseNumber,
        "driving_license_expiry": expiry,
        if (licensePhoto != null)
          "driving_license_photo":
              MultipartFile.fromFileSync(licensePhoto.path),
      });

      Response response = await APIService.instance
          .post(formData, endpoint: EndpointConstant.licenseCDLUpdate);

      return response;
    } catch (error, st) {
      log("xxxx licenseCDLUpdate repo $error $st");
      rethrow;
    }
  }

  Future<Response> licenseVDLAdd({required String licenseUUID}) async {
    try {
      var formData =
          FormData.fromMap({"vocational_license_type_uuid": licenseUUID});

      Response response = await APIService.instance
          .post(formData, endpoint: EndpointConstant.licenseVDLAdd);

      return response;
    } catch (error, st) {
      log("xxxx licenseVDLAdd repo $error $st");
      rethrow;
    }
  }

  Future<Response> licenseVDLUpdate(
      {required String licenseNumber,
      required String expiry,
      required File? licensePhoto}) async {
    try {
      var formData = FormData.fromMap({
        "vocational_license_number": licenseNumber,
        "vocational_license_expiry": expiry,
        if (licensePhoto != null)
          "vocational_license_photo":
              MultipartFile.fromFileSync(licensePhoto.path),
      });

      Response response = await APIService.instance
          .post(formData, endpoint: EndpointConstant.licenseVDLUpdate);

      return response;
    } catch (error, st) {
      log("xxxx licenseVDLUpdate repo $error $st");
      rethrow;
    }
  }

  Future<Response> licenseClassDelete({required String licenseUUID}) async {
    try {
      var formData = FormData.fromMap({});

      Response response = await APIService.instance.post(formData,
          endpoint: EndpointConstant.licenseClassDelete(id: licenseUUID));

      return response;
    } catch (error, st) {
      log("xxxx licenseClassDelete repo $error $st");
      rethrow;
    }
  }

  ///---------------------------------------------------------------------------

  Future<BankInfoStatusModel> getBankStatus() async {
    try {
      Response response = await APIService.instance
          .get(endpoint: EndpointConstant.bankInfoStatus);

      var json = jsonEncode(response.data);

      return bankInfoStatusModelFromJson(json);
    } catch (error, st) {
      log("xxxx getBankStatus $error", stackTrace: st);
      rethrow;
    }
  }

  Future<Response> bankInfoUpdate(
      {required String bankName,
      required String bankAccountNo,
      required String accountHolderName,
      required File? bankStatement}) async {
    try {
      var formData = FormData.fromMap({
        "bank_name": bankName,
        "bank_account_no": bankAccountNo,
        "bank_account_holder_name": accountHolderName,
        if (bankStatement != null)
          "bank_statement": MultipartFile.fromFileSync(bankStatement.path),
      });

      Response response = await APIService.instance
          .post(formData, endpoint: EndpointConstant.bankInfoUpdate);

      return response;
    } catch (error, st) {
      log("xxxx licenseVDLUpdate repo $error $st");
      rethrow;
    }
  }

  Future<Response> bankInfoRemoveBankStatement() async {
    try {
      var formData = FormData.fromMap({});

      Response response = await APIService.instance.post(formData,
          endpoint: EndpointConstant.bankInfoRemoveBankStatement);

      return response;
    } catch (error, st) {
      log("xxxx licenseVDLUpdate repo $error $st");
      rethrow;
    }
  }

  ///---------------------------------------------------------------------------

  Future<EmergencyContactStatusModel> getEmergencyContactStatus() async {
    try {
      Response response = await APIService.instance
          .get(endpoint: EndpointConstant.emergencyContactStatus);

      var json = jsonEncode(response.data);

      return emergencyContactStatusModelFromJson(json);
    } catch (error, st) {
      log("xxxx getBankStatus $error", stackTrace: st);
      rethrow;
    }
  }

  Future<Response> emergencyContactUpdate(
      {required EmergencyContactUpdateParam param}) async {
    try {
      var formData = FormData.fromMap({
        if (param.nextOfKinName != null)
          'next_of_kin_name': param.nextOfKinName,
        if (param.nextOfKinNric != null)
          'next_of_kin_nric': param.nextOfKinNric,
        if (param.nextOfKinMobile != null)
          'next_of_kin_mobile': param.nextOfKinMobile,
        if (param.nextOfKinAddress != null)
          'next_of_kin_address': param.nextOfKinAddress,
        if (param.nextOfKinRelationship != null)
          'next_of_kin_relationship': param.nextOfKinRelationship,
        if (param.secondaryNextOfKinName != null)
          'secondary_next_of_kin_name': param.secondaryNextOfKinName,
        if (param.secondaryNextOfKinNric != null)
          'secondary_next_of_kin_nric': param.secondaryNextOfKinNric,
        if (param.secondaryNextOfKinMobile != null)
          'secondary_next_of_kin_mobile': param.secondaryNextOfKinMobile,
        if (param.secondaryNextOfKinAddress != null)
          'secondary_next_of_kin_address': param.secondaryNextOfKinAddress,
        if (param.secondaryNextOfKinRelationship != null)
          'secondary_next_of_kin_relationship':
              param.secondaryNextOfKinRelationship,
        if (param.nextOfKinFrontIcPhoto != null)
          'next_of_kin_front_ic_photo': MultipartFile.fromFileSync(
              param.nextOfKinFrontIcPhoto?.path ?? ''),
        if (param.nextOfKinBackIcPhoto != null)
          'next_of_kin_back_ic_photo': MultipartFile.fromFileSync(
              param.nextOfKinBackIcPhoto?.path ?? ''),
        if (param.secondaryNextOfKinFrontIcPhoto != null)
          'secondary_next_of_kin_front_ic_photo': MultipartFile.fromFileSync(
              param.secondaryNextOfKinFrontIcPhoto?.path ?? ''),
        if (param.secondaryNextOfKinBackIcPhoto != null)
          'secondary_next_of_kin_back_ic_photo': MultipartFile.fromFileSync(
              param.secondaryNextOfKinBackIcPhoto?.path ?? ''),
      });

      Response response = await APIService.instance
          .post(formData, endpoint: EndpointConstant.emergencyContactUpdate);

      return response;
    } catch (error, st) {
      log("xxxx licenseVDLUpdate repo $error $st");
      rethrow;
    }
  }

  Future<Response> emergencyContactRemoveNRIC(
      {required bool isFirstContact, required bool isFront}) async {
    try {
      var formData = FormData.fromMap({});

      late final Response response;

      if (isFirstContact && isFront) {
        response = await APIService.instance.post(formData,
            endpoint: EndpointConstant.emergencyContactFirstRemoveFrontIC);
      } else if (isFirstContact && !isFront) {
        response = await APIService.instance.post(formData,
            endpoint: EndpointConstant.emergencyContactFirstRemoveBackIC);
      } else if (!isFirstContact && isFront) {
        response = await APIService.instance.post(formData,
            endpoint: EndpointConstant.emergencyContactSecondRemoveFrontIC);
      } else {
        response = await APIService.instance.post(formData,
            endpoint: EndpointConstant.emergencyContactSecondRemoveBackIC);
      }

      return response;
    } catch (error, st) {
      log("xxxx register repo $error $st");
      rethrow;
    }
  }

  ///---------------------------------------------------------------------------

  Future<VehicleInfoStatusModel> getVehicleInfoStatus() async {
    try {
      Response response = await APIService.instance
          .get(endpoint: EndpointConstant.vehicleInfoStatus);

      var json = jsonEncode(response.data);

      return vehicleInfoStatusModelFromJson(json);
    } catch (error, st) {
      log("xxxx getBankStatus $error", stackTrace: st);
      rethrow;
    }
  }

  Future<Response> vehicleInfoAdd(
      {required VehicleInfoUpdateParamModel param}) async {
    try {
      var formData = FormData.fromMap({
        'transportation_type_uuid': param.transportationTypeId,
        'model': param.model,
        'plate_number': param.plateNumber,
        'color': param.color,
        'year': param.year,
        'road_tax_expiry_date': param.roadTaxExpiryDate,
        'transportation_photo':
            MultipartFile.fromFileSync(param.transportationPhoto?.path ?? ''),
        'road_tax_photo':
            MultipartFile.fromFileSync(param.roadTaxPhoto?.path ?? ''),
      });

      Response response = await APIService.instance
          .post(formData, endpoint: EndpointConstant.vehicleInfoStore);

      return response;
    } catch (error, st) {
      log("xxxx licenseVDLUpdate repo $error $st");
      rethrow;
    }
  }

  Future<Response> vehicleInfoUpdate(
      {required VehicleInfoUpdateParamModel param}) async {
    try {
      var formData = FormData.fromMap({
        'transportation_type_uuid': param.transportationTypeId,
        'model': param.model,
        'plate_number': param.plateNumber,
        'color': param.color,
        'year': param.year,
        'road_tax_expiry_date': param.roadTaxExpiryDate,
        if (param.transportationPhoto != null)
          'transportation_photo':
              MultipartFile.fromFileSync(param.transportationPhoto?.path ?? ''),
        if (param.roadTaxPhoto != null)
          'road_tax_photo':
              MultipartFile.fromFileSync(param.roadTaxPhoto?.path ?? ''),
      });

      Response response = await APIService.instance.post(formData,
          endpoint: EndpointConstant.vehicleInfoUpdate(id: param.uuid ?? ''));

      return response;
    } catch (error, st) {
      log("xxxx licenseVDLUpdate repo $error $st");
      rethrow;
    }
  }

  Future<Response> vehicleInfoDelete({required String uuid}) async {
    try {
      var formData = FormData.fromMap({});

      Response response = await APIService.instance.post(formData,
          endpoint: EndpointConstant.vehicleInfoDelete(id: uuid));

      return response;
    } catch (error, st) {
      log("xxxx licenseVDLUpdate repo $error $st");
      rethrow;
    }
  }

  Future<Response> vehicleRemoveImage({required String uuid}) async {
    try {
      var formData = FormData.fromMap({});

      Response response = await APIService.instance.post(formData,
          endpoint: EndpointConstant.vehicleInfoRemoveImage(id: uuid));

      return response;
    } catch (error, st) {
      log("xxxx vehicleRemoveImage repo $error $st");
      rethrow;
    }
  }

  Future<Response> vehicleRemoveRoadTaxImage({required String uuid}) async {
    try {
      var formData = FormData.fromMap({});

      Response response = await APIService.instance.post(formData,
          endpoint: EndpointConstant.vehicleInfoRemoveRoadTaxImage(id: uuid));

      return response;
    } catch (error, st) {
      log("xxxx vehicleRemoveRoadTaxImage repo $error $st");
      rethrow;
    }
  }

  ///--------------------------------------------------------------------------

  Future<ProductInfoStatusModel> getProductInfoStatusModel() async {
    try {
      Response response = await APIService.instance
          .get(endpoint: EndpointConstant.productInfoStatus);

      var json = jsonEncode(response.data);

      return productInfoStatusModelFromJson(json);
    } catch (error, st) {
      log("xxxx getProductInfoStatusModel $error", stackTrace: st);
      rethrow;
    }
  }

  ///--------------------------------------------------------------------------

  Future<List<ChecklistOnboardingModel>> getOnboardingChecklist(
      {required String assignmentUUID}) async {
    try {
      var formData = FormData.fromMap({});

      Response response = await APIService.instance.post(formData,
          endpoint: EndpointConstant.onboardingChecklist(
              assignmentUUID: assignmentUUID));

      var json = jsonEncode(response.data["onboarding_quizzes"]);

      return checklistOnboardingModelFromJson(json);
    } catch (error, st) {
      log("xxxx getOnboardingChecklist $error", stackTrace: st);
      rethrow;
    }
  }

  Future<ChecklistOnboardingQuizzesModel> getOnboardingQuizzes(
      {required String assignmentUUID, required String quizUUID,}) async {
    try {
      var formData = FormData.fromMap({});


      Response response = await APIService.instance.post(formData,
          endpoint: EndpointConstant.onboardingQuizzes(
              assignmentUUID: assignmentUUID, quizUUID: quizUUID));

      var json = jsonEncode(response.data);

      return checklistOnboardingQuizzesModelFromJson(json);
    } catch (error, st) {
      log("xxxx getOnboardingQuizzes $error", stackTrace: st);
      rethrow;
    }
  }

  Future<QuizOnboardingResultModel> submitQuizAnswer(
      {required String assignmentUUID, required String quizUUID, required OnboardingQuiz quiz,}) async {
    try {
      var formData = FormData.fromMap({});
      for(var item in quiz.quizzes ?? <Quiz>[]){
        formData.fields.add(MapEntry("answers[]", (item.indexAnswer ?? 0).toString()));
      }

      Response response = await APIService.instance.post(formData,
          endpoint: EndpointConstant.answerQuizzes(
              assignmentUUID: assignmentUUID, quizUUID: quizUUID));

      var str = jsonEncode(response.data);
      return quizOnboardingResultModelFromJson(str);
    } catch (error, st) {
      log("xxxx getOnboardingQuizzes $error", stackTrace: st);
      rethrow;
    }
  }
}
