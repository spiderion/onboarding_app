import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_template/core/constants/material_constants/material_constants.dart';
import 'package:flutter_app_template/features/welcome/welcome_event.dart';
import 'package:flutter_app_template/features/welcome/welcome_state.dart';
import 'package:flutter_app_template/widgets/animated_circle_transition_widget.dart';
import 'package:flutter_app_template/widgets/animated_logo.dart';
import 'package:flutter_app_template/widgets/intro_text_widget.dart';
import 'package:flutter_app_template/widgets/shadow_image.dart';
import 'package:rive/rive.dart' as rive;
import 'package:template_package/base_widget/base_widget.dart';
import 'package:template_package/template_package.dart';

class WelcomePage extends BaseWidget {
  WelcomePage(BaseBloc Function() getBloc) : super(getBloc);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends BaseState<WelcomePage, BaseBloc> with SingleTickerProviderStateMixin {
  final carouselLength = 3;
  late PageController pageController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 1);
    _tabController = TabController(length: carouselLength, vsync: this);
    var currentPage = 0;
    pageController.addListener(() {
      final newPage = pageController.page!.round();
      if (newPage != currentPage) {
        currentPage = newPage;
        _tabController.animateTo(newPage);
      }
    });
    bloc.event.add(InitTabControllerEvent(pageController: pageController));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: null,
        builder: (context, AsyncSnapshot snapshot) {
          return getMainContent(context);
        });
  }

  Scaffold getMainContent(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [getBackground(), getBodyWidget()],
    ));
  }

  Widget getBodyWidget() {
    final pageOverFlow = -30.0;
    return Stack(
      children: [
        Positioned.fill(
          right: pageOverFlow,
          left: pageOverFlow,
            top: -50,
            bottom: 50,
            child: pageViewer()),
        Align(alignment: Alignment.bottomCenter, child: getBottomWidget()),
        AnimatedPositionedLogo(
            child: SafeArea(
                child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Text('Fit', style: Theme.of(context).textTheme.headline5),
        )))
      ],
    );
  }

  Widget pageViewer() {
    return PageView(controller: pageController, children: [
      getPage('assets/images/run_girl.png'),
      getPage('assets/images/run_girl2.png', duration: Duration.zero),
      getPage('assets/images/gym_girl.png', duration: Duration.zero),
    ]);
  }

  Column getPage(String imagePath, {Duration? duration}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedCircleTransitionWidget(
            child: ShadowImage(imagePath), initialDelayDuration: duration ?? Duration(milliseconds: 2300)),
      ],
    );
  }

  Widget getBottomWidget() {
    final screenSize = MediaQuery.of(context).size;
    final height = screenSize.height * .4;
    return Stack(
      children: [
        _bottomBackgroundAnimation(),
        Container(
          height: height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(child: _getIntroTexts()),
              Flexible(child: horizontalActionsWidget()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _getIntroTexts() {
    return StreamBuilder<PageIntrosDataState>(
        stream: bloc.getStreamOfType<PageIntrosDataState>(),
        builder: (context, AsyncSnapshot<PageIntrosDataState> snapshot) {
          if (snapshot.data == null) return Container();
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..rotateY(pi * snapshot.data!.animationValue),
            child: transformedIntroTextWidget(snapshot.data!),
          );
        });
  }

  Widget transformedIntroTextWidget(PageIntrosDataState pageIntrosDataState) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()..rotateY(pi * (pageIntrosDataState.isFirst ? 0 : 1)),
      child: IntroTextWidget(
          title: translate(pageIntrosDataState.title), subTitle: translate(pageIntrosDataState.subTitle)),
    );
  }

  Widget _bottomBackgroundAnimation() {
    return StreamBuilder(
        stream: bloc.getStreamOfType<PageIntrosDataState>(),
        builder: (context, AsyncSnapshot<PageIntrosDataState> snapshot) {
          return AnimatedContainer(
              duration: Duration(seconds: 2),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent,Colors.white10, snapshot.data?.color ?? Theme.of(context).backgroundColor])),
              height: MediaQuery.of(context).size.width,
              child: rive.RiveAnimation.asset('assets/rive/new_file.riv'));
        });
  }

  Widget horizontalActionsWidget() {
    return StreamBuilder(
        stream: bloc.getStreamOfType<ActionAnimationDataState>(),
        builder: (context, AsyncSnapshot<ActionAnimationDataState> snapshot) {
          return Stack(
            children: [
              AnimatedPositioned(
                curve: Curves.decelerate,
                duration: Duration(milliseconds: 1500),
                right: snapshot.data?.edgePaddingRight ?? -100.0,
                left: (snapshot.data?.edgePaddingLeft ?? -100.0),
                top: 0.0,
                bottom: 0.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SafeArea(
                      child: Row(
                        children: [
                          TabPageSelector(controller: _tabController, indicatorSize: 7),
                          Spacer(),
                          forwardButton(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  Widget forwardButton() {
    return StreamBuilder(
        stream: bloc.getStreamOfType<PageIntrosDataState>(),
        builder: (context, AsyncSnapshot<PageIntrosDataState> snapshot) {
          return InkWell(
            onTap: () => bloc.event.add(NextTapEvent()),
            borderRadius: BorderRadius.circular(50),
            child: snapshot.data?.isLast == true
                ? SizedBox(
                    height: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('go'.toUpperCase(),
                            style: TextStyle(fontFamily: MaterialFont.TERTIARY, fontWeight: FontWeight.w300)),
                      ],
                    ),
                  )
                : SizedBox(
                    height: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_forward,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
          );
        });
  }

  Widget getBackground() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
              child: Container(
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.background),
          )),
        ],
      ),
    );
  }
}
