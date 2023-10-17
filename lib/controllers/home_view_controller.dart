import 'dart:math';
import 'package:flutter/material.dart';
import 'package:topjoy/constants.dart' as constants;
import 'package:get/get.dart';

class HomeViewController extends GetxController {
  HomeViewController(this.context);

  BuildContext context;
  bool isInitialized = false;
  int bottlecapState = 0;
  int random = 0;

  String giveMyMessage() {
    return (bottlecapState == 10)
        ? constants.messages[random].toUpperCase()
        : "";
  }

  void flipTheBottlecap() async {
    // ha nulla az érték akkor a kupukakot fel szeretnénk fordítani
    // ha 10 az érték akkor vissza szeretnénk forgatni
    bool condition = (bottlecapState == 0);

    for (int i = (condition) ? 0 : 10;
        (condition) ? i < 11 : i >= 0;
        (condition) ? i++ : i--) {
      bottlecapState = i;
      if (condition) random = Random().nextInt(constants.messages.length);
      await Future.delayed(Duration(milliseconds: 15));
      update();
    }
  }

  Future<void> preloadAllImages() async {
    for (int i = 0; i < 11; i++) {
      await precacheImage(AssetImage('images/bottlecap_$i.png'), context);
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await preloadAllImages();
    // betöltöttük az összes fontos képet
    isInitialized = true;
    update();
  }
}
