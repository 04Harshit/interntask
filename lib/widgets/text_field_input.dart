import 'package:flutter/material.dart';
import 'package:interntask/consts.dart';

class TextFieldInput extends StatefulWidget {
  final TextEditingController textEditingController;
  final TextInputType textInputType; 
  bool isPass; // isPassword?
  final bool showIcon; 
  final String hintText;

  TextFieldInput({
    Key? key,
    required this.textEditingController,
    required this.textInputType,
    this.isPass = false,
    required this.hintText,
    this.showIcon = false,
  }) : super(key: key);

  @override
  _TextFieldInputState createState() => _TextFieldInputState();
}

class _TextFieldInputState extends State<TextFieldInput> {
  @override
  Widget build(BuildContext context) {
    // Used for cursor position display
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));

    return TextField(
      controller: widget.textEditingController,
      style: kTextFieldInput,
      decoration: InputDecoration(
        fillColor: const Color(0xFFE3E5E8),
        hintText: widget.hintText,
        hintStyle: kTextFieldHint,

        // If Password then show visibiliy icon
        // Handling text obscuring accordingly 
        suffixIcon: (widget.showIcon)
            ? IconButton(
                onPressed: () {
                  setState(() {
                    widget.isPass = !widget.isPass;
                  });
                },

                // Icon Toggling
                icon: Icon(
                  widget.isPass ? Icons.visibility : Icons.visibility_off,
                  color: const Color(0xFF50555F),
                ),
              )
            : const Icon(null),
            
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(12),
      ),
      keyboardType: widget.textInputType,
      obscureText: widget.isPass,
    );
  }
}