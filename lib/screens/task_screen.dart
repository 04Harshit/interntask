import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:interntask/consts.dart';
import 'package:interntask/networking/api_call.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/todo.dart';
import '../widgets/task_section.dart';
import 'add_task_screen.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Todo> todos = [];
  final apiCall = ApiCall();
  bool _dataLoaded = false;
  bool hideCompleted = false;

  Future<void> getTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('id');

    Map<String, dynamic> response = await apiCall.getCall("todos/user/$userId");
    if (response["statusCode"] == 200) {
      TodoResponse toDoData =
          TodoResponse.fromJson(jsonDecode(response["result"]));

      setState(() {
        todos = toDoData.todos ?? [];
        _dataLoaded = true;
      });
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
  }

  @override
  void initState() {
    getTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0x00000000),
        elevation: 0,
        leading: const Icon(null),
        actions: [
          // Logout/ Circle Avatar
          GestureDetector(
            onTap: () {
              logout();
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
            child: const CircleAvatar(
              radius: 42,
              backgroundImage: AssetImage("assets/pfp.jpg"),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _dataLoaded
            ? ListView(
                children: <Widget>[
                  // Today's Task Section
                  TaskSection(
                    reload: (done) {
                      getTodos();
                    },
                    title: 'Today',
                    isToday: true,
                    todos: todos,
                    hideCompleted: hideCompleted,
                    trailing: TextButton(
                      onPressed: () {
                        setState(() {
                          // Toggle Button
                          hideCompleted = !hideCompleted;
                        });
                      },
                      child: hideCompleted
                          ? const Text('Show All', style: kHideButton)
                          : const Text('Hide Completed', style: kHideButton),
                    ),
                  ),

                  // Tomorrow
                  TaskSection(title: 'Tomorrow', todos: todos),
                ],
              )

            // Loading Screen while fetching data from Api
            : const Center(
                child: CircularProgressIndicator(
                color: Colors.black,
              )),
      ),

      // Custom FAB Button
      // Click to add a task
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return const AddTaskScreen();
            },
          ).then((value) {
            setState(() {
              _dataLoaded = false;
            });
            getTodos();
          });
        },
        child: const Icon(Icons.add, size: 36),
      ),
    );
  }
}
