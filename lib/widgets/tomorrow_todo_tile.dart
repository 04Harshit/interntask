import 'package:flutter/material.dart';

class TomorrowToDoTile extends StatelessWidget {
  final String title;
  const TomorrowToDoTile({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(children: [
        const Icon(
          Icons.circle,
          color: Colors.black,
          size: 12,
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(title), SizedBox(height: 10), Text("10:00 AM")],
        )
      ]),
    );
  }
}