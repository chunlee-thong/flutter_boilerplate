import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../constant/style_decoration.dart';

class PrimaryDropDownButton<T> extends StatelessWidget {
  final List<T> options;
  final T value;
  final void Function(T) onChanged;
  final String label;
  const PrimaryDropDownButton({
    Key key,
    @required this.options,
    @required this.value,
    @required this.onChanged,
    this.label,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null) ...[
            Text(label, style: kTitleStyle.medium).paddingValue(horizontal: 4),
            SpaceY(),
          ],
          DropdownButtonFormField<T>(
            elevation: 1,
            value: value,
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
