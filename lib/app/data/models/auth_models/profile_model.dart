// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  int? id;
  String? uuid;
  String? name;
  String? email;
  dynamic identificationNo;
  dynamic referrerCode;
  int? referrerIsActive;
  dynamic apiToken;
  String? deviceToken;
  int? isConsentGiven;
  int? paidRegistrationFee;
  int? isMerchantParked;
  int? registrationFeeRefunded;
  int? quizScore;
  dynamic stripeId;
  dynamic cardBrand;
  dynamic cardLastFour;
  dynamic trialEndsAt;
  dynamic braintreeId;
  dynamic paypalEmail;
  String? mobile;
  dynamic crmId;
  dynamic leadId;
  dynamic aeonId;
  String? totalEarnings;
  String? earningsBalance;
  dynamic isParttime;
  int? isParcelDriver;
  dynamic parcelDriverType;
  dynamic parcelDriverStatus;
  dynamic merchant;
  dynamic hub;
  dynamic merchantId;
  dynamic hubId;
  dynamic secondaryMerchantId;
  dynamic secondaryHubId;
  dynamic workingRegion;
  String? city;
  dynamic adopter;
  dynamic lastModifiedDriverStatus;
  dynamic estimateStartDate;
  dynamic parcelQuitDate;
  dynamic parcelStartDate;
  dynamic emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  dynamic gauthId;
  dynamic gauthType;
  dynamic facebookId;
  int? isLastMileDriver;
  String? profilePhotoUrl;
  String? profilePhotoImageUrl;
  Profile? profile;
  String? preferredCityLocation;
  String? preferredStateLocation;


  ProfileModel({
    this.id,
    this.uuid,
    this.name,
    this.email,
    this.identificationNo,
    this.referrerCode,
    this.referrerIsActive,
    this.apiToken,
    this.deviceToken,
    this.isConsentGiven,
    this.paidRegistrationFee,
    this.isMerchantParked,
    this.registrationFeeRefunded,
    this.quizScore,
    this.stripeId,
    this.cardBrand,
    this.cardLastFour,
    this.trialEndsAt,
    this.braintreeId,
    this.paypalEmail,
    this.mobile,
    this.crmId,
    this.leadId,
    this.aeonId,
    this.totalEarnings,
    this.earningsBalance,
    this.isParttime,
    this.isParcelDriver,
    this.parcelDriverType,
    this.parcelDriverStatus,
    this.merchant,
    this.hub,
    this.merchantId,
    this.hubId,
    this.secondaryMerchantId,
    this.secondaryHubId,
    this.workingRegion,
    this.city,
    this.adopter,
    this.lastModifiedDriverStatus,
    this.estimateStartDate,
    this.parcelQuitDate,
    this.parcelStartDate,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.gauthId,
    this.gauthType,
    this.facebookId,
    this.isLastMileDriver,
    this.profilePhotoUrl,
    this.profilePhotoImageUrl,
    this.profile,
    this.preferredCityLocation,
    this.preferredStateLocation,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    id: json["id"],
    uuid: json["uuid"],
    name: json["name"],
    email: json["email"],
    identificationNo: json["identification_no"],
    referrerCode: json["referrer_code"],
    referrerIsActive: json["referrer_is_active"],
    apiToken: json["api_token"],
    deviceToken: json["device_token"],
    isConsentGiven: json["is_consent_given"],
    paidRegistrationFee: json["paid_registration_fee"],
    isMerchantParked: json["is_merchant_parked"],
    registrationFeeRefunded: json["registration_fee_refunded"],
    quizScore: json["quiz_score"],
    stripeId: json["stripe_id"],
    cardBrand: json["card_brand"],
    cardLastFour: json["card_last_four"],
    trialEndsAt: json["trial_ends_at"],
    braintreeId: json["braintree_id"],
    paypalEmail: json["paypal_email"],
    mobile: json["mobile"],
    crmId: json["crm_id"],
    leadId: json["lead_id"],
    aeonId: json["aeon_id"],
    totalEarnings: json["total_earnings"],
    earningsBalance: json["earnings_balance"],
    isParttime: json["is_parttime"],
    isParcelDriver: json["is_parcel_driver"],
    parcelDriverType: json["parcel_driver_type"],
    parcelDriverStatus: json["parcel_driver_status"],
    merchant: json["merchant"],
    hub: json["hub"],
    merchantId: json["merchant_id"],
    hubId: json["hub_id"],
    secondaryMerchantId: json["secondary_merchant_id"],
    secondaryHubId: json["secondary_hub_id"],
    workingRegion: json["working_region"],
    city: json["city"],
    adopter: json["adopter"],
    lastModifiedDriverStatus: json["last_modified_driver_status"],
    estimateStartDate: json["estimate_start_date"],
    parcelQuitDate: json["parcel_quit_date"],
    parcelStartDate: json["parcel_start_date"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    gauthId: json["gauth_id"],
    gauthType: json["gauth_type"],
    facebookId: json["facebook_id"],
    isLastMileDriver: json["is_last_mile_driver"],
    profilePhotoUrl: json["profile_photo_url"],
    profilePhotoImageUrl: json["profile_photo_image_url"],
    preferredCityLocation: json["preferred_city"],
    preferredStateLocation: json["preferred_state"],
    profile: json["profile"] == null ? null : Profile.fromJson(json["profile"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "name": name,
    "email": email,
    "identification_no": identificationNo,
    "referrer_code": referrerCode,
    "referrer_is_active": referrerIsActive,
    "api_token": apiToken,
    "device_token": deviceToken,
    "is_consent_given": isConsentGiven,
    "paid_registration_fee": paidRegistrationFee,
    "is_merchant_parked": isMerchantParked,
    "registration_fee_refunded": registrationFeeRefunded,
    "quiz_score": quizScore,
    "stripe_id": stripeId,
    "card_brand": cardBrand,
    "card_last_four": cardLastFour,
    "trial_ends_at": trialEndsAt,
    "braintree_id": braintreeId,
    "paypal_email": paypalEmail,
    "mobile": mobile,
    "crm_id": crmId,
    "lead_id": leadId,
    "aeon_id": aeonId,
    "total_earnings": totalEarnings,
    "earnings_balance": earningsBalance,
    "is_parttime": isParttime,
    "is_parcel_driver": isParcelDriver,
    "parcel_driver_type": parcelDriverType,
    "parcel_driver_status": parcelDriverStatus,
    "merchant": merchant,
    "hub": hub,
    "merchant_id": merchantId,
    "hub_id": hubId,
    "secondary_merchant_id": secondaryMerchantId,
    "secondary_hub_id": secondaryHubId,
    "working_region": workingRegion,
    "city": city,
    "adopter": adopter,
    "last_modified_driver_status": lastModifiedDriverStatus,
    "estimate_start_date": estimateStartDate,
    "parcel_quit_date": parcelQuitDate,
    "parcel_start_date": parcelStartDate,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "gauth_id": gauthId,
    "gauth_type": gauthType,
    "facebook_id": facebookId,
    "is_last_mile_driver": isLastMileDriver,
    "profile_photo_url": profilePhotoUrl,
    "profile_photo_image_url": profilePhotoImageUrl,
    "preferred_city": preferredCityLocation,
    "preferred_state": preferredStateLocation,
    "profile": profile?.toJson(),
  };
}

class Profile {
  int? id;
  int? userId;
  String? city;
  String? state;
  dynamic postalCode;
  dynamic hasAndroidPhone;
  dynamic hasApplePhone;
  dynamic address;
  dynamic licenseNo;
  dynamic drivingLicenseNumber;
  dynamic drivingLicenseExpiry;
  dynamic vocationalLicenseNumber;
  dynamic vocationalLicenseExpiry;
  dynamic bankName;
  dynamic bankAccountNo;
  dynamic bankAccountHolderName;
  int? workSunday;
  int? workMonday;
  int? workTuesday;
  int? workWednesday;
  int? workThursday;
  int? workFriday;
  int? workSaturday;
  int? isRenter;
  dynamic carModel;
  dynamic carPlateNo;
  dynamic carColour;
  dynamic carYear;
  dynamic nextOfKinName;
  dynamic nextOfKinNric;
  dynamic nextOfKinMobile;
  dynamic nextOfKinAddress;
  dynamic nextOfKinRelationship;
  dynamic secondaryNextOfKinName;
  dynamic secondaryNextOfKinNric;
  dynamic secondaryNextOfKinMobile;
  dynamic secondaryNextOfKinAddress;
  dynamic secondaryNextOfKinRelationship;
  dynamic gender;
  int? isMalaysian;
  dynamic ethnicity;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  dynamic epfNo;

  Profile({
    this.id,
    this.userId,
    this.city,
    this.state,
    this.postalCode,
    this.hasAndroidPhone,
    this.hasApplePhone,
    this.address,
    this.licenseNo,
    this.drivingLicenseNumber,
    this.drivingLicenseExpiry,
    this.vocationalLicenseNumber,
    this.vocationalLicenseExpiry,
    this.bankName,
    this.bankAccountNo,
    this.bankAccountHolderName,
    this.workSunday,
    this.workMonday,
    this.workTuesday,
    this.workWednesday,
    this.workThursday,
    this.workFriday,
    this.workSaturday,
    this.isRenter,
    this.carModel,
    this.carPlateNo,
    this.carColour,
    this.carYear,
    this.nextOfKinName,
    this.nextOfKinNric,
    this.nextOfKinMobile,
    this.nextOfKinAddress,
    this.nextOfKinRelationship,
    this.secondaryNextOfKinName,
    this.secondaryNextOfKinNric,
    this.secondaryNextOfKinMobile,
    this.secondaryNextOfKinAddress,
    this.secondaryNextOfKinRelationship,
    this.gender,
    this.isMalaysian,
    this.ethnicity,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.epfNo,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["id"],
    userId: json["user_id"],
    city: json["city"],
    state: json["state"],
    postalCode: json["postal_code"],
    hasAndroidPhone: json["has_android_phone"],
    hasApplePhone: json["has_apple_phone"],
    address: json["address"],
    licenseNo: json["license_no"],
    drivingLicenseNumber: json["driving_license_number"],
    drivingLicenseExpiry: json["driving_license_expiry"],
    vocationalLicenseNumber: json["vocational_license_number"],
    vocationalLicenseExpiry: json["vocational_license_expiry"],
    bankName: json["bank_name"],
    bankAccountNo: json["bank_account_no"],
    bankAccountHolderName: json["bank_account_holder_name"],
    workSunday: json["work_sunday"],
    workMonday: json["work_monday"],
    workTuesday: json["work_tuesday"],
    workWednesday: json["work_wednesday"],
    workThursday: json["work_thursday"],
    workFriday: json["work_friday"],
    workSaturday: json["work_saturday"],
    isRenter: json["is_renter"],
    carModel: json["car_model"],
    carPlateNo: json["car_plate_no"],
    carColour: json["car_colour"],
    carYear: json["car_year"],
    nextOfKinName: json["next_of_kin_name"],
    nextOfKinNric: json["next_of_kin_nric"],
    nextOfKinMobile: json["next_of_kin_mobile"],
    nextOfKinAddress: json["next_of_kin_address"],
    nextOfKinRelationship: json["next_of_kin_relationship"],
    secondaryNextOfKinName: json["secondary_next_of_kin_name"],
    secondaryNextOfKinNric: json["secondary_next_of_kin_nric"],
    secondaryNextOfKinMobile: json["secondary_next_of_kin_mobile"],
    secondaryNextOfKinAddress: json["secondary_next_of_kin_address"],
    secondaryNextOfKinRelationship: json["secondary_next_of_kin_relationship"],
    gender: json["gender"],
    isMalaysian: json["is_malaysian"],
    ethnicity: json["ethnicity"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
    epfNo: json["epf_no"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "city": city,
    "state": state,
    "postal_code": postalCode,
    "has_android_phone": hasAndroidPhone,
    "has_apple_phone": hasApplePhone,
    "address": address,
    "license_no": licenseNo,
    "driving_license_number": drivingLicenseNumber,
    "driving_license_expiry": drivingLicenseExpiry,
    "vocational_license_number": vocationalLicenseNumber,
    "vocational_license_expiry": vocationalLicenseExpiry,
    "bank_name": bankName,
    "bank_account_no": bankAccountNo,
    "bank_account_holder_name": bankAccountHolderName,
    "work_sunday": workSunday,
    "work_monday": workMonday,
    "work_tuesday": workTuesday,
    "work_wednesday": workWednesday,
    "work_thursday": workThursday,
    "work_friday": workFriday,
    "work_saturday": workSaturday,
    "is_renter": isRenter,
    "car_model": carModel,
    "car_plate_no": carPlateNo,
    "car_colour": carColour,
    "car_year": carYear,
    "next_of_kin_name": nextOfKinName,
    "next_of_kin_nric": nextOfKinNric,
    "next_of_kin_mobile": nextOfKinMobile,
    "next_of_kin_address": nextOfKinAddress,
    "next_of_kin_relationship": nextOfKinRelationship,
    "secondary_next_of_kin_name": secondaryNextOfKinName,
    "secondary_next_of_kin_nric": secondaryNextOfKinNric,
    "secondary_next_of_kin_mobile": secondaryNextOfKinMobile,
    "secondary_next_of_kin_address": secondaryNextOfKinAddress,
    "secondary_next_of_kin_relationship": secondaryNextOfKinRelationship,
    "gender": gender,
    "is_malaysian": isMalaysian,
    "ethnicity": ethnicity,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "epf_no": epfNo,
  };
}
