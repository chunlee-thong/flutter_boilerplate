import 'package:flutter/material.dart';

class SimpleTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final Widget prefixIcon;
  final String Function(String) validator;
  final bool obsecure;

  const SimpleTextField({
    Key key,
    this.controller,
    this.hint = "",
    this.prefixIcon,
    this.validator,
    this.obsecure = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        obscureText: obsecure,
        validator: validator,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(),
          prefixIcon: prefixIcon,
        ),
      ),
    );
  }
}
