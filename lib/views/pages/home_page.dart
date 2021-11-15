import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo/services/notification_services.dart';
import 'package:todo/services/theme_services.dart';
import 'package:todo/views/pages/add_task_page.dart';
import 'package:todo/views/theme.dart';
import '../size_config.dart';
import '../widgets/button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late NotifyHelper notifyHelper;

  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializationNotification();
    notifyHelper.requestIOSPermission();
  }

  DateTime selectedDate = DateTime.now();
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
          icon: Icon(
            Get.isDarkMode
                ? Icons.wb_sunny_outlined
                : Icons.nightlight_outlined,
            color: Get.isDarkMode ? Colors.white : Colors.black,
            size: 24,
          ),
          onPressed: () {
            ThemeServices().switchThemeMode();
            notifyHelper.displayNotification(
                title: 'To Do', body: 'Theme Switched');
            notifyHelper.schedulerNotification();
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
                //taskController.getTasks()
                ThemeServices().switchThemeMode();
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

  Expanded showTasks() => Expanded(child: noTaskMsg());

  noTaskMsg() => Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
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
        ],
      );
}
