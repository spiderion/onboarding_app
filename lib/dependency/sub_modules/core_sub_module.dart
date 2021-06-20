import 'package:flutter_app_template/core/configuration/remote_config.dart';
import 'package:flutter_app_template/core/data/dao.dart';
import 'package:flutter_app_template/core/data/database.dart';
import 'package:template_package/exception_captor/default_exception_captor.dart';
import 'package:template_package/template_package.dart';

class CoreSubModule extends ISubModule {
  BaseAnalytics? _analytics;

  @override
  init(List<ISubModule> subModules) {}

  BaseAnalytics analytics() {
    _analytics ??= AnalyticsProxy([]);
    return _analytics!;
  }

  Dao dao() => DataBase({});

  RemoteConfiguration remoteConfig() => RemoteConfig();

  ExceptionCaptor exceptionCaptor() => DefaultExceptionCaptor();
}
