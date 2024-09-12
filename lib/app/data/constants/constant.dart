import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../core/services/local_db_services/local_db_services.dart';
import '../../core/widgets/info_dialog.dart';
import '../../core/widgets/loading_dialog.dart';
import 'color_constant.dart';

/**
 * Created by Haziq 23/04/22
 */

enum RecycleType {
  METAL,
  GLASS,
  PAPER,
  PLASTIC,
  EWASTE,
}

var imageNetworkHeader = {
  "Authorization":
  "Bearer ${LocalDBService.instance.getToken()}"
};

enum IdType {
  IC,
  ARMY_POLICE,
  PASSPORT,
  REGISTRATION,
}

enum StockTakeStatus {
  ON_HOLD,
  COMPLETED,
  SYNCED,
  CLOSED,
}

int getStockTakeStatus(StockTakeStatus status) {
  switch (status) {
    case StockTakeStatus.ON_HOLD:
      return 0;
    case StockTakeStatus.COMPLETED:
      return 1;

    default:
      return 0;
  }
}

int getStatusFromTitle(String status) {
  switch (status) {
    case "On Hold":
      return 0;
    case "Completed":
      return 1;
    case "Synced":
      return 2;
    case "Closed":
      return 3;

    default:
      return 0;
  }
}

StockTakeStatus getStatus(int status) {
  switch (status) {
    case 0:
      return StockTakeStatus.ON_HOLD;
    case 1:
      return StockTakeStatus.COMPLETED;

    default:
      return StockTakeStatus.ON_HOLD;
  }
}

Color getStatusColor(StockTakeStatus status) {
  switch (status) {
    case StockTakeStatus.ON_HOLD:
      return Colors.red;
    case StockTakeStatus.COMPLETED:
      return Colors.green;

    default:
      return Colors.red;
  }
}

enum AssignmentJobStatus {
  pendingRequest,
  newJob,
  pendingOnboarding,
  pendingRecruiter,
  pendingReactivation,
  pendingDeployment,
  preActive,
  active,
  standby,
  inactive,
  rejected,
  cancelled,
  pendingAttachment,
}

enum PODStatus {
  completed,
  pendingValidation,
  pendingDuplicateValidation,
  rejected,
  clockIn,
  clockOut,
}

extension AssignmentStatusID on AssignmentJobStatus {
  int get getID {
    switch (this) {
      case AssignmentJobStatus.pendingRequest:
        return 1;
      // newJob,
      case AssignmentJobStatus.newJob:
        return 2;
      // pendingOnboarding,
      case AssignmentJobStatus.pendingOnboarding:
        return 5;
      // pendingRecruiter,
      case AssignmentJobStatus.pendingRecruiter:
        return 7;
      // pendingReactivation,
      case AssignmentJobStatus.pendingReactivation:
        return 9;
      // pendingDeployment,
      case AssignmentJobStatus.pendingDeployment:
        return 6;
      // preActive,
      case AssignmentJobStatus.preActive:
        return 3;
      // active,
      case AssignmentJobStatus.active:
        return 4;
      // standby,
      case AssignmentJobStatus.standby:
        return 8;
      // inactive,
      case AssignmentJobStatus.inactive:
        return 10;
      // rejected,
      case AssignmentJobStatus.rejected:
        return 11;
      // cancelled,
      case AssignmentJobStatus.cancelled:
        return 13;
      // blacklist,
      case AssignmentJobStatus.pendingAttachment:
        return 12;
    }
  }

  static AssignmentJobStatus fromID(int id) {
    switch (id) {
      case 1:
        return AssignmentJobStatus.pendingRequest;
      // newJob,
      case 2:
        return AssignmentJobStatus.newJob;
      // pendingOnboarding,
      case 5:
        return AssignmentJobStatus.pendingOnboarding;
      // pendingRecruiter,
      case 7:
        return AssignmentJobStatus.pendingRecruiter;
      // pendingReactivation,
      case 9:
        return AssignmentJobStatus.pendingReactivation;
      // pendingDeployment,
      case 6:
        return AssignmentJobStatus.pendingDeployment;
      // preActive,
      case 3:
        return AssignmentJobStatus.preActive;
      // active,
      case 4:
        return AssignmentJobStatus.active;
      // standby,
      case 8:
        return AssignmentJobStatus.standby;
      // inactive,
      case 10:
        return AssignmentJobStatus.inactive;
      // rejected,
      case 11:
        return AssignmentJobStatus.rejected;
      // cancelled,
      case 13:
        return AssignmentJobStatus.cancelled;
      // blacklist,
      case 12:
        return AssignmentJobStatus.pendingAttachment;

      default:
        return AssignmentJobStatus.cancelled;
    }
  }

  static String getTitle(int id) {
    switch (id) {
      case 1:
        return "Pending Request";
      // newJob,
      case 2:
        return "New";
      // pendingOnboarding,
      case 5:
        return "Pending Onboarding";
      // pendingRecruiter,
      case 7:
        return "Pending Recruiter";
      // pendingReactivation,
      case 9:
        return "Pending Reactivation";
      // pendingDeployment,
      case 6:
        return "Pending Deployment";
      // preActive,
      case 3:
        return "Pre Active";
      // active,
      case 4:
        return "Active";
      // standby,
      case 8:
        return "Standby";
      // inactive,
      case 10:
        return "Inactive";
      // rejected,
      case 11:
        return "Rejected";
      // cancelled,
      case 13:
        return "Cancelled";
      // blacklist,
      case 12:
        return "Pending Attachment";

      default:
        return "";
    }
  }

  static Color getColor(int id) {
    switch (id) {
      case 1:
        return Colors.orange;
      // newJob,
      case 2:
        return Colors.orange;
      // pendingOnboarding,
      case 5:
        return Colors.orange;
      // pendingRecruiter,
      case 7:
        return Colors.orange;
      // pendingReactivation,
      case 9:
        return Colors.orange;
      // pendingDeployment,
      case 6:
        return Colors.orange;
      // preActive,
      case 3:
        return Colors.green;
      // active,
      case 4:
        return Colors.green;
      // standby,
      case 8:
        return Colors.green;
      // inactive,
      case 10:
        return Colors.red;
      // rejected,
      case 11:
        return Colors.red;
      // cancelled,
      case 13:
        return Colors.red;
      // blacklist,
      case 12:
        return Colors.orange;

      default:
        return Colors.white;
    }
  }
}

extension PODStatusID on PODStatus {
  int get getID {
    switch (this) {
      case PODStatus.completed:
        return 6;
      case PODStatus.pendingValidation:
        return 9;
      case PODStatus.pendingDuplicateValidation:
        return 11;
      case PODStatus.rejected:
        return 12;
      case PODStatus.clockIn:
        return 13;
      case PODStatus.clockOut:
        return 14;
    }
  }

  static PODStatus fromID(int id) {
    switch (id) {
      case 6:
        return PODStatus.completed;
      case 9:
        return PODStatus.pendingValidation;
      case 11:
        return PODStatus.pendingDuplicateValidation;
      case 12:
        return PODStatus.rejected;
      case 13:
        return PODStatus.clockIn;
      case 14:
        return PODStatus.clockOut;

      default:
        return PODStatus.rejected;
    }
  }

  static String getTitle(int id) {
    switch (id) {
      case 6:
        return "Completed";
      case 9:
        return "Pending Validation";
      case 11:
        return "Pending Duplicate Validation";
      case 12:
        return "Rejected";
      case 13:
        return "Clock In";
      case 14:
        return "Clock Out";

      default:
        return "";
    }
  }

  static Color getColor(int id) {
    switch (id) {
      case 6:
        return Colors.green;
      case 9:
        return Colors.orange;
      case 11:
        return Colors.red;
      case 12:
        return Colors.red;
      case 13:
        return Colors.blue;
      case 14:
        return Colors.blue;

      default:
        return Colors.white;
    }
  }
}

class ConstantValue {
  static const String dbName = 'localDB';
  static const String sysDbName = 'SysLocalDB';

  static const String firebaseDemoField = 'messages';

  static String userUUID = '35e41ba9-fdfa-40cd-98b6-d829b1feabf9';
  static String googleMapKey = 'AIzaSyBikyhipvfxwjd3SnBqq0PKhHQsWbaqsk0';
  static String mainFont = 'Lato';
  static String currencyLabel = 'RM';
  static String pointsLabel = 'pts';

  static String encryptionKey = 'enterstripe.recycliot.user......';

  static String appName = 'recycliot';

  static String samplePdfLink =
      'http://www.axainsurance.com/home/policy-wording/policywording_153.pdf';

  static String metal = 'Metal';
  static String glass = 'Glass';
  static String paper = 'Paper';
  static String plastic = 'Plastic';
  static String eWaste = 'E-Waste';

  static String getRecycleType(RecycleType type) {
    switch (type) {
      case RecycleType.METAL:
        return ConstantValue.metal;
      case RecycleType.GLASS:
        return ConstantValue.glass;
      case RecycleType.PAPER:
        return ConstantValue.paper;
      case RecycleType.PLASTIC:
        return ConstantValue.plastic;
      case RecycleType.EWASTE:
        return ConstantValue.eWaste;

      default:
        return ConstantValue.metal;
    }
  }

  static String getRecycleTypeIcon(RecycleType type) {
    switch (type) {
      case RecycleType.METAL:
        return 'assets/images/metal-bin.png';
      case RecycleType.GLASS:
        return 'assets/images/glass-bin.png';
      case RecycleType.PAPER:
        return 'assets/images/paper-bin.png';
      case RecycleType.PLASTIC:
        return 'assets/images/plastic-bin.png';
      case RecycleType.EWASTE:
        return 'assets/images/ewaste-bin.png';

      default:
        return 'assets/images/ewaste-bin.png';
    }
  }

  static String armyPoliceNumber = 'Army Number/Police Number';
  static String icNumber = 'New IC number';
  static String passportNumber = 'Passport Number';
  static String registrationNumber = 'Registration Number';

  static String getIdType({required IdType type}) {
    switch (type) {
      case IdType.IC:
        return icNumber;
      case IdType.ARMY_POLICE:
        return armyPoliceNumber;
      case IdType.PASSPORT:
        return passportNumber;
      case IdType.REGISTRATION:
        return registrationNumber;

      default:
        return icNumber;
    }
  }

  static final listBank = [
    "Affin Bank Berhad",
    "Alliance Bank Malaysia Berhad",
    "AmBank (M) Berhad",
    "Bank Al-Rajhi",
    "Bank Islam Malaysia Berhad",
    "Bank Kerjasama Rakyat Malaysia Berhad",
    "Bank Muamalat (M) Berhad",
    "Bank Simpanan Nasional Berhad",
    "CIMB Bank Berhad",
    "Citibank Berhad",
    "Hong Leong Bank Berhad",
    "HSBC Bank Malaysia Berhad",
    "Malayan Banking Berhad",
    "OCBC Bank (Malaysia) Berhad",
    "Public Bank Berhad",
    "RHB Bank Berhad",
    "Standard Chartered Bank Malaysia Berhad",
  ];

  static final duitNowMethodList = [
    "Phone Number",
    "NRIC (MyKad)",
    "ID Number",
    "Business Registration Number"
  ];

  static double textBoldSizeGlobal = 14;
  static double textPrimarySizeGlobal = 14;
  static double textSecondarySizeGlobal = 14;
  static String? fontFamilyBoldGlobal;
  static String? fontFamilyPrimaryGlobal;
  static String? fontFamilySecondaryGlobal;
  static FontWeight fontWeightBoldGlobal = FontWeight.bold;
  static FontWeight fontWeightPrimaryGlobal = FontWeight.normal;
  static FontWeight fontWeightSecondaryGlobal = FontWeight.normal;
  static Color appBarBackgroundColorGlobal = Colors.white;
  static Color appButtonBackgroundColorGlobal = Colors.white;
  static Color defaultAppButtonTextColorGlobal =
      ColorConstant.textPrimaryColorGlobal;
  static double defaultAppButtonRadius = 8.0;
  static double defaultAppButtonElevation = 4.0;
  static bool enableAppButtonScaleAnimationGlobal = true;
  static int? appButtonScaleAnimationDurationGlobal;
  static ShapeBorder? defaultAppButtonShapeBorder;
  static Color defaultLoaderBgColorGlobal = Colors.white;
  static Color? defaultLoaderAccentColorGlobal;
  static Color? defaultInkWellSplashColor;
  static Color? defaultInkWellHoverColor;
  static Color? defaultInkWellHighlightColor;
  static double? defaultInkWellRadius;

  static Color shadowColorGlobal = Colors.grey.withOpacity(0.2);
  static int defaultElevation = 4;
  static double defaultRadius = 8.0;
  static double defaultBlurRadius = 4.0;
  static double defaultSpreadRadius = 1.0;
  static double defaultAppBarElevation = 4.0;
  static double tabletBreakpointGlobal = 600.0;
  static double desktopBreakpointGlobal = 720.0;
  static int passwordLengthGlobal = 8;

  static String errorMessage = 'Please try again';
  static String errorSomethingWentWrong = 'Something Went Wrong';
  static String errorThisFieldRequired = 'This field is required';
  static String errorInternetNotAvailable = 'Your internet is not working';

  var customDialogHeight = 140.0;
  var customDialogWidth = 220.0;

  static String currencyRupee = '₹';
  static String currencyDollar = '\$';
  static String currencyEuro = '€';
  static String playStoreBaseURL =
      'https://play.google.com/store/apps/details?id=';
  static String appStoreBaseURL = 'https://apps.apple.com/in/app/';
  static String facebookBaseURL = 'https://www.facebook.com/';
  static String instagramBaseURL = 'https://www.instagram.com/';
  static String linkedinBaseURL = 'https://www.linkedin.com/in/';
  static String twitterBaseURL = 'https://twitter.com/';
  static String youtubeBaseURL = 'https://www.youtube.com/';
  static String redditBaseURL = 'https://reddit.com/r/';
  static String telegramBaseURL = 'https://t.me/';
  static String facebookMessengerURL = 'https://m.me/';
  static String whatsappURL = 'https://wa.me/';
  static String SELECTED_LANGUAGE_CODE = 'selected_language_code';
  static String THEME_MODE_INDEX = 'theme_mode_index';
}

void showLoading() {
  Get.dialog(const LoadingDialog(), barrierDismissible: false);
}

void dismissDialog() {
  if (Get.isDialogOpen!) {
    Get.back();
  }
}

void dismissBottomSheet() {
  if (Get.isBottomSheetOpen!) {
    Get.back();
  }
}

void showRequiredDocImageDialog() {
  Get.dialog(
    const InfoDialog(
      title: "Upload Document / Image",
      info: "Please upload required document/image to proceed",
      confirmText: "OKAY",
      confirmButtonColor: Colors.red,
      icon: Center(
        child: Icon(
          FontAwesomeIcons.fileArrowUp,
          size: 50,
        ),
      ),
    ),
  );
}

Future<String> getDeviceInfo() async {
  final deviceInfoPlugin = DeviceInfoPlugin();
  await deviceInfoPlugin.deviceInfo;
  if (GetPlatform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
    return iosInfo.utsname.machine.toString();
  } else if (GetPlatform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
    return androidInfo.model.toString();
  }

  return "Unknown Model Phone";
}
