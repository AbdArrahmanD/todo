import 'package:get/get.dart';
import 'package:todo/db/db_helper.dart';
import 'package:todo/models/task.dart';

class TaskController extends GetxController {
  RxList<Task> taskList = <Task>[].obs;
  Future<int> addTask({Task? task}) {
    return DBHelper.insert(task);
  }

  Future<void> getTask() async {
    final List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((e) => Task.fromJson(e)).toList());
  }

  void deleteTasks(Task task) async {
    await DBHelper.delete(task);
    getTask();
  }

  void markTaskAsCompleted(int id) async {
    await DBHelper.update(id);
    getTask();
  }
}
