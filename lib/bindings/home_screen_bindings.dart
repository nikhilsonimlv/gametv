import 'package:gametv/controller/home_screen_controller.dart';
import 'package:gametv/repository/tournament_repo_implementation.dart';
import 'package:get/get.dart';

class HomeScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeScreenController());
    Get.put(TournamentRepositoryImplementation());
  }
}
