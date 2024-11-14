import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:women_lose_weight_flutter/utils/preference.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/constant.dart';
import '../../../utils/utils.dart';

class ChooseWeightController extends GetxController {
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
    weightKG = Preference.shared.getInt(Preference.currentWeightInKg) ??
        Constant.weightKg;
    weightLBS = Preference.shared.getInt(Preference.currentWeightInLbs) ??
        Constant.weightLbs;

    String prefWeightUnit =
        Preference.shared.getString(Preference.currentWeightUnit) ??
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
    } else if (weightUnitValue ==  Constant.valueOne) {
      weightLBS = Utils.convertWeightKgToLbs(weightKG);
      fixedExtentScrollController!.animateToItem(weightLBS - 44,
          duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    }

    update([Constant.idChooseWeightPicker]);
  }

  onNextButtonClick() {
    Preference.shared.setInt(Preference.currentWeightInKg, weightKG);
    weightLBS = Utils.convertWeightKgToLbs(weightKG);
    Preference.shared.setInt(Preference.currentWeightInLbs, weightLBS);
    Preference.shared.setString(
        Preference.currentWeightUnit,
        ((weightUnitValue == Constant.valueZero)
            ? Constant.weightUnitKg
            : Constant.weightUnitLbs));

    Get.toNamed(AppRoutes.chooseTargetWeight);
  }
}
