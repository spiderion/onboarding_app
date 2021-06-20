import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_template/features/welcome/welcome_event.dart';
import 'package:flutter_app_template/features/welcome/welcome_state.dart';
import 'package:template_package/template_bloc/template_bloc.dart';
import 'package:template_package/template_package.dart';

class WelcomeBloc extends TemplateBloc {
  late PageController _pageController;
  final StreamController actionAnimationDataState = StreamController<ActionAnimationDataState>();

  WelcomeBloc(BaseAnalytics analytics) : super(analytics) {
    registerStreams([actionAnimationDataState.stream]);
    init();
  }

  void init() async {
    await Future.delayed(Duration(milliseconds: 1800));
    actionAnimationDataState.sink.add(ActionAnimationDataState(40, 45));
  }

  @override
  void onUiDataChange(BaseBlocEvent event) {
    if (event is InitTabControllerEvent) {
      _pageController = event.pageController;
    } else if (event is NextTapEvent) {
      _animateNext();
    }
  }

  void _animateNext() {
    _pageController.animateToPage(
      _pageController.page!.round() + 1,
      duration: Duration(seconds: 2),
      curve: Curves.easeInOutQuad,
    );
  }

  @override
  void dispose() {
    actionAnimationDataState.close();
    super.dispose();
  }
}
