import 'package:template_package/template_package.dart';

class RemoteConfig extends RemoteConfiguration {
  @override
  Future<bool> fetchLatest() async {
    return true;
  }

  @override
  String getString(String key) {
    return key;
  }
}
