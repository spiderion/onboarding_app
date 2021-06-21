import 'package:flutter/widgets.dart';

class AnimatedPositionedLogo extends StatefulWidget {
  final Duration duration;
  final Duration delayDuration;
  final Widget child;

  const AnimatedPositionedLogo(
      {Key? key,
      this.duration = const Duration(seconds: 2),
      this.delayDuration = const Duration(seconds: 2),
      required this.child})
      : super(key: key);

  @override
  _AnimatedPositionedLogoState createState() => _AnimatedPositionedLogoState();
}

class _AnimatedPositionedLogoState extends State<AnimatedPositionedLogo> {
  var fromTop = -100.0;

  @override
  void initState() {
    Future.delayed(widget.delayDuration).then((value) {
      fromTop = 0.0;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(top: fromTop, child: widget.child, duration: widget.duration);
  }
}
