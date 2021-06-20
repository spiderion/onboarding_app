import 'package:flutter_app_template/core/models/some_model.dart';
import 'package:flutter_app_template/core/repositories/initial_repository.dart';
import 'package:template_package/template_package.dart';

class SomeUseCase extends UseCase<ResultModel, ResultModel, InitialRepository> {
  SomeUseCase(InitialRepository repository) : super(repository);

  Future<void> getSomeData(RequestObserver<dynamic, SomeModel?> requestBehaviour) async {
    await repository.getSomeData(RequestObserver<dynamic, SomeModel?>(
        onListen: (SomeModel? data) {
          requestBehaviour.onListen?.call(data);
        },
        onError: requestBehaviour.onError));
  }

  Future<void> setSomeData(RequestObserver<SomeModel?, dynamic> requestBehaviour) async {
    await repository.setSomeData(RequestObserver<SomeModel?, dynamic>(
        requestData: requestBehaviour.requestData,
        onListen: (_) {
          requestBehaviour.onListen?.call(_);
        },
        onError: requestBehaviour.onError));
  }
}
