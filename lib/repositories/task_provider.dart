import 'package:flutter/cupertino.dart';
import 'package:isar_community/isar.dart';
import 'package:todo/collections/Task.dart';


// tasks === collection<Task>()
class TaskProvider extends ChangeNotifier {

  final Isar isar;
  List<Task> taskList = [];
  int get count => taskList.length;
  int get completedCount => taskList.where( (task) => task.isChecked ).length;

  TaskProvider(this.isar) {
    isar.tasks.watchLazy().listen( (_) {
      fetchAllTasks();
    });
    fetchAllTasks();
  }

  Future<void> fetchAllTasks() async {
    taskList = await isar.tasks.where().findAll();
    notifyListeners();
  }


  Future<void> addAndUpdateTask(Task newTask) async {
    await isar.writeTxn(() async {
      await isar.tasks.put(newTask);
    });
    await fetchAllTasks();
  }

  Future<void> deleteTask(Task task) async {
    await isar.writeTxn(() async {
      await isar.tasks.delete(task.id);
    });
    await fetchAllTasks();
  }

}