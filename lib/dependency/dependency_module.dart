import 'package:dependency_provider/base_sub_module.dart';
import 'package:dependency_provider/dependency_module/dependency_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_template/dependency/sub_modules/abr_sub_module.dart';
import 'package:flutter_app_template/dependency/sub_modules/bloc_sub_module.dart';
import 'package:flutter_app_template/dependency/sub_modules/core_sub_module.dart';
import 'package:flutter_app_template/dependency/sub_modules/locale_sub_module.dart';
import 'package:flutter_app_template/dependency/sub_modules/repository_sub_module.dart';
import 'package:flutter_app_template/dependency/sub_modules/use_case_sub_module.dart';
import 'package:flutter_app_template/dependency/sub_modules/value_notifier_sub_module.dart';

///CRUCIAL IMPORTANCE THIS CLASS MUST BE INITIALIZED IN MAIN ONLY ONE TIME
///if you need any object use [DProvider] which has access to this [subModules]
class DependencyModule extends BaseDependencyModule {
  // final AppConfig appConfig;
  // final RemoteConfiguration remoteConfiguration;

  DependencyModule(/*{required this.appConfig, required this.remoteConfiguration}*/);

  @protected
  @override
  List<ISubModule> createSubmodules() {
    return [
      CoreSubModule(),
      BlocSubModule(),
      UseCaseSubModule(),
      RepositorySubModule(),
      ValueNotifierSubModule(),
      ABRSubModule(),
      LocaleSubModule(),
    ];
  }
}
