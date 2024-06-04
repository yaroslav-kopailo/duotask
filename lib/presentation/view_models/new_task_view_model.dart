import 'package:duotask/core/helper/string_ext.dart';
import 'package:mobx/mobx.dart';

class NewTaskViewModel {
  final DateTime minStartDateTime =
      DateTime.now().subtract(const Duration(days: 7));

  final Observable<String> taskName = Observable('');

  late final Computed<bool> isTaskNameFieldValid =
      Computed(() => taskName.value.isValidTaskNameLength);

  final Observable<String?> taskNameFailedText = Observable(null);

  final Observable<bool> isTaskNameFailed = Observable(false);

  final Observable<DateTime> startDateTime = Observable(DateTime.now());

  final Observable<DateTime> endDateTime = Observable(
    DateTime.now().add(const Duration(hours: 3)),
  );

  void setTaskName(String value) {
    runInAction(() {
      taskName.value = value.trim();
      if (isTaskNameFieldValid.value) {
        isTaskNameFailed.value = false;
        taskNameFailedText.value = null;
      }
    });
  }

  void setStartDateTime(DateTime newDateTime) {
    runInAction(() {
      startDateTime.value = newDateTime;
      if (startDateTime.value.isAfter(endDateTime.value)) {
        endDateTime.value = startDateTime.value.add(const Duration(hours: 3));
      }
    });
  }

  void setEndDateTime(DateTime newDateTime) {
    runInAction(() {
      endDateTime.value = newDateTime;
      if (startDateTime.value.isAfter(endDateTime.value)) {
        startDateTime.value =
            endDateTime.value.subtract(const Duration(hours: 3));
      }
    });
  }
}
