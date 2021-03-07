import 'package:gametv/controller/login_screen_controller.dart';
import 'package:get/get.dart';

class LoginScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginScreenController());
  }
}
