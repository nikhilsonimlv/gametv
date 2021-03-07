import 'package:gametv/model/data.dart';
import 'package:gametv/model/user_response/game_user.dart';

abstract class TournamentRepository {
  Future<Data> getTournamentsData(
      {String tournamentEndpoint, int limit, String cursor});

  Future<GameUser> getUserInfo(String userId);
}
