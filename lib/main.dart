import 'package:flutter/material.dart';
import 'package:gametv/bindings/home_screen_bindings.dart';
import 'package:gametv/bindings/login_screen_bindings.dart';
import 'package:gametv/bindings/controller_bindings.dart';
import 'package:gametv/locale/messages.dart';
import 'package:gametv/screen/home_screen.dart';
import 'package:gametv/screen/login_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(GameTv());
}

class GameTv extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Messages(),
      locale: Get.deviceLocale,
      fallbackLocale: Locale('en', 'US'),
      title: 'app_name'.tr,
      defaultTransition: Transition.native,
      transitionDuration: Duration(milliseconds: 800),
      themeMode: ThemeMode.system,
      home: InitialPage(),
      initialBinding: ControllerBinding(),
      getPages: [
        GetPage(
            name: "/login_screen",
            page: () => LoginScreen(),
            binding: LoginScreenBindings()),
        GetPage(
            name: "/home_screen",
            page: () => HomeScreen(),
            binding: HomeScreenBindings())
      ],
    );
  }
}

class InitialPage extends StatefulWidget {
  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final userData = GetStorage();

  @override
  void initState() {
    super.initState();
    userData.writeIfNull('isLogged', false);
    Future.delayed(Duration.zero, () async {
      checkIfLoggedIn();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }

  void checkIfLoggedIn() {
    bool isLoggedIn = userData.read('loggedIn') ?? false;
    isLoggedIn ? Get.offAll(HomeScreen()) : Get.offAll(LoginScreen());
  }
}
