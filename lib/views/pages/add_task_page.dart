import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/models/task.dart';
import 'package:todo/views/widgets/button.dart';

import '../../controllers/task_controller.dart';
import '../size_config.dart';
import '../theme.dart';
import '../widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController taskController = Get.put(TaskController());
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  String startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();
  int selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String selectedRepeat = 'None';
  List<String> repeatList = ['None', 'Daily', 'Weekly', 'Monthly'];
  int selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: appBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Add New Task',
                style: headingStyle,
              ),
              InputField(
                title: 'Title',
                hint: 'Add Title Here',
                controller: titleController,
              ),
              InputField(
                title: 'Note',
                hint: 'Add Note Here',
                controller: noteController,
              ),
              InputField(
                title: 'Date',
                hint: DateFormat.yMd().format(selectedDate),
                widget: IconButton(
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {},
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: 'Start Time',
                      hint: startTime,
                      widget: IconButton(
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: InputField(
                      title: 'EndTime Time',
                      hint: endTime,
                      widget: IconButton(
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
              InputField(
                  title: 'Remind',
                  hint: '$selectedRemind min early',
                  widget: Row(
                    children: [
                      DropdownButton(
                        dropdownColor: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10),
                        items: remindList
                            .map<DropdownMenuItem<String>>(
                              (int e) => DropdownMenuItem<String>(
                                value: e.toString(),
                                child: Text(
                                  e.toString(),
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                            .toList(),
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                        iconSize: 32,
                        elevation: 4,
                        underline: Container(height: 0),
                        style: subTitleStyle,
                        onChanged: (String? newVal) {
                          setState(() {
                            selectedRemind = int.parse(newVal!);
                          });
                        },
                      ),
                      const SizedBox(
                        width: 6,
                      )
                    ],
                  )),
              InputField(
                  title: 'Repeat',
                  hint: selectedRepeat,
                  widget: Row(
                    children: [
                      DropdownButton(
                        dropdownColor: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10),
                        items: repeatList
                            .map<DropdownMenuItem<String>>(
                              (String e) => DropdownMenuItem<String>(
                                value: e,
                                child: Text(
                                  e,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                            .toList(),
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                        iconSize: 32,
                        elevation: 4,
                        underline: Container(height: 0),
                        style: subTitleStyle,
                        onChanged: (String? newVal) {
                          setState(() {
                            selectedRepeat = newVal!;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 6,
                      )
                    ],
                  )),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  colorPalette(),
                  MyButton(label: 'Create Task', onTap: () => validateData())
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  validateData() {
    if (titleController.text.isNotEmpty && noteController.text.isNotEmpty) {
      addTaskToDb();
      Get.back();
    } else if (titleController.text.isEmpty || noteController.text.isEmpty) {
      Get.snackbar('Field Required', '',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: white,
          colorText: pinkClr,
          icon: const Icon(
            Icons.warning_amber_rounded,
            color: Colors.red,
          ));
    } else {
      print('##########  Some Thing Went Wrong  #############');
    }
  }

  addTaskToDb() async {
    int? value = await taskController.addTask(
        task: Task(
      title: titleController.text,
      note: noteController.text,
      color: selectedColor,
      date: DateFormat.yMd().format(selectedDate),
      endTime: endTime,
      startTime: startTime,
      isCompleted: 0,
      remind: selectedRemind,
      repeat: selectedRepeat,
    ));
    print(value);
  }

  AppBar appBar() => AppBar(
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage(
              'assets/images/person.jpeg',
            ),
            radius: 18,
          ),
          SizedBox(width: 20),
        ],
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: primaryClr,
            size: 24,
          ),
          onPressed: () => Get.back(),
        ),
      );

  Column colorPalette() {
    return Column(
      children: [
        Text(
          'Color',
          style: titleStyle,
        ),
        const SizedBox(height: 8),
        Wrap(
          children: List.generate(
            3,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  selectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 16,
                  child: selectedColor == index
                      ? const Icon(
                          Icons.done,
                          size: 16,
                          color: Colors.white,
                        )
                      : null,
                  backgroundColor: index == 0
                      ? primaryClr
                      : index == 1
                          ? pinkClr
                          : orangeClr,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
