import 'package:isar_community/isar.dart';
import 'package:todo/collections/Task.dart';
import 'package:todo/services/isar_setup.dart';


// tasks === collection<Task>()
class TaskRepository {

  Future<void> addAndUpdateTask(Task newTask) async {
    isar.writeTxn( () async {
      await isar.tasks.put(newTask);
    });
  }

  Future<void> deleteTask(Task task) async {
    isar.writeTxn(() async {
      await isar.tasks.delete(task.id);
    });
  }
}

Future<String> getTaskCount() async {
  return await isar.tasks.count() as String;
}

Future<String> getCompletedTasksCount() async {
  return await isar.tasks.where().isCheckedProperty().count() as String;
}