import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_template/features/welcome/welcome_event.dart';
import 'package:flutter_app_template/features/welcome/welcome_state.dart';
import 'package:rxdart/rxdart.dart';
import 'package:template_package/template_bloc/template_bloc.dart';
import 'package:template_package/template_package.dart';

class WelcomeBloc extends TemplateBloc {
  late PageController _pageController;
  late AnimationController _backgroundAnimationController;
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
      _backgroundAnimationController = event.backgroundAnimationController;
      _backgroundAnimationController.animateTo(0.1,
          duration: Duration(seconds: 5), curve: Curves.linearToEaseOut);
      listenPages(_pageController);
    } else if (event is NextTapEvent) {
      _animateNext();
    } else if (event is BackClickEvent) {
      _animateBack();
    }
  }

  void listenPages(PageController pageController) {
    var currentPage = 0;
    pageController.addListener(() {
      final newPage = pageController.page!.round();
      currentPage = newPage;
      PageIntrosDataState state = shadeDataStates()[currentPage];
      state.textAnimationValue = calculateTextAnimationValue(pageController);
      state.isLast = (currentPage == shadeDataStates().length - 1);
      animateBackground(pageController);
      bottomShadeDataState.add(state);
    });
  }

  double calculateTextAnimationValue(PageController pageController) {
    if (pageController.page!.round() == 0) {
      return _pageController.page!;
    }
    final result = _pageController.page! / pageController.page!.round();
    return result;
  }

  void animateBackground(PageController pageController) {
    final currentPage = pageController.page!;
    final value = currentPage / shadeDataStates().length;
    _backgroundAnimationController.animateTo(value,
        duration: Duration(seconds: 6 + currentPage.round()), curve: Curves.fastLinearToSlowEaseIn);
  }

  List<PageIntrosDataState> shadeDataStates() => [
        FirstShadeDataState(title: 'welcome', subTitle: 'discover_intro'),
        SecondShadeDataState(title: 'explore', subTitle: 'we_connect_you_to_your_favourite'),
        ThirdShadeDataState(title: 'ready_set', subTitle: 'find_the_perfect_fit'),
      ];

  void _animateNext() {
    final nextPageIndex = _pageController.page!.round() + 1;
    _animateToPage(nextPageIndex);
  }

  void _animateBack() {
    final nextPageIndex = _pageController.page!.round() - 1;
    _animateToPage(nextPageIndex);
  }

  void _animateToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: Duration(seconds: 2),
      curve: shadeDataStates()[_pageController.page!.round()].curve,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _backgroundAnimationController.dispose();
    bottomShadeDataState.close();
    actionAnimationDataState.close();
    super.dispose();
  }
}
