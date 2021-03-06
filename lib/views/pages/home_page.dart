import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../controllers/task_controller.dart';
import '../../models/task.dart';
import '../../services/notification_services.dart';
import '../../services/theme_services.dart';
import '../size_config.dart';
import '../theme.dart';
import '../widgets/button.dart';
import '../widgets/task_tile.dart';
import 'add_task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late NotifyHelper notifyHelper;
  TaskController taskController = Get.put(TaskController());

  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
    taskController.getTask();
    debugPrint('initState');
  }

  DateTime selectedDate = DateTime.now();
  final TaskController _taskController = Get.put(TaskController());
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: appBar(),
      body: Column(
        children: [
          Container(),
          taskBar(),
          addDateBar(),
          showTasks(),
        ],
      ),
    );
  }

  AppBar appBar() => AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.cleaning_services_outlined,
              color: Get.isDarkMode ? Colors.white : Colors.black,
              size: 24,
            ),
            onPressed: () {
              taskController.deleteAllTasks();
              notifyHelper.cancelAllNotification();
            },
          ),
          const CircleAvatar(
            backgroundImage: AssetImage(
              'assets/images/person.jpeg',
            ),
            radius: 18,
          ),
          const SizedBox(width: 20),
        ],
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        leading: IconButton(
          icon: Icon(
            Get.isDarkMode
                ? Icons.wb_sunny_outlined
                : Icons.nightlight_outlined,
            color: Get.isDarkMode ? Colors.white : Colors.black,
            size: 24,
          ),
          onPressed: () {
            ThemeServices().switchThemeMode();
            // notifyHelper.displayNotification(
            //     title: 'To Do', body: 'Theme Switched');
            // notifyHelper.schedulerNotification();
          },
        ),
      );

  taskBar() {
    return Container(
      margin: const EdgeInsets.only(
        left: 20,
        right: 10,
        top: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: subHeadingStyle,
              ),
              Text(
                'Today',
                style: headingStyle,
              ),
            ],
          ),
          MyButton(
              label: '+ Add Task',
              onTap: () async {
                await Get.to(() => const AddTaskPage());
                taskController.getTask();
              }),
        ],
      ),
    );
  }

  addDateBar() {
    return Container(
      margin: const EdgeInsets.only(
        left: 20,
        right: 10,
        top: 10,
      ),
      child: DatePicker(
        DateTime.now(),
        width: 70,
        height: 100,
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        onDateChange: (newDate) {
          setState(() {
            selectedDate = newDate;
          });
        },
        initialSelectedDate: DateTime.now(),
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Future<void> onRefresh() async {
    await taskController.getTask();
  }

  Expanded showTasks() => Expanded(
        child: Obx(
          () {
            if (taskController.taskList.isEmpty)
              return noTaskMsg();
            else
              return RefreshIndicator(
                onRefresh: onRefresh,
                child: ListView.builder(
                  scrollDirection:
                      SizeConfig.orientation == Orientation.landscape
                          ? Axis.horizontal
                          : Axis.vertical,
                  itemBuilder: (context, index) {
                    Task task = _taskController.taskList[index];
                    var hour = task.startTime.toString().split(':')[0];
                    var minutes = task.startTime.toString().split(':')[1];

                    debugPrint('My Time is : ' + hour);
                    debugPrint('My Minutes is : ' + minutes);

                    var date = DateFormat.jm().parse(task.startTime!);
                    var myTime = DateFormat('HH:mm').format(date);

                    notifyHelper.scheduledNotification(
                      int.parse(myTime.split(':')[0]),
                      int.parse(myTime.split(':')[1]),
                      task,
                    );
                    if (task.repeat == 'Daily' ||
                        task.date == DateFormat.yMd().format(selectedDate) ||
                        (task.repeat == 'Weekly' &&
                            selectedDate
                                        .difference(
                                            DateFormat.yMd().parse(task.date!))
                                        .inDays %
                                    7 ==
                                0) ||
                        (task.repeat == 'Monthly' &&
                            selectedDate.day ==
                                DateFormat.yMd().parse(task.date!).day)) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 300),
                        child: SlideAnimation(
                          horizontalOffset: 300,
                          child: FadeInAnimation(
                            child: GestureDetector(
                              onTap: () => showBottomSheet(context, task),
                              child: TaskTile(
                                task,
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                  itemCount: _taskController.taskList.length,
                ),
              );
          },
        ),
      );

  Stack noTaskMsg() => Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            child: RefreshIndicator(
              onRefresh: onRefresh,
              child: SingleChildScrollView(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  direction: SizeConfig.orientation == Orientation.portrait
                      ? Axis.vertical
                      : Axis.horizontal,
                  children: [
                    SizeConfig.orientation == Orientation.landscape
                        ? const SizedBox(height: 6)
                        : const SizedBox(height: 220),
                    SvgPicture.asset(
                      'assets/images/task.svg',
                      height: 90,
                      semanticsLabel: 'Task',
                      color: primaryClr.withOpacity(0.5),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: Text(
                        'You Don\'t Have Any Task Yet!\nAdd new Task to make your day Productive',
                        style: subTitleStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizeConfig.orientation == Orientation.landscape
                        ? const SizedBox(height: 120)
                        : const SizedBox(height: 180),
                  ],
                ),
              ),
            ),
          ),
        ],
      );

  showBottomSheet(BuildContext context, Task task) =>
      Get.bottomSheet(SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 4),
          width: SizeConfig.screenWidth,
          height: SizeConfig.orientation == Orientation.landscape
              ? task.isCompleted == 1
                  ? SizeConfig.screenHeight * 0.6
                  : SizeConfig.screenHeight * 0.8
              : task.isCompleted == 1
                  ? SizeConfig.screenHeight * 0.3
                  : SizeConfig.screenHeight * 0.39,
          color: Get.isDarkMode ? darkHeaderClr : Colors.white,
          child: Column(
            children: [
              Flexible(
                child: Container(
                  height: 6,
                  width: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                          Get.isDarkMode ? Colors.grey[600] : Colors.grey[300]),
                ),
              ),
              const SizedBox(height: 20),
              task.isCompleted == 1
                  ? Container()
                  : _buildBottomSheet(
                      label: 'Completed',
                      onTap: () {
                        Get.back();
                      },
                      color: primaryClr),
              _buildBottomSheet(
                  label: 'Delete',
                  onTap: () {
                    NotifyHelper().cancelNotification(task);
                    taskController.deleteTasks(task);
                    Get.back();
                  },
                  color: Colors.red[300]!),
              Divider(
                color: Get.isDarkMode ? Colors.grey : darkGreyClr,
              ),
              _buildBottomSheet(
                  label: 'Cancel',
                  onTap: () {
                    Get.back();
                  },
                  color: primaryClr),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ));

  _buildBottomSheet({
    required String label,
    required Function() onTap,
    required Color color,
    bool isClosed = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 65,
        width: SizeConfig.screenWidth * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
              width: 2,
              color: isClosed
                  ? Get.isDarkMode
                      ? Colors.grey[600]!
                      : Colors.grey[300]!
                  : color),
          borderRadius: BorderRadius.circular(20),
          color: isClosed ? Colors.transparent : color,
        ),
        child: Center(
          child: Text(
            label,
            style: isClosed
                ? titleStyle
                : titleStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
