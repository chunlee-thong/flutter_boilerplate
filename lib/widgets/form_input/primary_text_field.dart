import 'package:flutter/material.dart';

class PrimaryTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final Widget prefixIcon;
  final String Function(String) validator;
  final double marginBottom;
  final TextInputType textInputType;
  final TextCapitalization textCapitalization;
  final VoidCallback onTap;
  final bool isRequired;
  final bool obsecure;
  final bool readOnly;
  final int maxLines;
  final String label;

  const PrimaryTextField({
    Key key,
    this.controller,
    this.hint = "",
    this.prefixIcon,
    this.validator,
    this.obsecure = false,
    this.isRequired = true,
    this.marginBottom = 12,
    this.textInputType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.onTap,
    this.readOnly,
    this.maxLines = 1,
    this.label,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        keyboardType: textInputType,
        textCapitalization: textCapitalization,
        controller: controller,
        autocorrect: false,
        maxLines: maxLines,
        readOnly: readOnly ?? onTap != null ? true : false,
        obscureText: obsecure,
        onTap: onTap,
        validator: isRequired ? validator : null,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(),
          prefixIcon: prefixIcon,
          labelText: label,
        ),
      ),
    );
  }
}
