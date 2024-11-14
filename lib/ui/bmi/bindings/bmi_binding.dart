import 'package:get/get.dart';

import '../controllers/bmi_controller.dart';

class BMIBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BMIController>(
          () => BMIController(),
    );
  }
}
