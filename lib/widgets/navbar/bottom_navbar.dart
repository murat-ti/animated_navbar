import 'package:flutter/material.dart';
import '../buttons/bottom_navbar_icon.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key, this.btnWidth = 0.0, required double bntWidth});
  final double btnWidth;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        child: BottomAppBar(
          color: Colors.transparent, //UIColors.whiteColor,
          elevation: 0,
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const BottomNavbarIcon(icon: Icons.home),
              const BottomNavbarIcon(icon: Icons.search),
              SizedBox(width: btnWidth),
              const BottomNavbarIcon(icon: Icons.flash_on),
              const BottomNavbarIcon(icon: Icons.account_box),
            ],
          ),
        ),
      ),
    );
  }
}
