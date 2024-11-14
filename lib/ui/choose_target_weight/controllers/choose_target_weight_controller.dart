import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/constant.dart';
import '../../../utils/preference.dart';
import '../../../utils/utils.dart';

class ChooseTargetWeightController extends GetxController {
  int weightUnitValue = Constant.valueZero;
  int weightKG = Constant.weightKg;
  int weightLBS = Constant.weightLbs;

  List<String> weightUnitList = ["txtKG".tr, "txtLBS".tr];

  FixedExtentScrollController? fixedExtentScrollController;

  @override
  void onInit() {
    fixedExtentScrollController = FixedExtentScrollController(initialItem: 0);
    _setPreferenceData();
    super.onInit();
  }

  _setPreferenceData() {
    weightKG = Preference.shared.getInt(Preference.targetWeightInKg) ??
        Constant.weightKg;
    weightLBS = Preference.shared.getInt(Preference.targetWeightInLbs) ??
        Constant.weightLbs;

    String prefWeightUnit =
        Preference.shared.getString(Preference.targetWeightUnit) ??
            Constant.weightUnitKg;

    if (prefWeightUnit == Constant.weightUnitKg) {
      weightUnitValue = Constant.valueZero;
      Future.delayed(const Duration(milliseconds: 50), () {
        fixedExtentScrollController!.animateToItem(weightKG - 20,
            duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
      });
    } else if (prefWeightUnit == Constant.weightUnitLbs) {
      weightUnitValue = Constant.valueOne;
      Future.delayed(const Duration(milliseconds: 50), () {
        fixedExtentScrollController!.animateToItem(weightLBS - 44,
            duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
      });
    }
  }

  onChangeKgValue(int value) {
    weightKG = value;
  }

  onChangeLbsValue(int value) {
    weightLBS = value;
  }

  onChangeWeightUnit(int changeUnit) {
    weightUnitValue = changeUnit;

    if (weightUnitValue == Constant.valueZero) {
      weightKG = Utils.convertWeightLbsToKg(weightLBS);
      fixedExtentScrollController!.animateToItem(weightKG - 20,
          duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    } else if (weightUnitValue == Constant.valueOne) {
      weightLBS = Utils.convertWeightKgToLbs(weightKG);
      fixedExtentScrollController!.animateToItem(weightLBS - 44,
          duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    }

    update([Constant.idChooseTargetWeightPicker]);
  }

  onNextButtonClick() {
    Preference.shared.setInt(Preference.targetWeightInKg, weightKG);
    weightLBS = Utils.convertWeightKgToLbs(weightKG);
    Preference.shared.setInt(Preference.targetWeightInLbs, weightLBS);
    Preference.shared.setString(
        Preference.targetWeightUnit,
        ((weightUnitValue == Constant.valueZero)
            ? Constant.weightUnitKg
            : Constant.weightUnitLbs));

    Get.toNamed(AppRoutes.chooseHeight);
  }
}
