import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../constant/style_decoration.dart';
import '../../utils/form_validator.dart';

class PrimaryTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final double marginBottom;
  final TextInputType textInputType;
  final TextCapitalization textCapitalization;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final bool isRequired;
  final bool obsecure;
  final List<TextInputFormatter>? inputFormatters;
  final bool? readOnly;
  final int maxLines;
  final String? label;
  final int? lengthValidator;
  final bool autoFocus;
  final int? maxLength;
  final bool autoCorrect;
  final FocusNode? focusNode;

  const PrimaryTextField({
    Key? key,
    required this.controller,
    this.hint = "",
    this.label,
    this.obsecure = false,
    this.isRequired = true,
    this.marginBottom = 16,
    this.textInputType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.maxLines = 1,
    this.autoFocus = false,
    this.autoCorrect = false,
    this.prefixIcon,
    this.validator,
    this.onTap,
    this.readOnly,
    this.lengthValidator,
    this.onChanged,
    this.inputFormatters,
    this.maxLength,
    this.suffixIcon,
    this.focusNode,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: marginBottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null) ...[
            Text("$label ${isRequired ? "*" : ""}", style: kTitleStyle.medium).paddingValue(horizontal: 4),
            SpaceY(),
          ],
          TextFormField(
            focusNode: focusNode,
            keyboardType: textInputType,
            textCapitalization: textCapitalization,
            controller: controller,
            maxLength: maxLength,
            inputFormatters: inputFormatters,
            autocorrect: autoCorrect,
            autofocus: autoFocus,
            maxLines: maxLines,
            onChanged: onChanged,
            readOnly: readOnly ?? onTap != null ? true : false,
            obscureText: obsecure,
            onTap: onTap,
            validator: isRequired
                ? (value) {
                    if (validator != null) return validator?.call(value);
                    return FormValidator.validateField(
                      value,
                      field: label ?? hint,
                      length: lengthValidator,
                    );
                  }
                : null,
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              //labelText: label,
            ),
          ),
        ],
      ),
    );
  }
}
