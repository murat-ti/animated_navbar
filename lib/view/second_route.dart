import 'package:flutter/material.dart';
import '../core/init/constants/theme.dart';
import '../core/init/constants/sizes.dart';
import '../widgets/buttons/bottom_menu_text.dart';

class SecondRoute extends StatefulWidget {
  const SecondRoute({super.key});

  @override
  State<SecondRoute> createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _rotateAnimation;
  late final Animation<Color?> _iconColorAnimation;
  late final Animation<Color?> _btnColorAnimation;
  late final Animation<double> _fadeAnimation;
  static const heroTag = 'menuButton';
  static const btnReminder = 'Reminder';
  static const btnCamera = 'Camera';
  static const btnAttachment = 'Attachment';
  static const btnTextNote = 'Text Note';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _rotateAnimation =
        Tween(begin: 0.0, end: 0.75).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.5)));
    _iconColorAnimation = ColorTween(begin: UIColors.whiteColor, end: UIColors.blueColor)
        .animate(CurvedAnimation(parent: _controller, curve: const Interval(0.5, 1.0)));
    _btnColorAnimation = ColorTween(begin: UIColors.blueColor, end: UIColors.whiteColor)
        .animate(CurvedAnimation(parent: _controller, curve: const Interval(0.5, 1.0)));
    _fadeAnimation =
        Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.4, 0.9)));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //play only one time
    _controller.forward();

    return Scaffold(
      backgroundColor: UIColors.blueColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: UIColors.blueColor,
        alignment: Alignment.bottomCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
              tag: heroTag,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget? child) {
                  return ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(10),
                      backgroundColor: _btnColorAnimation.value,
                      foregroundColor: _btnColorAnimation.value,
                      elevation: 0,
                    ),
                    child: Transform.rotate(
                      angle: _rotateAnimation.value,
                      child: Icon(
                        Icons.add,
                        color: _iconColorAnimation.value,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: EmptySpaces.defaultSpace),
            AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget? child) {
                return Opacity(
                  opacity: _fadeAnimation.value,
                  child: Column(
                    children: const[
                      BottomMenuTextButton(title: btnReminder),
                      BottomMenuTextButton(title: btnCamera),
                      BottomMenuTextButton(title: btnAttachment),
                      BottomMenuTextButton(title: btnTextNote),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: EmptySpaces.defaultSpace),
          ],
        ),
      ),
    );
  }
}
