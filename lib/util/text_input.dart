// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final TextEditingController Textcontroller;
  final TextInputType keyboardType;
  final bool obscureText;
  final hint;
  const TextInput(
      {Key? key,
      required this.hint,
      this.obscureText = false,
      required this.Textcontroller,
      required this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InputBorder = OutlineInputBorder(
        borderSide: Divider.createBorderSide(context, color: Colors.black,width: 2),
        borderRadius: BorderRadius.circular(75));
    return TextField(
      controller: Textcontroller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        border: InputBorder,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.black),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.black),
        ),
        filled: true,
        contentPadding: EdgeInsets.all(16),
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
    );
  }
}
