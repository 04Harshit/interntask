import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../consts.dart';
import '../models/todo.dart';
import '../networking/api_call.dart';
import '../utils/helpers.dart';
import 'todo_tile.dart';

class TaskSection extends StatefulWidget {
  final String title;
  Widget trailing;
  final List<Todo> todos;
  bool isToday;
  bool hideCompleted;
  Function(bool?)? reload;

  TaskSection({
    super.key,
    required this.title,
    this.trailing = const SizedBox(),
    this.isToday = false,
    required this.todos,
    this.hideCompleted = false,
    this.reload,
  });

  @override
  State<TaskSection> createState() => _TaskSectionState();
}

class _TaskSectionState extends State<TaskSection> {
  final apiCall = ApiCall();

  Future<void> updateTask(BuildContext context, bool completed) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('id')!;

    String payload = jsonEncode({
      'completed': completed,
    });

    //api call to add task in db
    Map<String, dynamic> response =
        await apiCall.putCall("todos/$userId", payload);

    if (response["statusCode"] == 200) {
      //if task updated successfully, then reload task Screen
      widget.reload!(true);
    } else {
      //If error in updating task, show error
      String message = response["error"];
      Helper().showSnackBar(context, message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // Section Title
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: kTaskHeading,
          ),
          widget.trailing
        ],
      ),

      // Task Data which is fetched from the Api
      const SizedBox(height: 20),
      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.todos.length,
        itemBuilder: (BuildContext context, int index) {
          return (widget.hideCompleted && widget.todos[index].completed!)
              ? Container()
              : ToDoTile(
                  isToday: widget.isToday,
                  title: widget.todos[index].todo ?? "",
                  taskCompletionCall: (done) {
                    setState(() {
                      widget.todos[index].completed =
                          !widget.todos[index].completed!;
                    });
                    updateTask(context, widget.todos[index].completed!);
                  },
                  isCompleted: widget.todos[index].completed ?? false,
                );
        },
      ),

      // Partition Between Sections
      const SizedBox(height: 20),
    ]);
  }
}
