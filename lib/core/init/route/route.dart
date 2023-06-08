import '../../../view/home/screen/home_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic>? generateRoute(settings) {
  switch (settings.name) {
    //case RoutePaths.secondRoute:
    //return CustomFadeRoute(page: const SecondRoute(), settings: settings);
    default:
      return MaterialPageRoute(builder: (context) => const HomeScreen(), settings: settings);
  }
}
