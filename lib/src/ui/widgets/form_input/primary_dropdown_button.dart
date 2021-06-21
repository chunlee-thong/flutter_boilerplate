import 'package:flutter/material.dart';
import 'package:flutter_boiler_plate/src/utils/form_validator.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../../constant/style_decoration.dart';

class PrimaryDropDownButton<T> extends StatelessWidget {
  final List<T> options;
  final T? value;
  final void Function(T?) onChanged;
  final String? label;
  final String? hint;
  final String? Function(T?)? validator;
  final bool isRequired;
  final double marginBottom;
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
          DropdownButtonFormField<T>(
            elevation: 1,
            value: value,
            hint: hint != null ? Text(hint!) : null,
            validator: isRequired
                ? (_value) {
                    if (validator != null) return validator?.call(_value);
                    return FormValidator.validateValue(
                      _value,
                      field: label ?? hint ?? "",
                    );
                  }
                : null,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
            items: options
                .map(
                  (option) => DropdownMenuItem<T>(
                    child: Text(option.toString()),
                    value: option,
                  ),
                )
                .toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
