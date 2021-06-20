class SomeModel {
  final String someData;
  static const someData_key = "someData";

  SomeModel(this.someData);

  Map<String, dynamic> toJson({bool isStoreLocal = false}) => {someData_key: someData};

  @override
  SomeModel.fromJson(Map<String, dynamic>? json) : someData = (json ?? {})[someData_key];
}
