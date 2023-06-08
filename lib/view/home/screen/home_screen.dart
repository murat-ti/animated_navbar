import 'package:animated_navbar/view/home/model/coordinates.dart';

import '../../../core/init/constants/sizes.dart';
import '../../../core/init/constants/theme.dart';
import 'package:flutter/material.dart';
import '../../../core/init/constants/titles.dart';
import '../../../widgets/animation/custom_animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Coordinates coordinates;

  static const menuTitles = [
    MenuTitles.btnReminder,
    MenuTitles.btnCamera,
    MenuTitles.btnAttachment,
    MenuTitles.btnTextNote,
  ];

  @override
  void didChangeDependencies() {
    final screenWidth = MediaQuery.of(context).size.width - Sizes.btnWidth;
    coordinates = Coordinates(
      startX: screenWidth / 2,
      startY: 0,
      endX: screenWidth / 2,
      endY: (49 * menuTitles.length) + (40 * 2),
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.whiteColor,
      body: SafeArea(
        child: CustomAnimation(
          coordinates: coordinates,
          menuTitles: menuTitles,
        ),
      ),
    );
  }
}
