import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/views/theme.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({required this.payLoad, Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
  final String payLoad;
}

class _NotificationScreenState extends State<NotificationScreen> {
  String _payLoad = '';
  @override
  void initState() {
    _payLoad = widget.payLoad;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          _payLoad.split('|')[0],
          style: TextStyle(
            color: Get.isDarkMode ? Colors.white : darkGreyClr,
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Column(
              children: [
                Text(
                  'Hello Hassan',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    color: Get.isDarkMode ? Colors.white : darkGreyClr,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'You Have new Reminder',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Get.isDarkMode ? Colors.green[100] : darkGreyClr,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
                child: Container(
              padding: const EdgeInsets.only(left: 30, right: 30),
              margin: const EdgeInsets.only(left: 30, right: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: primaryClr,
              ),
            )),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
