import 'package:flutter/material.dart';
import '../../../view/first_route.dart';
import '../../../view/second_route.dart';
import 'route_paths.dart';

Route<dynamic>? generateRoute(settings) {
  switch (settings.name) {
    case RoutePaths.secondRoute:
      return CustomFadeRoute(page: const SecondRoute(), settings: settings);
    default:
      return MaterialPageRoute(builder: (context) => const FirstRoute(), settings: settings);
  }
}

class CustomFadeRoute extends PageRouteBuilder {
  final Widget page;

  @override
  final RouteSettings settings;

  CustomFadeRoute({required this.page, required this.settings})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          settings: settings,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeInCirc,
              ),
            ),
            child: child,
          ),
        );
}
