import 'dart:async';
import '../core/init/constants/theme.dart';
import 'package:flutter/material.dart';
import '../widgets/buttons/bottom_navbar_icon.dart';
import '../widgets/buttons/button_default.dart';
import '../widgets/draggable/custom_draggable.dart';

class ThirdRoute extends StatefulWidget {
  const ThirdRoute({super.key});

  @override
  State<ThirdRoute> createState() => _ThirdRouteState();
}

class _ThirdRouteState extends State<ThirdRoute> {
  double startX = 0; //217;
  double startY = 0; //715;
  double endX = 0; //217;
  double endY = 0; //550;

  static const text = 'Events';
  static const bntWidth = 56.0;
  static const bottomNavBarHeight = 48.0;
  double screenWidth = 0;
  double screenHeight = 0;
  double xPosition = 0;
  double yPosition = 0;
  bool play = false;

  @override
  void didChangeDependencies() {
    screenWidth = MediaQuery.of(context).size.width - bntWidth;
    screenHeight = MediaQuery.of(context).size.height;
    startX = screenWidth / 2;
    startY = screenHeight - 80;
    endX = startX;
    endY = startY - ((49 * 4) + (40 * 2));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.whiteColor,
      body: SafeArea(
        child: CustomDraggable(
          startX: startX,
          startY: startY,
          endX: endX,
          endY: endY,
        ),
      ),
    );
  }
}