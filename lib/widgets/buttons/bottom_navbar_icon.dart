import 'package:flutter/material.dart';
import '../../core/init/constants/theme.dart';

class BottomNavbarIcon extends StatelessWidget {
  const BottomNavbarIcon({Key? key, required this.icon, this.onPressed}) : super(key: key);

  final IconData icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      color: UIColors.blueColor,
      onPressed: onPressed ?? () {},
    );
  }
}
