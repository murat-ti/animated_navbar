import 'package:flutter/material.dart';
import '../../core/init/constants/sizes.dart';
import '../../core/init/constants/theme.dart';
import '../../view/home/model/coordinates.dart';
import '../buttons/bottom_menu_text.dart';
import '../buttons/button_default.dart';
import '../clippath/custom_path.dart';
import '../navbar/bottom_navbar.dart';

part 'custom_animation_part.dart';

class CustomAnimation extends StatefulWidget {
  const CustomAnimation({
    Key? key,
    required this.coordinates,
    required this.menuTitles,
    this.animationSpeed = 200,
  }) : super(key: key);

  final Coordinates coordinates;
  final List<String> menuTitles;
  final double animationSpeed;

  @override
  CustomAnimationState createState() => CustomAnimationState();
}

class CustomAnimationState extends State<CustomAnimation> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    initPositions(
      vsync: this,
      coordinates: widget.coordinates,
    );
    super.initState();
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
        buildCustomClipPath(
          context: context,
          coordinates: widget.coordinates,
          menuTitles: widget.menuTitles,
        ),
        buildFadedContainer(
          context: context,
          text: text,
        ),
        const BottomNavbar(bntWidth: Sizes.btnWidth),
        buildAnimatedButton(
          onDragUpdate: (details) {
            setState(() {
              animationSpeed = 0;
              //(x1 == x2) control axis direction
              //((y1 + details.delta.dy) < y2) control movement of widget out of given range
              x1 = (x1 == x2)
                  ? x1
                  : ((x1 - details.delta.dx) > x2)
                      ? widget.coordinates.endX
                      : x1 - details.delta.dx;
              y1 = (y1 == y2)
                  ? y1
                  : ((y1 - details.delta.dy) > y2)
                      ? widget.coordinates.endY
                      : y1 - details.delta.dy;

              //count background opacity
              backgroundOpacity = (y2 - y1) / (widget.coordinates.endY - widget.coordinates.startY);
            });
          },
          onDragEnd: (details) {
            setState(() {
              animationSpeed = 200;

              //on drag end set to target position
              x1 = widget.coordinates.endX;
              y1 = widget.coordinates.endY;
              backgroundOpacity = 0;

              //control widget position
              isBottomPosition = !isBottomPosition;
            });
          },
          onPressed: () {
            _controller.reset();
            setState(() {
              x1 = widget.coordinates.startX;
              y1 = widget.coordinates.startY;
              backgroundOpacity = 1;
              isBottomPosition = !isBottomPosition;
            });
          },
        ),
      ],
    );
  }
}
