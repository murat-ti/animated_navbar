import 'package:flutter/material.dart';

class CustomPath extends CustomClipper<Path> {
  final double value;
  final double startValue;
  final double endValue;
  static const double btnSize = 18.0;

  CustomPath({required this.value, required this.startValue, required this.endValue});

  @override
  Path getClip(Size size) {
    var path = Path();
    final avgPoint = (startValue + endValue) / 2;
    final countedValue = value <= (startValue + avgPoint)
        ? (size.height - value)
        : (((size.height - (startValue + avgPoint)) / avgPoint) * (startValue + avgPoint + value) -
            (size.height - avgPoint))
        ;

    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.48, size.height, (size.width * 0.5) - (btnSize), countedValue - btnSize);
    //path.lineTo((size.width * 0.5) + btnSize, countedValue - btnSize);
    path.quadraticBezierTo(
        (size.width * 0.5), countedValue - btnSize * 2, (size.width * 0.52) + (btnSize), countedValue - btnSize);
    path.quadraticBezierTo((size.width * 0.48) + (btnSize * 2), size.height, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
