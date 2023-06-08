part of 'custom_animation.dart';

double x1 = 0;
double y1 = 0;
double x2 = 0;
double y2 = 0;
bool isBottomPosition = true;
int animationSpeed = 0;
double backgroundOpacity = 1.0;

//titles
const text = 'Events';

//animation
late final AnimationController _controller;
late final Animation<double> _rotateAnimation;
late final Animation<Color?> _iconColorAnimation;
late final Animation<Color?> _btnColorAnimation;
late final Animation<double> _fadeAnimation;

initPositions({required TickerProvider vsync, required Coordinates coordinates}) {
  x1 = coordinates.startX;
  y1 = coordinates.startY;
  x2 = coordinates.endX;
  y2 = coordinates.endY;

  _controller = AnimationController(vsync: vsync, duration: const Duration(milliseconds: 1000));
  _rotateAnimation =
      Tween(begin: 0.0, end: 0.75).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.5)));
  _iconColorAnimation = ColorTween(begin: UIColors.whiteColor, end: UIColors.blueColor)
      .animate(CurvedAnimation(parent: _controller, curve: const Interval(0.5, 1.0)));
  _btnColorAnimation = ColorTween(begin: UIColors.blueColor, end: UIColors.whiteColor)
      .animate(CurvedAnimation(parent: _controller, curve: const Interval(0.5, 1.0)));
  _fadeAnimation =
      Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: const Interval(0.0, 1.0)));
}

Opacity buildFadedContainer({
  required BuildContext context,
  required String text,
}) {
  return Opacity(
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
  );
}

ClipPath buildCustomClipPath({
  required BuildContext context,
  required Coordinates coordinates,
  required List<String> menuTitles,
}) {
  return ClipPath(
    clipper: CustomPath(
      value: y1,
      startValue: coordinates.startY,
      endValue: coordinates.endY,
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
                child: Column(children: menuTitles.map((title) => BottomMenuTextButton(title: title)).toList()),
              );
            },
          ),
          const SizedBox(height: EmptySpaces.defaultSpace),
        ],
      ),
    ),
  );
}

AnimatedPositioned buildAnimatedButton({
  Function(DragUpdateDetails)? onDragUpdate,
  Function(DraggableDetails)? onDragEnd,
  Function()? onPressed,
}) {
  return AnimatedPositioned(
    left: x1,
    bottom: y1,
    duration: Duration(milliseconds: animationSpeed),
    child: Draggable(
      onDragUpdate: onDragUpdate,
      onDragEnd: onDragEnd,
      feedback: const SizedBox.shrink(),
      child: backgroundOpacity == 0
          ? AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget? child) {
                return ButtonDefault(
                  onPressed: onPressed,
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
  );
}
