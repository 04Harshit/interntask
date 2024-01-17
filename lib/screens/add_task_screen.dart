import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../consts.dart';
import '../networking/api_call.dart';
import '../utils/helpers.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _taskTitleController = TextEditingController();
  final apiCall = ApiCall();
  DateTime _dateTime = DateTime.now();
  bool today = true;

  Future<void> addTask(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //checking if user entered task title
    if (_taskTitleController.text.isNotEmpty) {
      String payload = jsonEncode({
        'todo': _taskTitleController.text,
        'completed': false,
        'userId': prefs.getInt('id')
      });

      //api call to add task in db
      Map<String, dynamic> response =
          await apiCall.postCall("todos/add", payload);

      if (response["statusCode"] == 200) {
        //if task added successfully, show all tasks
        Navigator.pop(context, true);
      } else {
        //If error in adding task, show error
        String message = response["error"];
        Helper().showSnackBar(context, message);
      }
    } else {
      Helper().showSnackBar(context, 'Task Title is Empty!');
    }
  }

  @override
  void dispose() {
    super.dispose();
    _taskTitleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF757575),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.90,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Close Button and Title
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 10.0),

                    // Close Button
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF007AFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                      onPressed: () => {Navigator.pop(context)},
                      icon: const Icon(Icons.arrow_back_ios),
                      label: const Text(
                        'Close',
                        style: kCloseButton,
                      ),
                    ),
                  ),

                  // Task Label
                  const Column(
                    children: [
                      SizedBox(height: 20),
                      Text('Task', style: kAddTaskLabel),
                    ],
                  ),
                  Container(width: 105),
                ],
              ),
              const Divider(thickness: 1),

              Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
                      child: const Text('Add a task', style: kTaskHeading),
                    ),

                    // Name of the task
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: [
                          const Text('Name', style: kTaskParams),
                          const SizedBox(width: 20),
                          Flexible(
                            child: TextField(
                              controller: _taskTitleController,
                              decoration: const InputDecoration(
                                enabledBorder: underlinedBorder,
                                disabledBorder: underlinedBorder,
                                focusedBorder: underlinedBorder,
                                hintText: 'Lorem ipsum dolor',
                                hintStyle: kTaskDescHint,
                                contentPadding: EdgeInsets.all(4),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    // Time of the task
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: [
                          const Text('Hour', style: kTaskParams),
                          const SizedBox(width: 18),
                          ClipRect(
                            child: SizedBox(
                              height: 60,
                              width: 180,

                              // Time Picker (Scrollable)
                              child: CupertinoDatePicker(
                                initialDateTime: _dateTime,
                                onDateTimeChanged: (dateTime) {
                                  setState(() {
                                    _dateTime = dateTime;
                                  });
                                },
                                use24hFormat: false,
                                mode: CupertinoDatePickerMode.time,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),

                    // Today or Tomorrow
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Today', style: kTaskParams),

                          //Sliding Switch
                          Switch.adaptive(
                            // Don't use the ambient CupertinoThemeData to style this switch.
                            applyCupertinoTheme: false,
                            value: today,
                            onChanged: (bool value) {
                              setState(() {
                                today = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    // Done Button
                    const SizedBox(height: 40),
                    InkWell(
                      onTap: () {
                        addTask(context);
                        // add todo task
                      },
                      child: Container(
                        height: 48,
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        width: double.infinity,
                        decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          color: Color(0xFF171717),
                        ),
                        child: const Text('Done', style: kAddButtonText),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'If you disable today, the task will be considered as tomorrow',
                      style: kTipText,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}