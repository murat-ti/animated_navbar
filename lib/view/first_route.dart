import 'package:animated_navbar/core/init/constants/theme.dart';
import 'package:flutter/material.dart';
import '../core/init/route/route_paths.dart';
import '../widgets/buttons/bottom_navbar_icon.dart';
import '../widgets/buttons/button_default.dart';

class FirstRoute extends StatefulWidget {
  const FirstRoute({super.key});

  @override
  State<FirstRoute> createState() => _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> {
  static const text = 'Events';
  static const bntWidth = 56.0;
  static const bottomNavBarHeight = 48.0;
  double screenWidth = 0;
  double screenHeight = 0;
  double xPosition = 0;
  double yPosition = 0;

  @override
  void didChangeDependencies() {
    screenWidth = MediaQuery.of(context).size.width - bntWidth;
    screenHeight = MediaQuery.of(context).size.height;
    xPosition = screenWidth / 2;
    yPosition = 0;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.whiteColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
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
                SizedBox(
                  child: BottomAppBar(
                    color: UIColors.whiteColor,
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
              ],
            ),
            Positioned(
              left: xPosition,
              bottom: yPosition,
              child: Hero(
                tag: 'menuButton',
                child: Draggable<String>(
                  axis: Axis.vertical,
                  feedback: const ButtonDefault(
                    backgroundColor: UIColors.blueColor,
                    child: Icon(Icons.add, color: UIColors.whiteColor),
                  ),
                  childWhenDragging: const SizedBox(width: bntWidth),
                  onDragEnd: (DraggableDetails details) {
                    setState(() {
                      xPosition = details.offset.dx;
                      yPosition = screenHeight - details.offset.dy - bottomNavBarHeight;
                    });

                    Navigator.pushNamed(context, RoutePaths.secondRoute).then(
                          (value) {
                        setState(() {
                          yPosition = 0;
                        });
                      },
                    );
                  },
                  child: const ButtonDefault(
                    backgroundColor: UIColors.blueColor,
                    child: Icon(Icons.add, color: UIColors.whiteColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
