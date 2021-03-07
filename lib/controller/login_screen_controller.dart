import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';

class LoginScreenController extends GetxController {
  final _box = GetStorage();

  bool get isLoggedIn => _box.read('loggedIn') ?? false;

  LoginScreenController() {}

  bool authenticateUser({String username, String password}) {
    if ((username == "123" || username == "456") && password == "123") {
      changeLoginState(true);
      saveUserId(username);
      return true;
    }
    return false;
  }

  void changeLoginState(bool val) => _box.write('loggedIn', val);
  void saveUserId(String val) => _box.write('username', val);
  bool getLoginState() {
    return isLoggedIn;
  }
}
