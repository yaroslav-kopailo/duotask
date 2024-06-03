import 'package:diffutil_dart/diffutil.dart' as diffutil;

class ListDiff<T> extends diffutil.ListDiffDelegate<T> {
  ListDiff(super.oldList, super.newList);

  @override
  bool areContentsTheSame(int oldItemPosition, int newItemPosition) =>
      equalityChecker(oldList[oldItemPosition], newList[newItemPosition]);

  @override
  bool areItemsTheSame(int oldItemPosition, int newItemPosition) =>
      oldList[oldItemPosition] == newList[newItemPosition];
}
