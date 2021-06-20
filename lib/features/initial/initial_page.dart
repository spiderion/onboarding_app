import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_template/features/initial/initial_event.dart';
import 'package:flutter_app_template/features/initial/initial_state.dart';
import 'package:template_package/base_widget/base_widget.dart';
import 'package:template_package/template_bloc/template_bloc.dart';
import 'package:template_package/template_package.dart';

class InitialPage extends BaseWidget {
  InitialPage(TemplateBloc Function() getBloc) : super(getBloc);

  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends BaseState<InitialPage, BaseBloc> {
  @override
  Widget build(BuildContext context) => mainWidget();

  Widget mainWidget() {
    return StreamBuilder<InitialDataState>(
        stream: bloc.getStreamOfType<InitialDataState>(),
        builder: (BuildContext context, AsyncSnapshot<InitialDataState> snapshot) {
          return Scaffold(
              floatingActionButton: saveButton(),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              appBar: AppBar(centerTitle: true, title: Text(snapshot.data?.appName ?? "")),
              body: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getCustomWidget(snapshot.data?.isHorizontalStyle ?? false),
                  SizedBox(height: 50),
                  Text('${translate('root_page')}'),
                  SizedBox(height: 20),
                  Text('${translate('welcome_to')} ${snapshot.data?.someData ?? ''}'),
                ],
              )));
        });
  }

  Widget saveButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            onPressed: () {
              bloc.event.add(SaveDataEvent('analytic_event_name_set', 'some data'));
            },
            child: Text(translate('save_data'))),
        ElevatedButton(
            onPressed: () {
              bloc.event.add(GetDataEvent('analytic_event_name_get'));
            },
            child: Text(translate('get_data'))),
      ],
    );
  }

  Widget getCustomWidget(bool isHorizontalStyle) {
    return FlutterLogo(
      size: isHorizontalStyle ? MediaQuery.of(context).size.width * 0.8 : MediaQuery.of(context).size.width * 0.5,
      duration: Duration(seconds: 3),
      style: isHorizontalStyle == true ? FlutterLogoStyle.horizontal : FlutterLogoStyle.markOnly,
    );
  }
}
