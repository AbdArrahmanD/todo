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
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: primaryClr,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.format_color_text_rounded,
                            size: 30,
                            color: Colors.white,
                          ),
                          SizedBox(width: 20),
                          Text(
                            'Title',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        _payLoad.split('|')[0],
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: const [
                          Icon(
                            Icons.description,
                            size: 30,
                            color: Colors.white,
                          ),
                          SizedBox(width: 20),
                          Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        _payLoad.split('|')[1],
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: const [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 30,
                            color: Colors.white,
                          ),
                          SizedBox(width: 20),
                          Text(
                            'Date',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        _payLoad.split('|')[2],
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
