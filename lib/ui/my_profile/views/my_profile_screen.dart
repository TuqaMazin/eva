import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:women_lose_weight_flutter/google_ads/custom_ad.dart';
import 'package:women_lose_weight_flutter/utils/constant.dart';

import '../../../common/dialog/height/height.dart';
import '../../../common/dialog/weight/weight.dart';
import '../../../utils/color.dart';
import '../../../utils/sizer_utils.dart';
import '../../../utils/utils.dart';
import '../controllers/my_profile_controller.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _widgetBack(),
            _chooseCategories(),
            _heightWeightTargetWeightWidget(),
            const BannerAdClass(),
          ],
        ),
      ),
    );
  }

  _widgetBack() {
    return Container(
      width: AppSizes.fullWidth,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(
          left: AppSizes.width_5,
          right: AppSizes.width_5,
          top: AppSizes.height_2),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Utils.backWidget(iconColor: AppColor.black),
          ),
          Expanded(
            child: Text(
              "\t\t\t\t${"txtMyProfile".tr}",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: AppColor.black,
                fontSize: AppFontSize.size_15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _chooseCategories() {
    return Container(
      margin: EdgeInsets.only(
          left: AppSizes.width_7,
          right: AppSizes.width_7,
          top: AppSizes.height_7),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColor.primary, width: 0.5),
      ),
      child: GetBuilder<MyProfileController>(
        id: Constant.idKgCmLbsFtSelection,
        builder: (logic) {
          return Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    logic.onSelectKgCm();
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: AppSizes.height_1_2),
                    decoration: BoxDecoration(
                      color: (logic.isKgCmLbsFt)
                          ? AppColor.primary
                          : AppColor.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(6),
                        bottomLeft: Radius.circular(6),
                      ),
                      border: Border.all(color: AppColor.primary, width: 0.5),
                    ),
                    child: Text(
                      "txtKgCm".tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: (logic.isKgCmLbsFt)
                            ? AppColor.white
                            : AppColor.primary,
                        fontSize: AppFontSize.size_11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    logic.onSelectLbsFt();
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: AppSizes.height_1_2),
                    decoration: BoxDecoration(
                      color: (!logic.isKgCmLbsFt)
                          ? AppColor.primary
                          : AppColor.white,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(6),
                        bottomRight: Radius.circular(6),
                      ),
                      border: Border.all(color: AppColor.primary),
                    ),
                    child: Text(
                      "txtLbdFt".tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: (!logic.isKgCmLbsFt)
                            ? AppColor.white
                            : AppColor.primary,
                        fontSize: AppFontSize.size_11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  _heightWeightTargetWeightWidget() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: AppSizes.height_5, horizontal: AppSizes.width_7),
        child: GetBuilder<MyProfileController>(
          id: Constant.idKgCmLbsFtSelection,
          builder: (logic) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "txtHeight".tr,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: AppColor.txtColor666,
                          fontSize: AppFontSize.size_14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _dialogHeight();
                      },
                      child: IntrinsicWidth(
                        child: Column(
                          children: [
                            Text(
                              (logic.isKgCmLbsFt)
                                  ? logic.heightInCM!
                                  : logic.heightInInFt!,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: AppColor.black,
                                fontSize: AppFontSize.size_14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Divider(
                              color: AppColor.grayDivider,
                              thickness: AppSizes.height_0_15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSizes.height_3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "txtWeight".tr,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: AppColor.txtColor666,
                          fontSize: AppFontSize.size_14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _dialogWeight(Constant.boolValueTrue);
                      },
                      child: IntrinsicWidth(
                        child: Column(
                          children: [
                            Text(
                              (logic.isKgCmLbsFt)
                                  ? logic.weightInKG!
                                  : logic.weightInLbs!,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: AppColor.black,
                                fontSize: AppFontSize.size_14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Divider(
                              color: AppColor.grayDivider,
                              thickness: AppSizes.height_0_15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSizes.height_3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "txtTargetWeight".tr,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: AppColor.txtColor666,
                          fontSize: AppFontSize.size_14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _dialogWeight(Constant.boolValueFalse);
                      },
                      child: IntrinsicWidth(
                        child: Column(
                          children: [
                            Text(
                              (logic.isKgCmLbsFt)
                                  ? logic.targetWeightInKG!
                                  : logic.targetWeightInLbs!,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: AppColor.black,
                                fontSize: AppFontSize.size_14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Divider(
                              color: AppColor.grayDivider,
                              thickness: AppSizes.height_0_15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  _dialogHeight() {
    return showDialog(
      context: Get.context!,
      barrierDismissible: Constant.boolValueTrue,
      builder: (context) {
        return Scaffold(
          backgroundColor: AppColor.transparent,
          body: DialogHeight(),
        );
      },
    );
  }

  _dialogWeight(bool value) {
    return showDialog(
      context: Get.context!,
      barrierDismissible: Constant.boolValueTrue,
      builder: (context) {
        return Scaffold(
          backgroundColor: AppColor.transparent,
          body: DialogWeight(value),
        );
      },
    );
  }
}
