import 'package:flutter/material.dart';
import 'package:template_package/template_package.dart';

class InitTabControllerEvent extends BaseBlocEvent {
  final PageController pageController;

  InitTabControllerEvent({required this.pageController}) : super('');
}

class NextTapEvent extends BaseBlocEvent {


  NextTapEvent() : super('next_tap');
}