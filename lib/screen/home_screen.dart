import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gametv/controller/home_screen_controller.dart';
import 'package:gametv/model/tournaments.dart';
import 'package:gametv/util/app_util.dart';
import 'package:gametv/widget/custom_app_bar.dart';
import 'package:gametv/widget/custom_circe_avatar.dart';
import 'package:gametv/widget/tournament_tile.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreenController homeScreenController = Get.put(HomeScreenController());
  ScrollController _scrollController = ScrollController();

  Widget TournamentsView() {
    _scrollController.addListener(() async {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      String lastSavedCursor = homeScreenController.getLastCursor();
      if (currentScroll == maxScroll) {
        homeScreenController.fetchTournaments(cursor: lastSavedCursor);
      }
    });
    return FutureBuilder<List<Tournaments>>(
        future: homeScreenController.fetchTournaments(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GetBuilder<HomeScreenController>(
              builder: (_) {
                return Visibility(
                  visible: _ != null,
                  child: ListView.separated(
                    controller: _scrollController,
                    itemCount: _.tournaments.length,
                    shrinkWrap: false,
                    itemBuilder: (context, index) {
                      return TournamentTile(
                        imageUrl: _.tournaments[index].coverUrl,
                        name: _.tournaments[index].name,
                        gameName: _.tournaments[index].gameName,
                      );
                    },
                    separatorBuilder: (context, position) {
                      return SizedBox(
                        height: 10.0,
                      );
                    },
                  ),
                );
              },
            );
          } else
            return Center(
              child: Container(
                height: 60,
                width: 60,
                child: CircularProgressIndicator(),
              ),
            );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "flying_wolf".tr,
        leftWidget: GestureDetector(
          onTap: () => Get.dialog(
            AlertDialog(
              titlePadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              title: Text(
                "choose_your_theme".tr,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              content: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "enable_dark_mode".tr + " \u263E",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Checkbox(
                          value: Get.isDarkMode,
                          onChanged: (v) {
                            Get.changeTheme(Get.isDarkMode
                                ? ThemeData.light()
                                : ThemeData.dark());
                            Get.back();
                          },
                        ),
                      ],
                    ),
                    FlatButton(
                      child: Text("logout".tr),
                      onPressed: () {
                        return {
                          homeScreenController.logoutUser(),
                          Get.offAllNamed("/login_screen")
                        };
                      },
                    )
                  ],
                ),
              ),
              buttonPadding: EdgeInsets.zero,
            ),
          ),
          child: Text(
            "\u2630",
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Obx(
              () {
                return homeScreenController.isLoad.isTrue
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Visibility(
                        visible: homeScreenController.gameUser != null,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomCircleAvatar(
                                  radius: 60,
                                  imageUrl: homeScreenController
                                      .gameUser.value.avatar,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      homeScreenController.gameUser.value.name,
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(30, 0, 30, 0),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.blue.shade700,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Row(
                                        children: [
                                          Text(
                                            homeScreenController
                                                .gameUser.value.rating,
                                            style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          Text(
                                            '   ' + 'elo_rating'.tr,
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 150.0,
                                      padding: EdgeInsets.all(20),
                                      margin: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(40),
                                            bottomLeft: Radius.circular(40)),
                                        gradient: new LinearGradient(
                                            colors: [
                                              AppUtil.getColorFromHex(
                                                  "FFFF8E03"),
                                              Colors.yellowAccent
                                            ],
                                            end: const Alignment(0.0, -1),
                                            begin: const Alignment(0.0, 0.6),
                                            tileMode: TileMode.clamp),
                                      ),
                                      child: FittedBox(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              "${homeScreenController.gameUser.value.noOfTournament}",
                                              style: TextStyle(
                                                  fontSize: 35,
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              "tournaments".tr,
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              "played".tr,
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 150.0,
                                      margin: EdgeInsets.all(2),
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        gradient: new LinearGradient(
                                            colors: [
                                              Colors.deepPurple,
                                              Colors.deepPurpleAccent
                                            ],
                                            end: const Alignment(0.0, -1),
                                            begin: const Alignment(0.0, 0.6),
                                            tileMode: TileMode.clamp),
                                      ),
                                      child: FittedBox(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              "${homeScreenController.gameUser.value.noOfTournamentWon}",
                                              style: TextStyle(
                                                  fontSize: 35,
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              "tournaments".tr,
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              "won".tr,
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 150.0,
                                      margin: EdgeInsets.all(2),
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(40),
                                            bottomRight: Radius.circular(40)),
                                        gradient: new LinearGradient(
                                            colors: [
                                              Colors.deepOrange,
                                              Colors.deepOrangeAccent
                                            ],
                                            end: const Alignment(0.0, -1),
                                            begin: const Alignment(0.0, 0.6),
                                            tileMode: TileMode.clamp),
                                      ),
                                      child: FittedBox(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              "${homeScreenController.gameUser.value.winPercentage}%",
                                              style: TextStyle(
                                                  fontSize: 35,
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              "winning".tr,
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              "percentage".tr,
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Row(
                                children: [
                                  Text(
                                    "recommended_for_you".tr,
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
              },
            ),
            Expanded(child: TournamentsView()),
          ],
        ),
      ),
    );
  }
}
