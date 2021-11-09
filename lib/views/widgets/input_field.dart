import 'package:flutter/material.dart';
import 'package:todo/views/theme.dart';

import '../size_config.dart';
import 'package:get/get.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
  }) : super(key: key);

  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: titleStyle),
          Container(
            padding: const EdgeInsets.only(top: 8),
            margin: const EdgeInsets.only(left: 14),
            width: SizeConfig.screenWidth,
            height: 52,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey)),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                  autofocus: false,
                  controller: controller,
                  readOnly: widget != null ? true : false,
                  style: subTitleStyle,
                  cursorColor:
                      Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: subTitleStyle,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 0,
                        color: context.theme.backgroundColor,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 0,
                        color: context.theme.backgroundColor,
                      ),
                    ),
                  ),
                )),
                widget ?? Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
