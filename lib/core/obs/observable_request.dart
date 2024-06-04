import 'dart:developer';

import 'package:duotask/core/error/error_handler.dart';
import 'package:duotask/core/error/failures.dart';
import 'package:mobx/mobx.dart';

class ObservableRequest<T> {
  ObservableRequest({required T defaultValue, this.defaultFailure}) {
    future = ObservableFuture.value(defaultValue);
    status = Observable(FutureStatus.fulfilled);
  }

  final Failure? defaultFailure;

  late ObservableFuture<T> future;

  late Observable<FutureStatus> status;

  late final Computed<bool> isFulfilled =
      Computed(() => status.value == FutureStatus.fulfilled);

  late final Computed<bool> isPending =
      Computed(() => status.value == FutureStatus.pending);

  late final Computed<bool> isRejected =
      Computed(() => status.value == FutureStatus.rejected);

  late final Computed<T?> data = Computed(() {
    return isFulfilled.value ? future.value : null;
  });

  late final Computed<Failure?> failure = Computed(() {
    return isRejected.value
        ? handleError(
            future.error,
            defaultFailure: defaultFailure,
          )
        : null;
  });

  Future<T?> execute({required Future<T> Function() request}) async {
    try {
      runInAction(() {
        status.value = FutureStatus.pending;
        future = ObservableFuture(request());
      });
      log('** isPending=${isPending.value}');

      final response = await future;
      runInAction(() => status.value = FutureStatus.fulfilled);
      log('** isFulfilled=${isFulfilled.value}');

      return response;
    } catch (e) {
      runInAction(() => status.value = FutureStatus.rejected);
      log('** isRejected=${isRejected.value}');
      return null;
    }
  }
}
