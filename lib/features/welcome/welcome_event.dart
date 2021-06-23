import 'package:flutter/material.dart';
import 'package:template_package/template_package.dart';

class InitTabControllerEvent extends BaseBlocEvent {
  final PageController pageController;
  final AnimationController backgroundAnimationController;

  InitTabControllerEvent({required this.pageController, required this.backgroundAnimationController}) : super('');
}

class NextTapEvent extends BaseBlocEvent {
  NextTapEvent() : super('next_tap');
}

class BackClickEvent extends BaseBlocEvent {
  final dynamic variable;

  BackClickEvent(String analytic, {this.variable}) : super(analytic);
}
