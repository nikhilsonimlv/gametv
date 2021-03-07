import 'package:gametv/model/user_response/game_user.dart';
import 'package:gametv/model/data.dart' as tData;
import 'package:gametv/repository/tournament_repo.dart';
import 'package:gametv/repository/tournament_repo_implementation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gametv/model/tournaments.dart';
import 'package:meta/meta.dart';

class HomeScreenController extends GetxController {
  final _userData = GetStorage();
  TournamentRepository _tournamentRepository;

  HomeScreenController() {
    _tournamentRepository = Get.put(TournamentRepositoryImplementation());
    initialLaunch();
  }

  RxBool isLoad = false.obs;
  RxBool isTournamentLoad = false.obs;
  List<Tournaments> tournaments = [];

  //RxList<Results> results;
  Rx<GameUser> gameUser;

  initialLaunch() async {
    showLoading();
    fetchTournaments();
    final result =
        await _tournamentRepository.getUserInfo(_userData.read('username'));

    hideLoading();

    if (result != null) {
      gameUser = result.obs;
    } else {
      print("No data recieved");
    }

    return gameUser;
  }

  Future<List<Tournaments>> fetchTournaments({String cursor = ""}) async {
    try {
      if (tournaments.length == 0) {
        showTournamentLoading();
        _userData.write("lastCursor", "");
        tournaments.clear();
      }
      final tournamentResult = await _tournamentRepository.getTournamentsData(
          limit: 10, cursor: cursor);
      _userData.write("lastCursor", tournamentResult.cursor);
      hideTournamentLoading();
      if (tournamentResult != null) {
        tournaments.addAll(tournamentResult.tournaments);
        update();
        return tournamentResult.tournaments;
      } else {
        print("No data recieved");
      }
    } catch (e) {} finally {
      hideTournamentLoading();
    }
  }

  String getLastCursor() {
    return _userData.read('lastCursor');
  }

  void logoutUser() {
    _userData.remove('username');
    _userData.remove("loggedIn");
    _userData.remove('lastCursor');
  }

  showLoading() {
    isLoad.toggle();
  }

  hideLoading() {
    isLoad.toggle();
  }

  showTournamentLoading() {
    isTournamentLoad.toggle();
  }

  hideTournamentLoading() {
    isTournamentLoad.toggle();
  }
}
