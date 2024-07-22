// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class textField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  const textField(
      {super.key,
      required this.label,
      required this.hint,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        labelText: label,
        hintText: hint,
      ),
    );
  }
}
