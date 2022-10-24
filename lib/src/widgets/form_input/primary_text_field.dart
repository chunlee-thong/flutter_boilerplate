import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skadi/skadi.dart';

import '../../core/style/dimension.dart';
import '../../core/style/textstyle.dart';
import '../../core/utilities/form_validator.dart';

class PrimaryTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final String? label;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final double? marginBottom;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final bool isRequired;
  final bool obscure;
  final List<TextInputFormatter>? inputFormatters;
  final bool? readOnly;
  final int maxLines;
  final int? lengthValidator;
  final bool autoFocus;
  final int? maxLength;
  final bool autoCorrect;
  final FocusNode? focusNode;
  final bool enabled;
  final bool _isPassword;
  final ValueNotifier<bool>? obscureNotifier;

  const PrimaryTextField({
    Key? key,
    required this.controller,
    this.hint,
    this.label,
    this.obscure = false,
    this.isRequired = true,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.maxLines = 1,
    this.autoFocus = false,
    this.autoCorrect = false,
    this.enabled = true,
    this.prefixIcon,
    this.marginBottom,
    this.validator,
    this.onTap,
    this.readOnly,
    this.lengthValidator,
    this.onChanged,
    this.inputFormatters,
    this.maxLength,
    this.suffixIcon,
    this.focusNode,
    this.obscureNotifier,
  })  : assert(hint != null || label != null),
        _isPassword = false,
        super(key: key);

  const PrimaryTextField.password({
    Key? key,
    required this.controller,
    required this.obscureNotifier,
    this.hint,
    this.label,
    this.obscure = true,
    this.isRequired = true,
    this.keyboardType = TextInputType.visiblePassword,
    this.textCapitalization = TextCapitalization.none,
    this.maxLines = 1,
    this.autoFocus = false,
    this.autoCorrect = false,
    this.enabled = true,
    this.marginBottom,
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
  })  : assert(hint != null || label != null),
        _isPassword = true,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: marginBottom ?? AppDimension.space16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null) ...[
            Text(
              "$label ${isRequired ? "*" : ""}",
              style: kSubtitleStyle.responsiveFontSize,
            ).paddingValue(horizontal: 4),
            const SpaceY(),
          ],
          TextFormField(
            focusNode: focusNode,
            keyboardType: keyboardType,
            textCapitalization: textCapitalization,
            controller: controller,
            maxLength: maxLength,
            inputFormatters: inputFormatters,
            autocorrect: autoCorrect,
            autofocus: autoFocus,
            maxLines: maxLines,
            onChanged: onChanged,
            enabled: enabled,
            readOnly: readOnly ?? onTap != null ? true : false,
            obscureText: obscure,
            onTap: onTap,
            validator: isRequired
                ? (value) {
                    if (validator != null) return validator?.call(value);
                    return FormValidator.validateField(
                      value,
                      field: label ?? hint ?? "",
                      length: lengthValidator,
                    );
                  }
                : null,
            decoration: InputDecoration(
              hintText: hint,
              prefixIcon: prefixIcon,
              contentPadding: EdgeInsets.all(SkadiResponsive.value(16, 20, 24)),
              suffixIcon: _isPassword
                  ? SkadiIconButton(
                      onTap: () {
                        obscureNotifier?.value = !obscureNotifier!.value;
                      },
                      icon: Icon(obscure ? Icons.visibility : Icons.visibility_off),
                      padding: const EdgeInsets.all(12),
                    )
                  : suffixIcon,
            ),
          ),
        ],
      ),
    );
  }
}
