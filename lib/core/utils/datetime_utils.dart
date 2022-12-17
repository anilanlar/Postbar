import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:postbar/core/theme/index.dart';
import 'package:postbar/ui/widgets/base_widgets/index.dart';

class DateTimeUtils {
  static Future<DateTime?> showDatePickerFunc({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    Locale? locale,
  }) async {
    DateTime? selectedDateTime;
    try {
      if (Platform.isAndroid) {
        return await showDatePicker(
          context: context,
          locale: locale ?? Get.locale,
          initialDate: initialDate ?? DateTime.now(),
          firstDate: firstDate ?? DateTime(1900),
          lastDate: lastDate ?? DateTime(DateTime.now().year + 1),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: ThemeColors.primaryColor,
                  onPrimary: ThemeColors.thirdColor,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: ThemeColors.primaryColor,
                  ),
                ),
              ),
              child: child!,
            );
          },
        );
      } else {
        await showModalBottomSheet(
          backgroundColor: Colors.white.withOpacity(0.7),
          context: Get.context!,
          builder: (BuildContext builder) {
            return SafeArea(
              child: Container(
                height: Get.height / 2,
                color: Colors.white.withOpacity(0.7),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: Get.height / 2.5,
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (DateTime? picked) {
                          if (picked != null && picked != selectedDateTime) {
                            selectedDateTime = picked;
                          }
                        },
                        initialDateTime: initialDate ?? selectedDateTime,
                        minimumYear: firstDate?.year ?? 1900,
                        maximumYear: lastDate?.year ?? DateTime.now().year + 1,
                      ),
                    ),
                    BaseButton(
                      text: "app.edonusum.component.save.date".tr,
                      backgroundColor: ThemeColors.primaryColor,
                      onPressed: Get.back,
                    ),
                  ],
                ),
              ),
            );
          },
        );
        return selectedDateTime;
      }
    } catch (e) {
      debugPrint("showDatePickerError: $e");
      return null;
    }
  }

  static Future<TimeOfDay?> showTimePickerFunc() async {
    try {
      return await showTimePicker(
        context: Get.context!,
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.input,
        helpText: "app.edonusum.component.enter.hour".tr,
        cancelText: "app.edonusum.component.cancel".tr,
        confirmText: "app.edonusum.component.confirm".tr,
        hourLabelText: "app.edonusum.component.hour".tr,
        minuteLabelText: "app.edonusum.component.cancel.minute".tr,
        errorInvalidText: "app.edonusum.component.invalid.time".tr,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          );
        },
      );
    } catch (e) {
      debugPrint("showTimePickerError: $e");
      return null;
    }
  }
}
