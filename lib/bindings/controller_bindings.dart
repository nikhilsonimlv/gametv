import 'package:gametv/controller/home_screen_controller.dart';
import 'package:gametv/controller/login_screen_controller.dart';
import 'package:gametv/repository/tournament_repo_implementation.dart';
import 'package:get/get.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeScreenController());
    Get.lazyPut(() => LoginScreenController());
    Get.lazyPut(() => TournamentRepositoryImplementation());
  }
}
