import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:women_lose_weight_flutter/database/table/home_plan_table.dart';
import 'package:women_lose_weight_flutter/routes/app_routes.dart';
import 'package:women_lose_weight_flutter/ui/plan/controllers/plan_controller.dart';
import 'package:women_lose_weight_flutter/utils/sizer_utils.dart';

import '../../../utils/color.dart';
import '../../../utils/constant.dart';
import '../../../utils/utils.dart';
import '../../home/controllers/home_controller.dart';

class PlanScreen extends StatelessWidget {
  PlanScreen({super.key});

  final PlanController _planController = Get.find<PlanController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.height_3,
        horizontal: AppSizes.width_5,
      ),
      child: Column(
        children: [
          _widgetRecentExercise(),
          _widgetSelectedPlan(),
          _widget2To7MinFastWorkout(),
          _textBodyFocus(),
          _bodyFocusGrid(),
          _textDaily(),
          _widgetWaterTracker(),
        ],
      ),
    );
  }

  _widgetRecentExercise() {
    return GetBuilder<PlanController>(
        id: Constant.idPlanRecentHistory,
        builder: (logic) {
          if (logic.recentHistoryList.isNotEmpty) {
            return Container(
              margin: EdgeInsets.only(bottom: AppSizes.height_3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "txtRecent".tr,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: AppColor.black,
                            fontSize: AppFontSize.size_14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.recent,
                                  arguments: [logic.recentHistoryList])!
                              .then((value) => logic.refreshData());
                        },
                        child: Text(
                          "txtViewAll".tr,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: AppColor.primary,
                            fontSize: AppFontSize.size_10_5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSizes.height_1_5),
                  InkWell(
                    onTap: () {
                      logic.onRecentItemClick();
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          logic.recentHistoryList.isNotEmpty
                              ? Constant.getAssetImage() +
                                  logic.recentHistoryList[0].planDetail!
                                      .planThumbnail +
                                  ".webp"
                              : Constant.getAssetImage() +
                                  "history_butt_lift.webp",
                          height: AppSizes.height_6_5,
                          width: AppSizes.height_6_5,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppSizes.width_6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  logic.recentHistoryList.isNotEmpty
                                      ? Utils.getMultiLanguageString(logic.recentHistoryList[0].hPlanName!)
                                      : "",
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: AppColor.black,
                                    fontSize: AppFontSize.size_13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: AppSizes.height_0_8),
                                FutureBuilder(
                                  future: logic.getRecentItemTime(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                       snapshot.data.toString(),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: AppColor.txtColor666,
                                          fontSize: AppFontSize.size_8_5,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      );
                                    }
                                    return const SizedBox();
                                  }
                                ),
                              ],
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppColor.primary,
                          size: AppSizes.height_1_8,
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: AppColor.grayDivider,
                    height: AppSizes.height_0_05,
                    margin: EdgeInsets.only(
                        left: AppSizes.width_15, top: AppSizes.height_1_5),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        });
  }

  _widgetSelectedPlan() {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.daysPlanDetail)!
            .then((value) => _planController.refreshData());
      },
      child: SizedBox(
        height: AppSizes.height_42,
        width: AppSizes.fullWidth,
        child: Stack(
          fit: StackFit.expand,
          children: [
            GetBuilder<PlanController>(
              id: Constant.idYourPlanProgressDetails,
              builder: (logic) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColor.shadow,
                        offset: Offset(0.0, 2.5),
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      Utils.getSelectedPlanImage(
                          _planController.currentPlanIndex),
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
            ),
            Container(
              width: AppSizes.fullWidth,
              padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.width_6, vertical: AppSizes.height_2_5),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.whatsYourGoal)!
                          .then((value) => _planController.refreshData());
                    },
                    child: Image.asset(
                      Constant.getAssetIcons() + "ic_homepage_change.webp",
                      height: AppSizes.height_4,
                      width: AppSizes.height_4,
                    ),
                  ),
                  Expanded(child: Container()),
                  GetBuilder<PlanController>(
                    id: Constant.idYourPlanProgressDetails,
                    builder: (logic) {
                      return AutoSizeText(
                        Utils.getSelectedPlanName(
                            _planController.currentPlanIndex),
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        style: TextStyle(
                          color: AppColor.white,
                          fontSize: AppFontSize.size_15,
                          fontWeight: FontWeight.w700,
                        ),
                      );
                    },
                  ),
                  GetBuilder<PlanController>(
                    id: Constant.idYourPlanProgressDetails,
                    builder: (logic) {
                      return Container(
                        margin: EdgeInsets.only(
                            right: AppSizes.height_12,
                            top: AppSizes.height_1_2,
                            bottom: AppSizes.height_1_2),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: LinearProgressIndicator(
                            value: logic.pbDay,
                            minHeight: AppSizes.height_1,
                            backgroundColor: AppColor.white,
                            color: AppColor.primary,
                          ),
                        ),
                      );
                    },
                  ),
                  GetBuilder<PlanController>(
                    id: Constant.idYourPlanProgressDetails,
                    builder: (logic) {
                      return Text(
                        "${logic.txtDayLeft}\t${"txtDaysLeft".tr}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: AppColor.white,
                          fontSize: AppFontSize.size_12,
                          fontWeight: FontWeight.w400,
                        ),
                      );
                    },
                  ),
                  const Expanded(child: SizedBox()),
                  GetBuilder<PlanController>(
                    id: Constant.idYourPlanProgressDetails,
                    builder: (logic) {
                      return Container(
                        width: AppSizes.fullWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.0),
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              AppColor.greenGradualStartColor,
                              AppColor.greenGradualEndColor,
                            ],
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Get.toNamed(AppRoutes.daysPlanDetail)!
                                .then((value) => _planController.refreshData());
                          },
                          style: ButtonStyle(
                            shape: WidgetStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.0),
                                side: const BorderSide(
                                  color: AppColor.transparent,
                                  width: 0.7,
                                ),
                              ),
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: AppSizes.height_1),
                            child: Text(
                              logic.btnDays == "Finished" ? "txtFinished".tr : "txtDay".tr.toUpperCase() + logic.btnDays,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColor.white,
                                fontSize: AppFontSize.size_15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _widget2To7MinFastWorkout() {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.fastWorkOut)!
            .then((value) => _planController.refreshData());
      },
      child: Container(
        // height: AppSizes.height_16,
        width: AppSizes.fullWidth,
        margin: EdgeInsets.only(top: AppSizes.height_3),
        padding: EdgeInsets.symmetric(
            vertical: AppSizes.height_3, horizontal: AppSizes.width_5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image:
                AssetImage(Constant.getAssetImage() + "fast_workout_bg.webp"),
            fit: BoxFit.fill,
          ),
          boxShadow: kElevationToShadow[2],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AutoSizeText(
                  "txt2To7MinFastWorkout".tr,
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  style: TextStyle(
                    color: AppColor.black,
                    fontSize: AppFontSize.size_14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: AppSizes.width_1_5),
                Image.asset(
                  Constant.getAssetIcons() + "icon_fast.webp",
                  height: AppSizes.height_2,
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: AppSizes.height_1),
              child: Text(
                "txtNotEnoughTime".tr,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: AppColor.txtColor666,
                  fontSize: AppFontSize.size_12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: AppSizes.height_0_5),
              child: AutoSizeText(
                "txt2To7MinutesWorkoutToDoAnythingAnywhere".tr,
                textAlign: TextAlign.left,
                maxLines: 1,
                style: TextStyle(
                  color: AppColor.txtColor666,
                  fontSize: AppFontSize.size_12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _textBodyFocus() {
    return Container(
      margin: EdgeInsets.only(top: AppSizes.height_3),
      width: AppSizes.fullWidth,
      child: AutoSizeText(
        "txtBodyFocus".tr,
        textAlign: TextAlign.left,
        maxLines: 1,
        style: TextStyle(
          color: AppColor.black,
          fontSize: AppFontSize.size_14,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  _bodyFocusGrid() {
    return GetBuilder<PlanController>(
        id: Constant.idBodyFocusList,
        builder: (logic) {
          return Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: AppSizes.height_1_5),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: AppSizes.height_40,
                  childAspectRatio: 3 / 2.55,
                  crossAxisSpacing: AppSizes.width_2,
                  mainAxisSpacing: AppSizes.height_1),
              itemCount: logic.bodyFocusList.length,
              shrinkWrap: Constant.boolValueTrue,
              padding: EdgeInsets.only(bottom: AppSizes.width_4),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return _itemBodyFocusGrid(logic.bodyFocusList[index]);
              },
            ),
          );
        });
  }

  _itemBodyFocusGrid(HomePlanTable bodyFocusList) {
    return InkWell(
      onTap: () {
        _planController.onBodyFocusItemClick(bodyFocusList);
      },
      child: Card(
        margin: const EdgeInsets.all(0.0),
        elevation: 2.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  Constant.getAssetImage() + bodyFocusList.planImage + ".webp"),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(10.0),
            shape: BoxShape.rectangle,
          ),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
                vertical: AppSizes.height_3, horizontal: AppSizes.width_5),
            alignment: Alignment.topLeft,
            child: Text(
              Utils.getMultiLanguageString(bodyFocusList.planName!),
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: AppFontSize.size_14,
                color: AppColor.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _textDaily() {
    return Container(
      margin:
          EdgeInsets.only(top: AppSizes.height_3, bottom: AppSizes.height_1_5),
      width: AppSizes.fullWidth,
      child: AutoSizeText(
        "txtDaily".tr,
        textAlign: TextAlign.left,
        maxLines: 1,
        style: TextStyle(
          color: AppColor.black,
          fontSize: AppFontSize.size_14,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  _widgetWaterTracker() {
    return GetBuilder<HomeController>(
        id: Constant.idCurrentWaterGlass,
        builder: (logic) {
          return Card(
            margin: const EdgeInsets.all(0.0),
            elevation: 2.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              width: AppSizes.fullWidth,
              decoration: BoxDecoration(
                color: AppColor.cardBackgroundColor,
                borderRadius: BorderRadius.circular(12.0),
                shape: BoxShape.rectangle,
              ),
              padding: EdgeInsets.symmetric(
                  vertical: AppSizes.height_3, horizontal: AppSizes.width_5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "txtWaterTracker".tr,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: AppFontSize.size_14,
                            color: AppColor.black,
                          ),
                        ),
                        if (Utils.isWaterTrackerOn()) ...{
                          Container(
                            margin: EdgeInsets.only(
                                top: AppSizes.height_1_3,
                                bottom: AppSizes.height_2_5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  logic.currentGlass.toString(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: AppFontSize.size_21,
                                    color: AppColor.commonBlueColor,
                                  ),
                                ),
                                Text(
                                  "\t${"txt8Cups".tr}",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: AppFontSize.size_14,
                                    color: AppColor.txtColor666,
                                  ),
                                ),
                              ],
                            ),
                          )
                        },
                        if (!Utils.isWaterTrackerOn()) ...{
                          Container(
                            margin: EdgeInsets.only(
                                top: AppSizes.height_1_3,
                                bottom: AppSizes.height_2_5),
                            child: Text(
                              "txtWaterOffMessage".tr,
                              textAlign: TextAlign.left,
                              maxLines: 2,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: AppFontSize.size_12_5,
                                color: AppColor.txtColor666,
                              ),
                            ),
                          )
                        },
                        SizedBox(
                          width: AppSizes.fullWidth,
                          child: TextButton(
                            onPressed: () {
                              if (Utils.isWaterTrackerOn()) {
                                Get.toNamed(AppRoutes.waterTracker,
                                    arguments: [logic.currentGlass]);
                                logic.currentWaterGlass();
                              } else {
                                Get.toNamed(AppRoutes.turnOnWater,
                                    arguments: [logic.currentGlass]);
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                  AppColor.commonBlueColor),
                              elevation: WidgetStateProperty.all(2),
                              shape: WidgetStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                  side: const BorderSide(
                                      color: AppColor.transparent, width: 0.7),
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: AppSizes.height_0_6),
                              child: Text(
                                "txtDrink".tr.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColor.white,
                                  fontSize: AppFontSize.size_14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: AppSizes.height_13,
                    width: AppSizes.height_13,
                    margin: EdgeInsets.only(left: AppSizes.width_7),
                    child: Stack(
                      alignment: Alignment.center,
                      fit: StackFit.expand,
                      children: [
                        CircularProgressIndicator(
                          backgroundColor: AppColor.commonBlueLightColor,
                          value: logic.currentGlass! / 8,
                          valueColor: const AlwaysStoppedAnimation(
                              AppColor.commonBlueColor),
                          strokeWidth: AppSizes.width_1_7,
                        ),
                        Padding(
                          padding: EdgeInsets.all(AppSizes.width_7_2),
                          child: Image.asset(
                            Constant.getAssetIcons() + "ic_homepage_drink.webp",
                            alignment: Alignment.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
