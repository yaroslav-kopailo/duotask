import 'package:mobx/mobx.dart';

class Subtask {
  final String id;
  final String text;
  final Observable<bool> done;

  const Subtask({
    required this.id,
    required this.text,
    required this.done,
  });
}
