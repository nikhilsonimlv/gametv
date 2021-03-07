import 'package:dio/dio.dart';

abstract class HttpService {
  void init();
  Future<Response> getData({String url, int limit, String cursor});
  Future<Response> getUser(String userId);
}
