import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

import '../../constant/style_decoration.dart';
import '../../utils/form_validator.dart';

class PrimaryTypeAHeadTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final Widget prefixIcon;
  final String Function(String) validator;
  final void Function(String) onChanged;
  final double marginBottom;
  final TextInputType textInputType;
  final TextCapitalization textCapitalization;
  final VoidCallback onTap;
  final bool isRequired;
  final bool obsecure;
  final bool readOnly;
  final int maxLines;
  final String label;
  final int lengthValidator;
  final List<String> suggestions;

  const PrimaryTypeAHeadTextField({
    Key key,
    @required this.controller,
    this.hint = "",
    this.prefixIcon,
    this.validator,
    this.obsecure = false,
    this.isRequired = true,
    this.marginBottom = 16,
    this.textInputType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.onTap,
    this.readOnly,
    this.maxLines = 1,
    this.label,
    this.lengthValidator,
    this.onChanged,
    this.suggestions = const [],
  }) : super(key: key);
  @override
  _PrimaryTypeAHeadTextFieldState createState() =>
      _PrimaryTypeAHeadTextFieldState();
}

class _PrimaryTypeAHeadTextFieldState extends State<PrimaryTypeAHeadTextField> {
  final FocusNode focusNode = FocusNode();

  OverlayEntry overplayEntry;

  final LayerLink layerLink = LayerLink();

  List<String> suggestions;

  void nodeListener() {
    if (focusNode.hasFocus) {
      this.overplayEntry = this.createOverlayEntry();
      Overlay.of(context).insert(this.overplayEntry);
    } else {
      this.overplayEntry.remove();
    }
  }

  void onSelected(String suggestion) {
    widget.controller.text = suggestion;
    focusNode.unfocus();
  }

  @override
  void initState() {
    suggestions = widget.suggestions;
    focusNode.addListener(nodeListener);
    super.initState();
  }

  @override
  void dispose() {
    focusNode.removeListener(nodeListener);
    focusNode.dispose();
    super.dispose();
  }

  OverlayEntry createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: this.layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height - 16),
          child: Material(
            elevation: 4.0,
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: suggestions
                  .map((suggestion) => ListTile(
                        onTap: () => onSelected(suggestion),
                        title: Text(suggestion),
                      ))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: this.layerLink,
      child: Container(
        margin: EdgeInsets.only(bottom: widget.marginBottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.label != null) ...[
              Text("${widget.label} ${widget.isRequired ? "*" : ""}",
                      style: kTitleStyle.medium)
                  .paddingValue(horizontal: 4),
              SpaceY(),
            ],
            TextFormField(
              keyboardType: widget.textInputType,
              textCapitalization: widget.textCapitalization,
              controller: widget.controller,
              autocorrect: false,
              focusNode: focusNode,
              maxLines: widget.maxLines,
              onChanged: widget.onChanged,
              readOnly: widget.readOnly ?? widget.onTap != null ? true : false,
              obscureText: widget.obsecure,
              onTap: widget.onTap,
              validator: widget.isRequired
                  ? (value) {
                      if (widget.validator != null)
                        return widget.validator(value);
                      return FormValidator.validateField(
                        value,
                        field: widget.label ?? widget.hint,
                        length: widget.lengthValidator,
                      );
                    }
                  : null,
              decoration: InputDecoration(
                hintText: widget.hint,
                border: OutlineInputBorder(),
                prefixIcon: widget.prefixIcon,
                //labelText: label,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
