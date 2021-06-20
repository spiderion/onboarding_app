import 'package:flutter_app_template/dependency/sub_modules/use_case_sub_module.dart';
import 'package:flutter_app_template/features/initial/initial_bloc.dart';
import 'package:flutter_app_template/features/welcome/welcome_bloc.dart';
import 'package:template_package/template_package.dart';

import 'core_sub_module.dart';

class BlocSubModule extends ISubModule {
  late CoreSubModule _coreSubModule;
  late UseCaseSubModule _useCaseSubModule;

  @override
  init(List<ISubModule> subModules) {
    _coreSubModule = subModules.singleWhere((element) => element is CoreSubModule) as CoreSubModule;
    _useCaseSubModule = subModules.singleWhere((element) => element is UseCaseSubModule) as UseCaseSubModule;
  }

  InitialBloc rootBloc(String appName) =>
      InitialBloc(_coreSubModule.analytics(), _useCaseSubModule.userUseCase(), appName);

  WelcomeBloc welcomeBloc() => WelcomeBloc(_coreSubModule.analytics());
}
