import 'package:get/get.dart';
import 'package:women_lose_weight_flutter/utils/constant.dart';
import 'package:women_lose_weight_flutter/utils/preference.dart';

import '../../../utils/utils.dart';

class BMIController extends GetxController {
  int? lastWeight;
  int? lastFoot;
  int? lastInch;
  String? bmiValue;

  @override
  void onInit() {
    _getPreferenceData();
    super.onInit();
  }

  _getPreferenceData() {
    lastWeight = Preference.shared.getInt(Preference.currentWeightInKg) ??
        Constant.weightKg;
    lastFoot = Preference.shared.getInt(Preference.currentHeightInFt) ??
        Constant.heightFt;
    lastInch = Preference.shared.getInt(Preference.currentHeightInIn) ??
        Constant.heightIn;

    _calculateBMI();
  }

  _calculateBMI() {
    double getBmiCalculation = Utils.getBmiCalculation(lastWeight, lastFoot, lastInch);
    bmiValue = getBmiCalculation.toStringAsFixed(2);
    update([Constant.idCurrentBmiCount]);
  }
}
