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

  @override
  bool getBool(String key) {
    // TODO: implement getBool
    throw UnimplementedError();
  }

  @override
  double getDouble(String key) {
    // TODO: implement getDouble
    throw UnimplementedError();
  }

  @override
  int getInt(String key) {
    // TODO: implement getInt
    throw UnimplementedError();
  }
}
