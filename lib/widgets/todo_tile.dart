import 'package:flutter/material.dart';
import 'package:interntask/consts.dart';

class ToDoTile extends StatefulWidget {
  final String title;
  final bool isCompleted;
  final bool isToday;
  final Function(bool?) taskCompletionCall;
  const ToDoTile(
      {super.key,
      required this.title,
      required this.isCompleted,
      required this.isToday,
      required this.taskCompletionCall});

  @override
  State<ToDoTile> createState() => _ToDoTileState();
}

class _ToDoTileState extends State<ToDoTile> {
  @override
  Widget build(BuildContext context) {
    bool completed = widget.isCompleted;
    bool today = widget.isToday;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 0),
      visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
      leading: today
          ? completed
              ? Column(
                  children: [
                    const SizedBox(height: 12),
                    InkWell(
                      child: const Icon(Icons.check_box, color: Colors.black),
                      onTap: () {
                        widget.taskCompletionCall(true);
                      },
                    ),
                  ],
                )
              : Column(
                  children: [
                    const SizedBox(height: 12),
                    InkWell(
                      child: const Icon(Icons.check_box_outline_blank,
                          color: Color(0xFFE7E7E7)),
                      onTap: () {
                        widget.taskCompletionCall(true);
                      },
                    ),
                  ],
                )
          : const Column(
              children: [
                SizedBox(height: 20),
                Icon(Icons.circle, size: 10, color: Colors.black),
              ],
            ),
      title: (completed && today)
          ? Opacity(
              opacity: 0.3,
              child: Text(widget.title, style: kTaskTitleCompleted),
            )
          : Text(widget.title, style: kTaskTitle),
      subtitle: (completed && today)
          ? const Opacity(
              opacity: 0.3,
              child: Text('12:42 PM', style: kTaskTimeCompleted),
            )
          : const Text('12:42 PM', style: kTaskTime),
    );
  }
}
