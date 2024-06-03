import 'package:duotask/core/error/failures.dart';
import 'package:duotask/core/obs/observable_request.dart';
import 'package:mobx/mobx.dart';

class ObservableDataController<T> {
  ObservableDataController({required T defaultValue, this.defaultFailure}) {
    data = Observable(defaultValue);
    request = ObservableRequest(
      defaultValue: defaultValue,
      defaultFailure: defaultFailure,
    );
  }

  final Failure? defaultFailure;

  late final Observable<T> data;

  late final ObservableRequest<T> request;

  Future<void> execute(Future<T> Function() request) async {
    if (this.request.isPending.value) {
      return;
    }

    runInAction(
      () => this.request.future = ObservableFuture(request()),
    );

    final response = await this.request.future;

    if (this.request.isFulfilled.value) {
      runInAction(() async {
        data = Observable(response);
      });
    }
  }
}
