import 'package:flutter/material.dart';
import '../core/init/route/route.dart';
import '../core/init/route/route_paths.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RoutePaths.thirdRoute,
      onGenerateRoute: generateRoute,
    );
  }
}


