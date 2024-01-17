import 'package:flutter/material.dart';
import '../consts.dart';

class ActionButton extends StatelessWidget {
  final void Function()? onPressed;
  final Color colour;
  final String label;

  const ActionButton(
      {super.key,
      required this.colour,
      required this.label,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 40,
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        width: double.infinity,
        decoration: ShapeDecoration(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(3),
            ),
          ),
          color: colour,
        ),
        child: Text(label, style: kButtonText),
      ),
    );
  }
}
