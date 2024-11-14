import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:women_lose_weight_flutter/database/helper/db_helper.dart';
import 'package:women_lose_weight_flutter/database/table/weight_table.dart';
import 'package:women_lose_weight_flutter/utils/constant.dart';
import 'package:women_lose_weight_flutter/utils/preference.dart';

import '../../../utils/utils.dart';

class MyProfileController extends GetxController {
  bool isKgCmLbsFt = Constant.boolValueTrue;

  int heightUnitValue = Constant.valueZero;
  int weightUnitValue = Constant.valueZero;
  int targetWeightUnitValue = Constant.valueZero;

  List<String> heightUnitList = ["txtCM".tr, "txtFtIn".tr];
  List<String> weightUnitList = ["txtKG".tr, "txtLBS".tr];
  List<String> targetWeightUnitList = ["txtKG".tr, "txtLBS".tr];

  String? heightInCM;
  String? weightInKG;
  String? targetWeightInKG;

  String? heightInInFt;
  String? weightInLbs;
  String? targetWeightInLbs;

  int heightCM = Constant.heightCm;
  int heightFt = Constant.heightFt;
  int heightIn = Constant.heightIn;

  int weightKG = Constant.weightKg;
  int weightLBS = Constant.weightLbs;

  int targetWeightKG = Constant.weightKg;
  int targetWeightLBS = Constant.weightLbs;

  FixedExtentScrollController? fixedExtentScrollControllerCm;
  FixedExtentScrollController? fixedExtentScrollControllerFt;
  FixedExtentScrollController? fixedExtentScrollControllerIn;
  FixedExtentScrollController? fixedExtentScrollControllerWeight;
  FixedExtentScrollController? fixedExtentScrollControllerTargetWeight;

  List<WeightTable>? weightDataList;

  @override
  void onInit() {
    fixedExtentScrollControllerCm =
        FixedExtentScrollController(initialItem: 80);
    fixedExtentScrollControllerFt = FixedExtentScrollController(initialItem: 3);
    fixedExtentScrollControllerIn = FixedExtentScrollController(initialItem: 3);
    fixedExtentScrollControllerWeight =
        FixedExtentScrollController(initialItem: 40);
    fixedExtentScrollControllerTargetWeight =
        FixedExtentScrollController(initialItem: 40);
    _fillData();
    super.onInit();
  }

  _fillData() {
    isKgCmLbsFt = ((Preference.shared.getString(Preference.currentWeightUnit) ==
            Constant.weightUnitKg) &&
        (Preference.shared.getString(Preference.targetWeightUnit) ==
            Constant.weightUnitKg) &&
        (Preference.shared.getString(Preference.currentHeightUnit) ==
            Constant.heightUnitCm));

    if (isKgCmLbsFt) {
      heightInCM = "${Preference.shared.getInt(Preference.currentHeightInCm) ??
                  Constant.heightCm} CM";
      weightInKG = "${Preference.shared.getInt(Preference.currentWeightInKg) ??
                  Constant.weightKg} KG";
      targetWeightInKG =
          "${Preference.shared.getInt(Preference.targetWeightInKg) ??
                      Constant.weightKg} KG";
    } else {
      heightInInFt = ("${Preference.shared.getInt(Preference.currentHeightInFt) ??
                  Constant.heightFt}\" ${Preference.shared.getInt(Preference.currentHeightInIn) ??
                  Constant.heightIn}");
      weightInLbs = "${Preference.shared.getInt(Preference.currentWeightInLbs) ??
                  Constant.weightLbs} Lbs";
      targetWeightInLbs =
          "${Preference.shared.getInt(Preference.targetWeightInLbs) ??
                      Constant.weightLbs} Lbs";
    }

    update([Constant.idKgCmLbsFtSelection]);
  }

  onSelectKgCm() {
    isKgCmLbsFt = Constant.boolValueTrue;
    Preference.shared
        .setString(Preference.currentWeightUnit, Constant.weightUnitKg);
    Preference.shared
        .setString(Preference.targetWeightUnit, Constant.weightUnitKg);
    Preference.shared
        .setString(Preference.currentHeightUnit, Constant.heightUnitCm);
    _fillData();
    update([Constant.idKgCmLbsFtSelection]);
  }

  onSelectLbsFt() {
    isKgCmLbsFt = Constant.boolValueFalse;
    Preference.shared
        .setString(Preference.currentWeightUnit, Constant.weightUnitLbs);
    Preference.shared
        .setString(Preference.targetWeightUnit, Constant.weightUnitLbs);
    Preference.shared
        .setString(Preference.currentHeightUnit, Constant.heightUnitFtIn);
    _fillData();
    update([Constant.idKgCmLbsFtSelection]);
  }

  /// Height

  getHeightPreferenceData() {
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

    update([Constant.idChooseHeightPickerDialog]);
  }

  onHeightSaveButtonClick() {
    if (heightUnitValue == Constant.valueZero) {
      Preference.shared.setInt(Preference.currentHeightInCm, heightCM);

      var inch = Utils.cmToInch(heightCM.toDouble());
      heightFt = Utils.calcInchToFeet(inch);
      heightIn = Utils.calcInFromInch(inch);

      Preference.shared.setInt(Preference.currentHeightInFt, heightFt);
      Preference.shared.setInt(Preference.currentHeightInIn, heightIn);
    } else {
      var inch = Utils.ftInToInch(heightFt, heightIn);
      heightCM = Utils.inchToCm(inch);

      Preference.shared.setInt(Preference.currentHeightInCm, heightCM);

      Preference.shared.setInt(Preference.currentHeightInFt, heightFt);
      Preference.shared.setInt(Preference.currentHeightInIn, heightIn);
    }

    Preference.shared.setString(
        Preference.currentHeightUnit,
        ((heightUnitValue == Constant.valueZero)
            ? Constant.heightUnitCm
            : Constant.heightUnitFtIn));
    Get.back();
    _fillData();
  }

  /// Weight

  getWeightPreferenceData() {
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
        fixedExtentScrollControllerWeight!.animateToItem(weightKG - 20,
            duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
      });
    } else if (prefWeightUnit == Constant.weightUnitLbs) {
      weightUnitValue = Constant.valueOne;
      Future.delayed(const Duration(milliseconds: 50), () {
        fixedExtentScrollControllerWeight!.animateToItem(weightLBS - 44,
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
      fixedExtentScrollControllerWeight!.animateToItem(weightKG - 20,
          duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    } else if (weightUnitValue == Constant.valueOne) {
      weightLBS = Utils.convertWeightKgToLbs(weightKG);
      fixedExtentScrollControllerWeight!.animateToItem(weightLBS - 44,
          duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    }

    update([Constant.idChooseWeightPickerDialog]);
  }

  onWeightSaveButtonClick() async {
    if (weightUnitValue == Constant.valueZero) {
      Preference.shared.setInt(Preference.currentWeightInKg, weightKG);
      weightLBS = Utils.convertWeightKgToLbs(weightKG);
      Preference.shared.setInt(Preference.currentWeightInLbs, weightLBS);
    } else {
      weightKG = Utils.convertWeightLbsToKg(weightLBS);
      Preference.shared.setInt(Preference.currentWeightInKg, weightKG);
      Preference.shared.setInt(Preference.currentWeightInLbs, weightLBS);
    }

    Preference.shared.setString(
        Preference.currentWeightUnit,
        ((weightUnitValue == Constant.valueZero)
            ? Constant.weightUnitKg
            : Constant.weightUnitLbs));
    Get.back();
    _fillData();
    await _addWeightToDatabase();
  }

  _addWeightToDatabase() async {
    weightDataList = await DBHelper.dbHelper.getWeightData();
    if (weightDataList!.isNotEmpty) {
      var res = weightDataList!.where((element) =>
          element.weightId ==
          DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day, 0, 0, 0, 0, 0)
              .millisecondsSinceEpoch);
      if (res.isNotEmpty) {
        updateWeightDatabase();
      } else {
        insertWeightToDatabase();
      }
    } else {
      insertWeightToDatabase();
    }
  }

  void updateWeightDatabase() {
    DBHelper.dbHelper.updateWeight(
      weightKG: weightKG.toString(),
      weightLBS: weightLBS.toString(),
      id: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 0, 0, 0, 0, 0)
          .millisecondsSinceEpoch,
    );
  }

  void insertWeightToDatabase() {
    DBHelper.dbHelper.insertWeightData(WeightTable(
      weightId: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 0, 0, 0, 0, 0)
          .millisecondsSinceEpoch,
      weightKg: weightKG.toString(),
      weightLb: weightLBS.toString(),
      weightDate: Utils.getDate(DateTime.now()).toString(),
      currentTimeStamp: DateTime.now().toString(),
      status: Constant.statusSyncPending,
    ));
  }

  /// Target Weight

  getTargetWeightPreferenceData() {
    targetWeightKG = Preference.shared.getInt(Preference.targetWeightInKg) ??
        Constant.weightKg;
    targetWeightLBS = Preference.shared.getInt(Preference.targetWeightInLbs) ??
        Constant.weightLbs;

    String prefWeightUnit =
        Preference.shared.getString(Preference.targetWeightUnit) ??
            Constant.weightUnitKg;

    if (prefWeightUnit == Constant.weightUnitKg) {
      targetWeightUnitValue = Constant.valueZero;
      Future.delayed(const Duration(milliseconds: 50), () {
        fixedExtentScrollControllerTargetWeight!.animateToItem(
            targetWeightKG - 20,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeIn);
      });
    } else if (prefWeightUnit == Constant.weightUnitLbs) {
      targetWeightUnitValue = Constant.valueOne;
      Future.delayed(const Duration(milliseconds: 50), () {
        fixedExtentScrollControllerTargetWeight!.animateToItem(
            targetWeightLBS - 44,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeIn);
      });
    }
  }

  onChangeKgTargetValue(int value) {
    targetWeightKG = value;
  }

  onChangeLbsTargetValue(int value) {
    targetWeightLBS = value;
  }

  onChangeTargetWeightUnit(int changeUnit) {
    targetWeightUnitValue = changeUnit;

    if (targetWeightUnitValue == Constant.valueZero) {
      targetWeightKG = Utils.convertWeightLbsToKg(targetWeightLBS);
      fixedExtentScrollControllerTargetWeight!.animateToItem(
          targetWeightKG - 20,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeIn);
    } else if (targetWeightUnitValue == Constant.valueOne) {
      targetWeightLBS = Utils.convertWeightKgToLbs(targetWeightKG);
      fixedExtentScrollControllerTargetWeight!.animateToItem(
          targetWeightLBS - 44,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeIn);
    }

    update([Constant.idChooseWeightPickerDialog]);
  }

  onTargetWeightSaveButtonClick() {
    if (targetWeightUnitValue == Constant.valueZero) {
      Preference.shared.setInt(Preference.targetWeightInKg, targetWeightKG);
      targetWeightLBS = Utils.convertWeightKgToLbs(targetWeightKG);
      Preference.shared.setInt(Preference.targetWeightInLbs, targetWeightLBS);
    } else {
      targetWeightKG = Utils.convertWeightLbsToKg(targetWeightLBS);
      Preference.shared.setInt(Preference.targetWeightInKg, targetWeightKG);
      Preference.shared.setInt(Preference.targetWeightInLbs, targetWeightLBS);
    }

    Preference.shared.setString(
        Preference.targetWeightUnit,
        ((targetWeightUnitValue == Constant.valueZero)
            ? Constant.weightUnitKg
            : Constant.weightUnitLbs));
    Get.back();
    _fillData();
  }
}
