import 'package:get/get.dart';
import 'package:todo/models/task.dart';

class TaskController extends GetxController {
  List taskList = <Task>[
    Task(
      title: 'Title 1',
      color: 0,
      note: 'Aliqua qui irure nulla ex tempor et Lorem aliquip.',
      startTime: '8:20',
      endTime: '9:20',
      isCompleted: 0,
    ),
    Task(
      title: 'Title 2',
      color: 1,
      note: 'Aliqua qui irure nulla ex tempor et Lorem aliquip.',
      startTime: '8:20',
      endTime: '9:20',
      isCompleted: 1,
    ),
    Task(
      title: 'Title 3',
      color: 2,
      note: 'Aliqua qui irure nulla ex tempor et Lorem aliquip.',
      startTime: '8:20',
      endTime: '9:20',
      isCompleted: 1,
    ),
    Task(
      title: 'Title 1',
      color: 1,
      note: 'Aliqua qui irure nulla ex tempor et Lorem aliquip.',
      startTime: '8:20',
      endTime: '9:20',
      isCompleted: 0,
    ),
  ];
  getTask() {}
}
