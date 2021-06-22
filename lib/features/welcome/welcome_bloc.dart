import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_template/features/welcome/welcome_event.dart';
import 'package:flutter_app_template/features/welcome/welcome_state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:template_package/template_bloc/template_bloc.dart';
import 'package:template_package/template_package.dart';

class WelcomeBloc extends TemplateBloc {
  late PageController _pageController;
  final StreamController actionAnimationDataState = StreamController<ActionAnimationDataState>();
  final BehaviorSubject bottomShadeDataState = BehaviorSubject<PageIntrosDataState>();

  WelcomeBloc(BaseAnalytics analytics) : super(analytics) {
    registerStreams([
      actionAnimationDataState.stream,
      bottomShadeDataState.stream,
    ]);
    init();
  }

  void init() async {
    bottomShadeDataState.add(shadeDataStates().first);
    await Future.delayed(Duration(milliseconds: 1800));
    actionAnimationDataState.sink.add(ActionAnimationDataState(40, 45));
  }

  @override
  void onUiDataChange(BaseBlocEvent event) {
    if (event is InitTabControllerEvent) {
      _pageController = event.pageController;
      listenPages(_pageController);
    } else if (event is NextTapEvent) {
      _animateNext();
    }
  }

  void listenPages(PageController pageController) {
    var currentPage = 0;
    pageController.addListener(() {
      final newPage = pageController.page!.round();
      currentPage = newPage;
      PageIntrosDataState state = shadeDataStates()[currentPage];
      state.animationValue = calculateAnimationValue(pageController);
      state.isLast = (currentPage == shadeDataStates().length - 1);
      bottomShadeDataState.add(state);
    });
  }

  double calculateAnimationValue(PageController pageController) {
    if (pageController.page!.round() == 0) {
      return _pageController.page!;
    }
    final result = _pageController.page! / pageController.page!.round();
    return result;
  }

  List<PageIntrosDataState> shadeDataStates() => [
        FirstShadeDataState(title: 'welcome', subTitle: 'discover_intro'),
        SecondShadeDataState(title: 'explore', subTitle: 'we_connect_you_to_your_favourite'),
        ThirdShadeDataState(title: 'ready_set', subTitle: 'find_the_perfect_fit'),
      ];

  void _animateNext() {
    final nextPageIndex = _pageController.page!.round() + 1;
    _pageController.animateToPage(
      nextPageIndex,
      duration: Duration(seconds: 2),
      curve: Curves.easeInOutQuad,
    );
  }

  @override
  void dispose() {
    bottomShadeDataState.close();
    actionAnimationDataState.close();
    super.dispose();
  }
}
