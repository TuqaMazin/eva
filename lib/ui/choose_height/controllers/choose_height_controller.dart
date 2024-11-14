import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/constant.dart';
import '../../../utils/preference.dart';
import '../../../utils/utils.dart';

class ChooseHeightController extends GetxController {
  int heightUnitValue = Constant.valueZero;
  int heightCM = Constant.heightCm;
  int heightFt = Constant.heightFt;
  int heightIn = Constant.heightIn;

  List<String> heightUnitList = ["txtCM".tr, "txtFtIn".tr];

  FixedExtentScrollController? fixedExtentScrollControllerCm;
  FixedExtentScrollController? fixedExtentScrollControllerFt;
  FixedExtentScrollController? fixedExtentScrollControllerIn;

  @override
  void onInit() {
    fixedExtentScrollControllerCm = FixedExtentScrollController(initialItem: 0);
    fixedExtentScrollControllerFt = FixedExtentScrollController(initialItem: 0);
    fixedExtentScrollControllerIn = FixedExtentScrollController(initialItem: 0);
    _setPreferenceData();
    super.onInit();
  }

  _setPreferenceData() {
    heightCM = Preference.shared.getInt(Preference.currentHeightInCm) ??
        Constant.heightCm;
    heightFt = Preference.shared.getInt(Preference.currentHeightInFt) ??
        Constant.heightFt;
    heightIn = Preference.shared.getInt(Preference.currentHeightInIn) ??
        Constant.heightIn;

    String prefHeightUnit =
        Preference.shared.getString(Preference.currentHeightUnit) ??
            Constant.heightUnitCm;

    if (prefHeightUnit == Constant.heightUnitCm) {
      heightUnitValue = Constant.valueZero;
      Future.delayed(const Duration(milliseconds: 50), () async {
        await fixedExtentScrollControllerCm!.animateToItem(heightCM - 20,
            duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
      });
    } else if (prefHeightUnit == Constant.heightUnitFtIn) {
      heightUnitValue = Constant.valueOne;
      Future.delayed(const Duration(milliseconds: 50), () async {
        await fixedExtentScrollControllerFt!.animateToItem(heightFt,
            duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
        await fixedExtentScrollControllerIn!.animateToItem(heightIn,
            duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
      });
    }
  }

  onChangeCMValue(int value) {
    heightCM = value;
  }

  onChangeFtValue(int value) {
    heightFt = value;
  }

  onChangeInValue(int value) {
    heightIn = value;
  }

  onChangeHeightUnit(int changeUnit) {
    heightUnitValue = changeUnit;

    if (heightUnitValue == Constant.valueZero) {
      var inch = Utils.ftInToInch(heightFt, heightIn);
      heightCM = Utils.inchToCm(inch);

      Future.delayed(const Duration(milliseconds: 50), () async {
        await fixedExtentScrollControllerCm!.animateToItem(heightCM - 20,
            duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
      });
    } else if (heightUnitValue == Constant.valueOne) {
      var inch = Utils.cmToInch(heightCM.toDouble());
      heightFt = Utils.calcInchToFeet(inch);
      heightIn = Utils.calcInFromInch(inch);

      Future.delayed(const Duration(milliseconds: 50), () async {
        await fixedExtentScrollControllerFt!.animateToItem(heightFt,
            duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
        await fixedExtentScrollControllerIn!.animateToItem(heightIn,
            duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
      });
    }

    update([Constant.idChooseHeightPicker]);
  }

  onNextButtonClick() {
    Preference.shared.setInt(Preference.currentHeightInCm, heightCM);

    var inch = Utils.cmToInch(heightCM.toDouble());
    heightFt = Utils.calcInchToFeet(inch);
    heightIn = Utils.calcInFromInch(inch);

    Preference.shared.setInt(Preference.currentHeightInFt, heightFt);
    Preference.shared.setInt(Preference.currentHeightInIn, heightIn);
    Preference.shared.setString(
        Preference.currentHeightUnit,
        ((heightUnitValue == Constant.valueZero)
            ? Constant.heightUnitCm
            : Constant.heightUnitFtIn));

    Get.back();
    Get.toNamed(AppRoutes.bmi);
  }
}
