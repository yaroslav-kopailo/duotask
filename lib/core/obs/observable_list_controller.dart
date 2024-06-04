import 'dart:developer';

import 'package:duotask/core/error/failures.dart';
import 'package:duotask/core/obs/extended_observable_list.dart';
import 'package:duotask/core/obs/observable_request.dart';
import 'package:mobx/mobx.dart';

class ObservableListController<T> {
  ObservableListController({
    required List<T> defaultValue,
    this.equalityChecker,
    Failure? defaultSelListFailure,
    Failure? defaultUpdateItemFailure,
    Failure? defaultAddItemFailure,
    Failure? defaultDeleteItemFailure,
  }) {
    list = ExtendedObservableList<T>(
      equalityChecker: equalityChecker,
      defaultValue: defaultValue,
    );
    requestSetList = ObservableRequest<List<T>>(
      defaultValue: defaultValue,
      defaultFailure: defaultSelListFailure,
    );
    requestReorderItem = ObservableRequest<bool>(
      defaultValue: false,
      defaultFailure: defaultSelListFailure,
    );
    requestAddItem = ObservableRequest<bool>(
      defaultValue: false,
      defaultFailure: defaultSelListFailure,
    );
    requestRemoveItem = ObservableRequest<bool>(
      defaultValue: false,
      defaultFailure: defaultSelListFailure,
    );
  }

  late final bool Function(T, T)? equalityChecker;

  late final ExtendedObservableList<T> list;

  late final ObservableRequest<List<T>> requestSetList;

  late final ObservableRequest<bool> requestReorderItem;

  late final ObservableRequest<bool> requestAddItem;

  late final ObservableRequest<bool> requestRemoveItem;

  bool get isAnyPending =>
      requestSetList.isPending.value ||
      requestReorderItem.isPending.value ||
      requestAddItem.isPending.value ||
      requestRemoveItem.isPending.value;

  Future<void> executeSetList(
      {required Future<List<T>> Function() request}) async {
    if (isAnyPending) {
      return;
    }

    final response = await requestSetList.execute(request: request);

    log('** executeSetList() ==> response=$response');

    if (requestSetList.isFulfilled.value) {
      runInAction(() => list.set(response!));
    } //
    else {
      log(
        '** executeSetList() ==> REJECTED',
        error: requestSetList.failure.value,
      );
    }
  }

  Future<void> executeReorderItem({
    required Future<bool> Function() request,
    required int oldIndex,
    required int newIndex,
  }) async {
    if (isAnyPending) {
      return;
    }

    runInAction(() => list.reorder(oldIndex, newIndex));

    final response = await requestReorderItem.execute(request: request);

    log('** executeReorderItem() ==> response=$response');

    if (requestReorderItem.isRejected.value) {
      runInAction(() => list.resetToPrevious());
      log(
        '** executeReorderItem() ==> REJECTED',
        error: requestSetList.failure.value,
      );
    }
  }

  Future<void> executeAddItem({
    required Future<bool> Function() request,
    required T item,
  }) async {
    if (isAnyPending) {
      return;
    }

    runInAction(() => list.add(item));

    final response = await requestAddItem.execute(request: request);

    log('** executeAddItem() ==> response=$response');

    if (requestAddItem.isRejected.value) {
      runInAction(() => list.resetToPrevious());
      log(
        '** executeAddItem() ==> REJECTED',
        error: requestAddItem.failure.value,
      );
    }
  }

  Future<void> executeRemoveItem({
    required Future<bool> Function() request,
    required T item,
  }) async {
    if (isAnyPending) {
      return;
    }

    runInAction(() => list.remove(item));

    final response = await requestRemoveItem.execute(request: request);

    log('** executeRemoveItem() ==> response=$response');

    if (requestRemoveItem.isRejected.value) {
      runInAction(() => list.resetToPrevious());
      log(
        '** executeRemoveItem() ==> REJECTED',
        error: requestRemoveItem.failure.value,
      );
    }
  }
}
