import 'package:flutter/material.dart';
import 'package:template_package/template_package.dart';

class ActionAnimationDataState extends BaseBlocDataState {
  final double edgePaddingRight;
  final double edgePaddingLeft;

  ActionAnimationDataState(this.edgePaddingLeft, this.edgePaddingRight);
}

abstract class PageIntrosDataState extends BaseBlocDataState {
  final String title;
  final String subTitle;
  final Color color;

  PageIntrosDataState(this.color, this.title, this.subTitle);
}

class FirstShadeDataState extends PageIntrosDataState {
  FirstShadeDataState({required String title, required String subTitle}) : super(Colors.pink[400]!, title, subTitle);
}

class SecondShadeDataState extends PageIntrosDataState {
  SecondShadeDataState({required String title, required String subTitle}) : super(Colors.pink[300]!, title, subTitle);
}

class ThirdShadeDataState extends PageIntrosDataState {
  ThirdShadeDataState({required String title, required String subTitle}) : super(Colors.deepOrange, title, subTitle);
}
