import 'package:flutter_app_template/core/data/db_paths.dart';

import 'dao.dart';

class DataBase extends Dao {
  final Map<String, dynamic> _db;

  DataBase(this._db);

  @override
  Future<dynamic> getSomeData() async {
    return _db[DbPaths.SOME_DATA_KEY];
  }

  @override
  Future<dynamic> setSomeData(dynamic someData) async {
    _db[DbPaths.SOME_DATA_KEY] = someData;
  }
}
