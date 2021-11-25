import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/models/task.dart';

class TaskController extends GetxController {
  List taskList = <Task>[
    Task(
      id: 0,
      title: 'Title 1',
      color: 0,
      note: 'Aliqua qui irure nulla ex tempor et Lorem aliquip.',
      startTime: DateFormat('hh:mm a').format(
        DateTime.now().add(
          const Duration(minutes: 1),
        ),
      ),
      endTime: '9:20',
      isCompleted: 0,
    ),
    Task(
      id: 0,
      title: 'Title 2',
      color: 1,
      note: 'Aliqua qui irure nulla ex tempor et Lorem aliquip.',
      startTime: DateFormat('hh:mm a').format(
        DateTime.now().add(
          const Duration(minutes: 1),
        ),
      ),
      endTime: '9:20',
      isCompleted: 1,
    ),
    Task(
      id: 0,
      title: 'Title 3',
      color: 2,
      note: 'Aliqua qui irure nulla ex tempor et Lorem aliquip.',
      startTime: DateFormat('hh:mm a').format(
        DateTime.now().add(
          const Duration(minutes: 1),
        ),
      ),
      endTime: '9:20',
      isCompleted: 1,
    ),
    Task(
      id: 0,
      title: 'Title 1',
      color: 1,
      note: 'Aliqua qui irure nulla ex tempor et Lorem aliquip.',
      startTime: DateFormat('hh:mm a').format(
        DateTime.now().add(
          const Duration(minutes: 1),
        ),
      ),
      endTime: '9:20',
      isCompleted: 0,
    ),
  ];
  addTask({Task? task}) {}
  getTask() {}
}
