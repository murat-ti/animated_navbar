import 'package:flutter/material.dart';
import '../../core/init/constants/sizes.dart';
import '../../core/init/constants/theme.dart';
import '../buttons/bottom_menu_text.dart';
import '../buttons/bottom_navbar_icon.dart';
import '../buttons/button_default.dart';
import '../clippath/custom_path.dart';

class CustomDraggable extends StatefulWidget {
  const CustomDraggable(
      {Key? key,
      required this.startX,
      required this.startY,
      required this.endX,
      required this.endY,
      this.animationSpeed = 200})
      : super(key: key);

  final double startX;
  final double startY;
  final double endX;
  final double endY;
  final double animationSpeed;

  @override
  CustomDraggableState createState() => CustomDraggableState();
}

class CustomDraggableState extends State<CustomDraggable> with SingleTickerProviderStateMixin {
  double x1 = 0;
  double y1 = 0;
  double x2 = 0;
  double y2 = 0;
  bool isBottomPosition = true;
  int animationSpeed = 0;
  double backgroundOpacity = 1.0;

  //sizes
  static const bntWidth = 56.0;
  static const bntHeight = 40.0;

  //titles
  static const text = 'Events';
  static const btnReminder = 'Reminder';
  static const btnCamera = 'Camera';
  static const btnAttachment = 'Attachment';
  static const btnTextNote = 'Text Note';

  //animation
  late final AnimationController _controller;
  late final Animation<double> _rotateAnimation;
  late final Animation<Color?> _iconColorAnimation;
  late final Animation<Color?> _btnColorAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    initPositions();
    super.initState();
  }

  initPositions() {
    x1 = widget.startX;
    y1 = widget.startY;
    x2 = widget.endX;
    y2 = widget.endY;

    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _rotateAnimation =
        Tween(begin: 0.0, end: 0.75).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.5)));
    _iconColorAnimation = ColorTween(begin: UIColors.whiteColor, end: UIColors.blueColor)
        .animate(CurvedAnimation(parent: _controller, curve: const Interval(0.5, 1.0)));
    _btnColorAnimation = ColorTween(begin: UIColors.blueColor, end: UIColors.whiteColor)
        .animate(CurvedAnimation(parent: _controller, curve: const Interval(0.5, 1.0)));
    _fadeAnimation =
        Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.0, 1.0)));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //play only one time on each reset
    if (backgroundOpacity == 0) {
      _controller.forward();
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        ClipPath(
          clipper: CustomPath(
            value: y1 + bntHeight,
            startValue: widget.startY,
            endValue: widget.endY,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: UIColors.blueColor,
            alignment: Alignment.bottomCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: EmptySpaces.defaultSpace),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (BuildContext context, Widget? child) {
                    return Opacity(
                      opacity: _fadeAnimation.value,
                      child: Column(
                        children: const [
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
        ),
        Opacity(
          opacity: backgroundOpacity,
          child: Container(
            color: UIColors.whiteColor,
            child: Center(
              child: Text(
                text,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: UIColors.blueColor900,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            child: BottomAppBar(
              color: Colors.transparent, //UIColors.whiteColor,
              elevation: 0,
              shape: const CircularNotchedRectangle(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  BottomNavbarIcon(icon: Icons.home),
                  BottomNavbarIcon(icon: Icons.search),
                  SizedBox(width: bntWidth),
                  BottomNavbarIcon(icon: Icons.flash_on),
                  BottomNavbarIcon(icon: Icons.account_box),
                ],
              ),
            ),
          ),
        ),
        AnimatedPositioned(
          left: x1,
          top: y1,
          duration: Duration(milliseconds: animationSpeed),
          child: Draggable(
            onDragUpdate: (details) {
              setState(() {
                animationSpeed = 0;
                //(x1 == x2) control axis direction
                //((y1 + details.delta.dy) < y2) control movement of widget out of given range
                x1 = (x1 == x2)
                    ? x1
                    : ((x1 + details.delta.dx) < x2)
                        ? widget.endX
                        : x1 + details.delta.dx;
                y1 = (y1 == y2)
                    ? y1
                    : ((y1 + details.delta.dy) < y2)
                        ? widget.endY
                        : y1 + details.delta.dy;

                //count background opacity
                backgroundOpacity = (y1 - y2) / (widget.startY - widget.endY);
              });
            },
            onDragEnd: (details) {
              setState(() {
                animationSpeed = 200;

                //on drag end set to target position
                x1 = widget.endX;
                y1 = widget.endY;
                backgroundOpacity = 0;

                //control widget position
                isBottomPosition = !isBottomPosition;
              });
            },
            feedback: const SizedBox.shrink(),
            child: backgroundOpacity == 0
                ? AnimatedBuilder(
                    animation: _controller,
                    builder: (BuildContext context, Widget? child) {
                      return ButtonDefault(
                        onPressed: () {
                          _controller.reset();
                          setState(() {
                            x1 = widget.startX;
                            y1 = widget.startY;
                            backgroundOpacity = 1;
                            isBottomPosition = !isBottomPosition;
                          });
                        },
                        backgroundColor: _btnColorAnimation.value,
                        child: Transform.rotate(
                          angle: _rotateAnimation.value,
                          child: Icon(
                            Icons.add,
                            color: _iconColorAnimation.value,
                          ),
                        ),
                      );
                    },
                  )
                : const ButtonDefault(
                    backgroundColor: UIColors.blueColor,
                    child: Icon(Icons.add, color: UIColors.whiteColor),
                  ),
          ),
        ),
      ],
    );
  }
}
