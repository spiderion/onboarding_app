import 'dart:async';

import 'package:flutter_app_template/core/models/some_model.dart';
import 'package:flutter_app_template/core/states/primary_states/error_states/error_full_screen.dart';
import 'package:flutter_app_template/core/use_cases/user_use_case.dart';
import 'package:flutter_app_template/features/initial/initial_event.dart';
import 'package:flutter_app_template/features/initial/initial_state.dart';
import 'package:template_package/analytics/base_analytics.dart';
import 'package:template_package/error_state.dart';
import 'package:template_package/primary_states/common.dart';
import 'package:template_package/template_bloc/template_bloc.dart';
import 'package:template_package/template_package.dart';

class InitialBloc extends TemplateBloc {
  final String appName;
  final SomeUseCase someUseCase;
  final StreamController initialDataStateController = StreamController<InitialDataState>();

  InitialBloc(BaseAnalytics analytics, this.someUseCase, this.appName) : super(analytics) {
    registerStreams([initialDataStateController.stream]);
    init();
  }

  void init() {
    initialDataStateController.sink.add(InitialDataState(text: 'Initial data:', appName: appName));
  }

  @override
  void onUiDataChange(BaseBlocEvent event) {
    if (event is SaveDataEvent) {
      saveData(event.data);
    } else if (event is GetDataEvent) {
      fetchData();
    }
  }

  void fetchData() {
    someUseCase.getSomeData(RequestObserver(onListen: (SomeModel? someModel) {
      initialDataStateController.sink.add(InitialDataState(
          text: 'from database:',
          appName: appName,
          someData: someModel?.someData.toUpperCase() ?? "",
          isHorizontalStyle: true));
      sinkState?.add(MessageInfoState("success"));
    }, onError: (Error e) {
      sinkState?.add(ErrorFullScreenState(
          error: e,
          onCtaTap: () {
            sinkState?.add(MaybePopState());
          }));
    }));
  }

  void saveData(String data) {
    final someModel = SomeModel('some data');
    someUseCase.setSomeData(RequestObserver(
        requestData: someModel,
        onListen: (_) => sinkState?.add(MessageInfoState("saved")),
        onError: (e) => sinkState?.add(ErrorState(error: e))));
  }

  @override
  void dispose() {
    initialDataStateController.close();
    super.dispose();
  }
}
