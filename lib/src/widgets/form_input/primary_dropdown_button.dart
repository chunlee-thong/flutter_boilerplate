import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../constant/app_style_decoration.dart';
import '../../utils/form_validator.dart';

class PrimaryDropDownButton<T> extends StatelessWidget {
  final List<T> options;
  final T? value;
  final void Function(T?) onChanged;
  final String? label;
  final String? hint;
  final String? Function(T?)? validator;
  final bool isRequired;
  final double marginBottom;
  final bool enabled;

  const PrimaryDropDownButton({
    Key? key,
    required this.options,
    required this.value,
    required this.onChanged,
    this.label,
    this.hint,
    this.isRequired = true,
    this.validator,
    this.marginBottom = 16.0,
    this.enabled = true,
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
            const SpaceY(),
          ],
          DropdownButtonFormField<T>(
            elevation: 1,
            value: value,
            hint: hint != null ? Text(hint!) : null,
            validator: isRequired
                ? (value) {
                    if (validator != null) return validator?.call(value);
                    return FormValidator.validateValue(
                      value,
                      field: label ?? hint ?? "",
                    );
                  }
                : null,
            items: options
                .map(
                  (option) => DropdownMenuItem<T>(
                    value: option,
                    child: Text(option.toString()),
                  ),
                )
                .toList(),
            onChanged: enabled ? onChanged : null,
          ),
        ],
      ),
    );
  }
}
