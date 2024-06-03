import 'package:diffutil_dart/diffutil.dart' as diffutil;
import 'package:mobx/mobx.dart';

class ExtendedObservableList<T> {
  ExtendedObservableList({
    List<T> defaultValue = const [],
    this.equalityChecker,
  }) {
    data = ObservableList.of(defaultValue);
    previousData = Observable(defaultValue);
  }

  final bool Function(T, T)? equalityChecker;

  late final ObservableList<T> data;

  late final Observable<List<T>> previousData;

  late final Computed<List<diffutil.DataDiffUpdate>> updates = Computed(() {
    final updatedList = data.toList();
    return diffutil
        .calculateListDiff(
          previousData.value,
          updatedList,
          equalityChecker: equalityChecker,
        )
        .getUpdatesWithData()
        .toList();
  });

  int get length => data.length;

  void resetToPrevious() {
    runInAction(() {
      data.clear();
      data.addAll(previousData.value);
    });
  }

  void set(Iterable<T> items) {
    runInAction(() {
      previousData.value = data.toList();
      data.clear();
      data.addAll(items);
    });
  }

  void addAll(Iterable<T> items) {
    runInAction(() {
      previousData.value = data.toList();
      data.addAll(items);
    });
  }

  void insertAll(int index, Iterable<T> items) {
    runInAction(() {
      previousData.value = data.toList();
      data.insertAll(index, items);
    });
  }

  void insert(int index, T item) {
    runInAction(() {
      previousData.value = data.toList();
      data.insert(index, item);
    });
  }

  void reorder(int oldIndex, int newIndex) {
    runInAction(() {
      previousData.value = data.toList();
      final item = data.removeAt(oldIndex);
      data.insert(newIndex, item);
    });
  }

  void add(T item) {
    runInAction(() {
      previousData.value = data.toList();
      data.add(item);
    });
  }

  void remove(T item) {
    runInAction(() {
      previousData.value = data.toList();
      data.remove(item);
    });
  }

  void removeAt(int index) {
    runInAction(() {
      previousData.value = data.toList();
      data.removeAt(index);
    });
  }

  void clear() {
    runInAction(() {
      previousData.value = data.toList();
      data.clear();
    });
  }
}
