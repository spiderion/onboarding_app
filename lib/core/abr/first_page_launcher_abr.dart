import 'package:flutter/material.dart';
import 'package:flutter_app_template/dependency/sub_modules/bloc_sub_module.dart';
import 'package:flutter_app_template/features/initial/initial_page.dart';
import 'package:flutter_app_template/features/welcome/welcome_page.dart';
import 'package:template_package/template_package.dart';

class FirstPageLauncherABR implements ABR {
  final BlocSubModule _blocSubModule;

  FirstPageLauncherABR(this._blocSubModule);

  Future<Widget> decideFirstScreen({dynamic userProfile, required String appName}) async {
    if (!(await _isCurrentVersionAllowed())) {
      return getMaintenancePage();
    }
    return getWelcomePage();
  }

  Widget getRequiredOptionPage(userProfile) => Scaffold(body: Center(child: Text("optionRequired")));

  Widget getRootPage(String appName) => InitialPage(() => _blocSubModule.rootBloc(appName));

  Widget getMaintenancePage() => Scaffold(body: Center(child: Text("maintenance")));

  Future<bool> _isCurrentVersionAllowed() async => true;

  Widget getLogInPage() => Scaffold(body: Center(child: Text("login")));

  Widget getWelcomePage() => WelcomePage(() => _blocSubModule.welcomeBloc());

  Widget getConnectionErrorPage() => Scaffold(body: Center(child: Text("app start error")));
}
