import 'package:flutter/material.dart';

class ButtonDefault extends StatelessWidget {
  const ButtonDefault({
    super.key,
    this.onPressed,
    this.child,
    this.backgroundColor,
  });

  final void Function()? onPressed;
  final Color? backgroundColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed ?? (){},
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        elevation: 0,
        padding: const EdgeInsets.all(10),
        backgroundColor: backgroundColor,
        foregroundColor: backgroundColor,
      ),
      child: child,
    );
  }
}
