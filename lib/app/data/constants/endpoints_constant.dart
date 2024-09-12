/**
 * Created by Haziq 23/04/22
 */

class EndpointConstant {

  ///AUTH
  static const String login = "/auth/login";
  static const String forgotPassword = "/auth/forgot-password";
  static const String register = "/auth/register";
  static const String profile = "/account";
  static const String profileAvatar = "/account/change-avatar";
  static const String changePreferWorkingArea = "/account/change-prefer-working-area";
  static const String lastLogin = "/account/last-login";


  ///---------------------------------------------------------------------------

  ///REGISTER CHECKLIST
  static const String checklistStatus = "/dashboard/checklist-status";

  /// PERSONAL CHECKLIST
  static const String personalInfoStatus = "/registration-checklist/personal-info-checklist-status";
  static const String personalInfoUpdate = "/registration-checklist/personal-info-checklist-status/update";
  static const String personalInfoRemoveFrontIc = "/registration-checklist/personal-info-checklist-status/remove/front-ic-photo";
  static const String personalInfoRemoveBackIc = "/registration-checklist/personal-info-checklist-status/remove/back-ic-photo";

  /// LICENSE CHECKLIST
  static const String licenseInfoStatus = "/registration-checklist/license-info-checklist-status";
  static const String licenseCDLUpdate = "/registration-checklist/license-info-checklist-status/driving-license";
  static const String licenseVDLUpdate = "/registration-checklist/license-info-checklist-status/vocational-license";
  static const String licenseCDLAdd = "/registration-checklist/license-info-checklist-status/driving-license-class";
  static const String licenseVDLAdd = "/registration-checklist/license-info-checklist-status/vocational-license-class";
  static String licenseClassDelete({required String id}) => "/registration-checklist/license-info-checklist-status/user-license-class/$id/delete";
  static const String licenseCDLDeletePhoto = "/registration-checklist/license-info-checklist-status/remove/driving-license-photo";
  static const String licenseVDLDeletePhoto = "/registration-checklist/license-info-checklist-status/remove/vocational-license-photo";

  /// BANK CHECKLIST
  static const String bankInfoStatus = "/registration-checklist/bank-info-checklist-status";
  static const String bankInfoUpdate = "/registration-checklist/bank-info-checklist-status/update";
  static const String bankInfoRemoveBankStatement = "/registration-checklist/bank-info-checklist-status/remove/bank-statement-photo";


  /// EMERGENCY CONTACT CHECKLIST
  static const String emergencyContactStatus = "/registration-checklist/emergency-contact-info-checklist-status";
  static const String emergencyContactUpdate = "/registration-checklist/emergency-contact-info-checklist-status/update";
  static const String emergencyContactFirstRemoveFrontIC = "/registration-checklist/emergency-contact-info-checklist-status/remove/next-of-kin-front-ic-photo";
  static const String emergencyContactSecondRemoveFrontIC = "/registration-checklist/emergency-contact-info-checklist-status/remove/secondary-next-of-kin-front-ic-photo";
  static const String emergencyContactFirstRemoveBackIC = "/registration-checklist/emergency-contact-info-checklist-status/remove/next-of-kin-back-ic-photo";
  static const String emergencyContactSecondRemoveBackIC = "/registration-checklist/emergency-contact-info-checklist-status/remove/secondary-next-of-kin-back-ic-photo";

  ///VEHICLE CHECKLIST
  static const String vehicleInfoStatus = "/registration-checklist/transportation-info-checklist-status";
  static const String vehicleInfoStore = "/registration-checklist/transportation-info-checklist-status/store";
  static String vehicleInfoUpdate({required String id}) => "/registration-checklist/transportation-info-checklist-status/$id/update";
  static String vehicleInfoDelete({required String id}) => "/registration-checklist/transportation-info-checklist-status/$id/delete";
  static String vehicleInfoRemoveImage({required String id}) => "/registration-checklist/transportation-info-checklist-status/$id/remove/vehicle-photo";
  static String vehicleInfoRemoveRoadTaxImage({required String id}) => "/registration-checklist/transportation-info-checklist-status/$id/remove/road-tax-photo";

  ///PRODUCT CHECKLIST
  static String productInfoStatus = "/registration-checklist/product-checklist-status";

  ///ONBOARDING CHECKLIST
  static String onboardingChecklist({required String assignmentUUID}) => "/registration-checklist/$assignmentUUID/onboarding-checklist-status";
  static String onboardingQuizzes({required String assignmentUUID, required String quizUUID}) => "/registration-checklist/$assignmentUUID/onboarding-checklist-quiz/$quizUUID/view";
  static String answerQuizzes({required String assignmentUUID, required String quizUUID}) => "/registration-checklist/$assignmentUUID/onboarding-checklist-quiz/$quizUUID/answer";


  ///---------------------------------------------------------------------------


  /// JOBS
  static const String jobList = "/jobs";
  static String jobDetail({required String id}) => "/jobs/$id";
  static String jobsApply({required String id}) => "/jobs/$id/apply";

  static const String assignedJobList = "/assigned-jobs";
  static String assignedJobDetail({required String id}) => "/assigned-jobs/$id";
  static String assignedJobQuit({required String id}) => "/assigned-jobs/quit/$id";

  static String podSubmit({required String id}) => "/assigned-jobs/$id/assignment-job/proof-of-delivery/submit";
  static String podView({required String id, required String podID}) => "/assigned-jobs/$id/assignment-job/proof-of-delivery/$podID/view";
  static String podUpdate({required String id, required String podID}) => "/assigned-jobs/$id/assignment-job/proof-of-delivery/$podID/update";
  static String podDelete({required String id, required String podID}) => "/assigned-jobs/$id/assignment-job/proof-of-delivery/$podID/delete";

  ///---------------------------------------------------------------------------

  ///MISC
  static const String states = "/misc/states";
  static const String cities = "/misc/cities";
  static const String transportationTypes = "/misc/transportation-types";
  static const String licenseType = "/misc/license-types";
  static const String productRole = "/misc/product-roles";
  static const String productRole2 = "/misc/product-roles-2";
  static const String merchants = "/misc/merchants";
  static const String vdlLicense = "/misc/vocational-license-types";
  static const String cdlLicense = "/misc/driving-license-types";
  static const String bankName = "/misc/banks";
  static const String availableLocationState = "/misc/available-location-states";
  static const String availableLocationCities = "/misc/available-location-cities";
  static const String contactRelationship = "/misc/emergency-contact-relationships";
  static const String registrationSource = "/misc/sources";


  ///---------------------------------------------------------------------------

  ///DASHBOARD
  static const String dashboardJob = "/dashboard/browse-jobs";
  static const String dashboardAssignedJob = "/dashboard/assigned-jobs";

  ///---------------------------------------------------------------------------

  ///MESSAGE
  static const String notificationList = "/messages/notifications";
  static String notificationDetail(String uuid) => "/messages/notifications/$uuid/view";

}
