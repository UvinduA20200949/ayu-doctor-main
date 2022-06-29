import 'dart:developer';

import 'package:permission_handler/permission_handler.dart';

class Permissions {
  static Future<bool> cameraAndMicrophonePermissionsGranted() async {
    PermissionStatus cameraPermissionStatus = await _getCameraPermission();
    PermissionStatus microphonePermissionStatus =
        await _getMicrophonePermission();

    if (cameraPermissionStatus == PermissionStatus.granted &&
        microphonePermissionStatus == PermissionStatus.granted) {
      log('Permissions : Granted');
      return true;
    } else {
      if (cameraPermissionStatus == PermissionStatus.denied ||
          microphonePermissionStatus == PermissionStatus.denied) {
        cameraPermissionStatus = await Permission.camera.request();
        microphonePermissionStatus = await Permission.microphone.request();

        if (cameraPermissionStatus == PermissionStatus.granted &&
            microphonePermissionStatus == PermissionStatus.granted) {
          log('Permissions : Granted');
          return true;
        } else if (cameraPermissionStatus == PermissionStatus.denied ||
            microphonePermissionStatus == PermissionStatus.denied) {
          log('Permissions : Denied');
          return false;
        } else if (cameraPermissionStatus ==
                PermissionStatus.permanentlyDenied ||
            microphonePermissionStatus == PermissionStatus.permanentlyDenied) {
          log('Permissions : Permanently Denied');
          await openAppSettings();
          return false;
        }
      }
    }

    return false;
  }

  static Future<PermissionStatus> _getCameraPermission() async {
    PermissionStatus permission = await Permission.camera.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      PermissionStatus permissionStatus = await Permission.camera.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  static Future<PermissionStatus> _getMicrophonePermission() async {
    PermissionStatus permission = await Permission.microphone.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      PermissionStatus permissionStatus = await Permission.microphone.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }
}
