import 'package:flutter/material.dart';

class IntroTextWidget extends StatefulWidget {
  final String? title;
  final String? subTitle;
  final Curve curve;
  final Duration duration;

  const IntroTextWidget(
      {Key? key,
      required this.title,
      required this.subTitle,
      this.curve = Curves.decelerate,
      this.duration = const Duration(seconds: 2)})
      : super(key: key);

  @override
  _IntroTextWidgetState createState() => _IntroTextWidgetState();
}

class _IntroTextWidgetState extends State<IntroTextWidget> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2
        ,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      titleWidget(widget.title ?? ''),
      subTitleWidget(widget.subTitle ?? ''),
    ]));
  }

  Widget titleWidget(String title) {
    return Text(title.toUpperCase(), style: Theme.of(context).textTheme.headline5);
  }

  Widget subTitleWidget(String subtitle) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Text(
        subtitle,
        style: TextStyle(fontSize: 12),
        textAlign: TextAlign.center,
      ),
    );
  }
}
