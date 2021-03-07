import 'package:dio/src/response.dart';
import 'package:gametv/service/http_service.dart';
import 'package:dio/dio.dart';

class HttpServiceImplementation implements HttpService {
  Dio _dio;
  final baseUrl =
      "http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/";

  @override
  Future<Response> getData({String url, int limit, String cursor}) async {
    Response response;
    try {
      response = await _dio.get(url,
          queryParameters: {'limit': limit, 'cursor': cursor, 'status': "all"});
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
    return response;
  }

  @override
  Future<Response> getUser(String userId) async {
    Response response;
    var dio = Dio();
    try {
      response = await dio.get(
          "${"https://60435418a20ace001728dfdb.mockapi.io/GameUsers/" + userId}");
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
    return response;
  }

  @override
  void init() {
    _dio = Dio(BaseOptions(baseUrl: baseUrl));
    interceptors();
  }

  interceptors() {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (request) {
      print(request.data);
    }, onResponse: (response) {
      print(response.data);
    }, onError: (error) {
      print(error.message);
    }));
  }
}
