import 'package:isar_community/isar.dart';

part 'Task.g.dart';

@collection
class Task {
  Id id = Isar.autoIncrement;
  String? todo;
  bool? isChecked;
}
