import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gametv/screen/home_screen.dart';
import 'package:gametv/controller/login_screen_controller.dart';
import 'package:gametv/controller/home_screen_controller.dart';
import 'package:gametv/repository/tournament_repo_implementation.dart';
import 'package:gametv/widget/button.dart';
import 'package:get/get.dart';
import 'dart:ui';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final minLength = 3;

  final maxLength = 10;

  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  final loginScreenController = Get.put(LoginScreenController());

  ValueNotifier<bool> _usernamePasswordValidationNotifier =
      ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    //bool isLoggedIn = false;

    return Scaffold(
      backgroundColor: Colors.black12,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset('assets/images/game_home_back.jpg', fit: BoxFit.cover),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Image.asset('assets/images/game_tv_logo.png'),
                      SizedBox(
                        height: 40.0,
                      ),
                      TextFormField(
                        onChanged: (value) => checkValidation(),
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.numberWithOptions(
                            decimal: false, signed: false),
                        controller: usernameController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null) return "username_3_10".tr;
                          if (value != null && value.length < minLength)
                            return "username_too_short".tr;
                          else if (value != null && value.length > maxLength)
                            return "username_too_long".tr;
                          else
                            return null;
                        },
                        obscureText: false,
                        maxLength: maxLength,
                        maxLengthEnforced: true,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp("[0-9]*")),
                          LengthLimitingTextInputFormatter(10)
                        ],
                        decoration: InputDecoration(
                            fillColor: Colors.white24,
                            counterStyle: TextStyle(color: Colors.white),
                            labelText: "label_username".tr,
                            errorStyle: TextStyle(color: Colors.red),
                            labelStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            hintText: "hint_username".tr,
                            hintStyle: TextStyle(color: Colors.white),
                            filled: true),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      ValueBuilder<bool>(
                        initialValue: true,
                        builder: (isObscurePassword, updateFn) => TextFormField(
                          onChanged: (value) => checkValidation(),
                          style: TextStyle(color: Colors.white),
                          controller: passwordController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null) return "password_3_10".tr;
                            if (value != null && value.length < minLength)
                              return "password_too_short".tr;
                            else if (value != null && value.length > maxLength)
                              return "password_too_long".tr;
                            else
                              return null;
                          },
                          maxLength: maxLength,
                          maxLengthEnforced: true,
                          obscureText: isObscurePassword,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10)
                          ],
                          decoration: InputDecoration(
                            fillColor: Colors.white24,
                            counterStyle: TextStyle(color: Colors.white),
                            labelText: "label_password".tr,
                            errorStyle: TextStyle(color: Colors.red),
                            labelStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300),
                            suffixIcon: IconButton(
                                icon: isObscurePassword
                                    ? Icon(Icons.visibility_outlined)
                                    : Icon(Icons.visibility_off_outlined),
                                color: Colors.white,
                                onPressed: () => updateFn(!isObscurePassword)),
                            //labelText: "Password",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            hintText: "hint_password".tr,
                            hintStyle: TextStyle(color: Colors.white),
                            filled: true,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      ValueListenableBuilder(
                        valueListenable: _usernamePasswordValidationNotifier,
                        builder: (context, value, child) {
                          return IgnorePointer(
                            ignoring: !value,
                            child: CustomButton(
                                disabled: !value,
                                text: "submit_login".tr,
                                onTap: () => {
                                      loginScreenController.authenticateUser(
                                              username: usernameController.text,
                                              password: passwordController.text)
                                          ? Get.offAllNamed("/home_screen")
                                          : Get.snackbar(
                                              "login".tr,
                                              "plz_enter_crt".tr,
                                              backgroundColor: Colors.white,
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              snackStyle: SnackStyle.GROUNDED,
                                              duration: Duration(seconds: 1),
                                            )
                                    }),
                          );
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkValidation() {
    if (usernameController.text.length != null &&
        !(usernameController.text.length < minLength) &&
        !(usernameController.text.length > 11) &&
        passwordController.text.length != null &&
        !(passwordController.text.length < minLength) &&
        !(passwordController.text.length > 11)) {
      _usernamePasswordValidationNotifier.value = true;
    } else {
      _usernamePasswordValidationNotifier.value = false;
    }
  }
}
