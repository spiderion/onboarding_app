import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnimatedClipTransitionWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration initialDelayDuration;

  const AnimatedClipTransitionWidget(
      {Key? key,
      required this.child,
      this.duration = const Duration(milliseconds: 2000),
      this.initialDelayDuration = const Duration(milliseconds: 2300)})
      : super(key: key);

  @override
  _AnimatedClipTransitionWidgetState createState() => _AnimatedClipTransitionWidgetState();
}

class _AnimatedClipTransitionWidgetState extends State<AnimatedClipTransitionWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Tween<double> tweenStackPosition;
  late Tween<double> tweenBorderRadius;
  late Tween<double> tweenTwist;
  late Tween<double> tweenHeight;
  late CurvedAnimation curvedAnimation;
  int heightAddition = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: widget.duration);
    curvedAnimation = CurvedAnimation(parent: _animationController, curve: Curves.decelerate);
    tweenBorderRadius = Tween<double>(begin: 1000, end: 0);
    tweenStackPosition = Tween<double>(begin: -1200, end: 0);
    tweenTwist = Tween<double>(begin: -1.2, end: 0);
    tweenHeight = Tween<double>(begin: 0, end: 1000);
    init();
  }

  void init() async {
    await Future.delayed(widget.initialDelayDuration);
    await _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final widgetSize = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
        child: widget.child,
        animation: curvedAnimation,
        builder: (context, child) {
          return clippedWidget(widgetSize, child!);
        });
  }

  Widget clippedWidget(double widgetSize, Widget child) {
    return ClipRRect(
        borderRadius: getCircleBorderRadius(),
        child: Container(
            width: widgetSize * curvedAnimation.value,
            height: widgetSize * curvedAnimation.value,
            child: Stack(
              children: [
                Positioned(
                    right: tweenStackPosition.animate(curvedAnimation).value,
                    left: tweenStackPosition.animate(curvedAnimation).value,
                    top: tweenStackPosition.animate(curvedAnimation).value,
                    bottom: tweenStackPosition.animate(curvedAnimation).value,
                    child: Transform.rotate(angle: tweenTwist.animate(curvedAnimation).value, child: child)),
              ],
            )));
  }

  double getHeight(double widgetSize) {
    if (curvedAnimation.value > 0.8 && heightAddition < 100) {
      heightAddition += 10;
    }
    return widgetSize * curvedAnimation.value + heightAddition;
  }

  BorderRadius? getCircleBorderRadius() {
    return BorderRadius.circular(tweenBorderRadius.animate(_animationController).value);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
