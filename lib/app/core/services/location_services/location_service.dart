import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../data/constants/extensions/text_style_extensions.dart';
import '../../widgets/info_dialog.dart';

class LocationService {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  static const String _kLocationServicesDisabledMessage =
      'Location services are disabled.';
  static const String _kPermissionDeniedMessage = 'Permission denied.';
  static const String _kPermissionDeniedForeverMessage =
      'Permission denied forever.';
  static const String _kPermissionGrantedMessage = 'Permission granted.';


  static LocationService get instance => Get.find<LocationService>();

   Future<Position> getCurrentPosition() async {
    final hasPermission = await handlePermission();


    late final position;
    if (hasPermission) {
       position = await _geolocatorPlatform.getCurrentPosition();
    }

    return position;
  }

  Future<bool> handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.

    permission = await _geolocatorPlatform.checkPermission();
    print("permission " + permission.name);
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        // _updatePositionList(
        //   _PositionItemType.log,
        //   _kPermissionDeniedMessage,
        // );

        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      // _updatePositionList(
      //   _PositionItemType.log,
      //   _kPermissionDeniedForeverMessage,
      // );

      return false;
    }

    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    print("xxxx location service  enabled ? " + serviceEnabled.toString());
    if (!serviceEnabled) {
      Get.dialog(InfoDialog(
        title: 'Location is Off',
        info: 'Please make sure location is turn on to use this feature',
        confirmText: 'Go to Setting',
        confirmCallback: () async {
          await openLocationSettings();
        },
        icon: Center(
          child: LottieBuilder.asset('assets/lottie/location_off.json'),
        ),
      ));

      // getCurrentPosition();

      return false;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    // _updatePositionList(
    //   _PositionItemType.log,
    //   _kPermissionGrantedMessage,
    // );
    return true;
  }

  Future<Position?> getLastKnownPosition() async {
    final hasPermission = await handlePermission();
    late final position;
    if (hasPermission) {
      position = await _geolocatorPlatform.getLastKnownPosition();
    }

    return position;
  }

  void getLocationAccuracy() async {
    final status = await _geolocatorPlatform.getLocationAccuracy();
    handleLocationAccuracyStatus(status);
  }

  void requestTemporaryFullAccuracy() async {
    final status = await _geolocatorPlatform.requestTemporaryFullAccuracy(
      purposeKey: "TemporaryPreciseAccuracy",
    );
    handleLocationAccuracyStatus(status);
  }

  void handleLocationAccuracyStatus(LocationAccuracyStatus status) {
    String locationAccuracyStatusValue;
    if (status == LocationAccuracyStatus.precise) {
      locationAccuracyStatusValue = 'Precise';
    } else if (status == LocationAccuracyStatus.reduced) {
      locationAccuracyStatusValue = 'Reduced';
    } else {
      locationAccuracyStatusValue = 'Unknown';
    }
  }

  void openAppSettings() async {
    final opened = await _geolocatorPlatform.openAppSettings();
    String displayValue;

    if (opened) {
      displayValue = 'Opened Application Settings.';
    } else {
      displayValue = 'Error opening Application Settings.';
    }

    print(displayValue);
  }

  Future<void> openLocationSettings() async {
    final opened = await _geolocatorPlatform.openLocationSettings();
    String displayValue;

    if (opened) {
      displayValue = 'Opened Location Settings';
    } else {
      displayValue = 'Error opening Location Settings';
    }

    print(displayValue);
  }

}