import 'package:get/get.dart';

import '../controllers/charity_controller.dart';

class CharityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CharityController>(
      () => CharityController(),
    );
  }
}
