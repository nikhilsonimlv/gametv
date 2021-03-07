import 'package:gametv/model/tournaments.dart';
import 'package:gametv/model/tournament_response .dart';
import 'package:gametv/model/user_response/game_user.dart';
import 'package:gametv/model/data.dart';
import 'package:gametv/repository/tournament_repo.dart';
import 'package:gametv/service/http_service.dart';
import 'package:gametv/service/http_service_implementation.dart';
import 'package:get/get.dart';

class TournamentRepositoryImplementation implements TournamentRepository {
  HttpService _httpService;

  TournamentRepositoryImplementation() {
    _httpService = Get.put(HttpServiceImplementation());
    _httpService.init();
  }

  @override
  Future<Data> getTournamentsData(
      {String tournamentEndpoint, int limit, String cursor}) async {
    try {
      final response = await _httpService.getData(
          url: "tournaments_list_v2", limit: limit, cursor: cursor);
      final tournamentsData = TournamentResponse.fromJson(response.data).data;
      return tournamentsData;
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Future<GameUser> getUserInfo(String userId) async {
    try {
      final response = await _httpService.getUser(userId);
      final userResponse = GameUser.fromJson(response.data);
      return userResponse;
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }
}
