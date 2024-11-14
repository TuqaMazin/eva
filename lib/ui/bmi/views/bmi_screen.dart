import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:women_lose_weight_flutter/routes/app_routes.dart';
import 'package:women_lose_weight_flutter/ui/bmi/controllers/bmi_controller.dart';
import 'package:women_lose_weight_flutter/utils/color.dart';
import 'package:women_lose_weight_flutter/utils/constant.dart';
import 'package:women_lose_weight_flutter/utils/sizer_utils.dart';

import '../../../utils/utils.dart';

class BMIScreen extends StatelessWidget {
  BMIScreen({super.key});

  final BMIController _bmiController = Get.find<BMIController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Column(
          children: [
            _textSkip(),
            _textChangeStartsToday(),
            _textTargetBMI(),
            _widgetBMIGraph(),
            _btnNext(),
          ],
        ),
      ),
    );
  }

  _textSkip() {
    return Container(
      width: AppSizes.fullWidth,
      margin: EdgeInsets.only(
          left: AppSizes.width_7_5,
          right: AppSizes.width_7_5,
          top: AppSizes.height_3_7),
      child: Row(
        children: [
          const Spacer(),
          InkWell(
            onTap: () {
              Utils.onIntroductionSkipButtonClick();
            },
            child: Text(
              "txtSkip".tr.toUpperCase(),
              textAlign: TextAlign.end,
              style: TextStyle(
                color: AppColor.txtColor999,
                fontSize: AppFontSize.size_12_5,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _textChangeStartsToday() {
    return Container(
      width: AppSizes.fullWidth,
      margin: EdgeInsets.only(top: AppSizes.height_2_5),
      padding: EdgeInsets.symmetric(horizontal: AppSizes.width_6),
      child: Text(
        "txtChangeStartToday".tr.toUpperCase(),
        textAlign: TextAlign.start,
        style: TextStyle(
          color: AppColor.primary,
          fontSize: AppFontSize.size_22,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  _textTargetBMI() {
    return Container(
      width: AppSizes.fullWidth,
      margin: EdgeInsets.only(top: AppSizes.height_1_2),
      padding: EdgeInsets.symmetric(horizontal: AppSizes.width_6),
      child: Text(
        "txtTargetBMI".tr,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: AppColor.txtColor666,
          fontSize: AppFontSize.size_12_5,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  _widgetBMIGraph() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Constant.getAssetImage() + "weight_chart.webp",
            height: AppSizes.height_20,
          ),
          Container(
            margin: EdgeInsets.only(
                top: AppSizes.height_8, bottom: AppSizes.height_2_5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GetBuilder<BMIController>(
                    id: Constant.idCurrentBmiCount,
                    builder: (logic) {
                      return Text(
                        logic.bmiValue!,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: AppColor.black,
                          fontSize: AppFontSize.size_26,
                          fontWeight: FontWeight.w700,
                        ),
                      );
                    }),
                Text(
                  "\t\t\t${"txtBMI".tr}",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: AppColor.black,
                    fontSize: AppFontSize.size_18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${"txtCurrentBMI".tr.toUpperCase()} - ",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: AppColor.black,
                  fontSize: AppFontSize.size_13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                Utils.bmiWeightString(double.parse(_bmiController.bmiValue!))
                    .toUpperCase(),
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: AppColor.black,
                  fontSize: AppFontSize.size_14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _btnNext() {
    return Container(
      margin: EdgeInsets.only(
          bottom: AppSizes.height_7,
          right: AppSizes.width_14,
          left: AppSizes.width_14),
      width: AppSizes.fullWidth,
      child: TextButton(
        onPressed: () {
          Get.back();
          Get.toNamed(AppRoutes.yourPlan);
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(AppColor.primary),
          elevation: WidgetStateProperty.all(2),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
              side: const BorderSide(color: AppColor.transparent, width: 0.7),
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: AppSizes.height_1_2),
          child: Text(
            "txtNext".tr.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColor.white,
                fontSize: AppFontSize.size_15,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
