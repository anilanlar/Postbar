import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionCheckHelper {
  static int getExtendedVersionNumber(String version) {
    List<dynamic> versionCells = version.split(".");
    versionCells = versionCells.map((dynamic i) => int.parse(i)).toList();
    final int versionNumber = versionCells[0] * 10000 + versionCells[1] * 100 + versionCells[2];
    debugPrint(versionNumber.toString());
    return versionNumber;
  }

  static Future<bool> checkVersionByString(String? version) async {
    if (version == null) {
      return false;
    }

    PackageInfo _packageInfo = PackageInfo(
      appName: "Unknown",
      packageName: "Unknown",
      version: "Unknown",
      buildNumber: "Unknown",
      buildSignature: "Unknown",
    );

    try {
      _packageInfo = await PackageInfo.fromPlatform();
    } catch (e) {
      debugPrint("PackageInfoError: ${e.toString()}");
    }

    return getExtendedVersionNumber(_packageInfo.version.toString()) >= getExtendedVersionNumber(version);
  }
}
