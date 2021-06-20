import 'package:template_package/template_package.dart';

class SaveDataEvent extends BaseBlocEvent {
  final String data;

  SaveDataEvent(String? analyticEventName, this.data) : super(analyticEventName);
}

class GetDataEvent extends BaseBlocEvent {
  GetDataEvent(String? analyticEventName) : super(analyticEventName);
}
