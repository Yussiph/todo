import 'package:isar_community/isar.dart';

part 'Task.g.dart';

@collection
class Task {

  Id id = Isar.autoIncrement;

  // This will be useful when searching later since Isar is case sensitive.
  // That is if I added search :)
  // @Index(caseSensitive: false)
  String? todo;

  bool? isChecked;
}
