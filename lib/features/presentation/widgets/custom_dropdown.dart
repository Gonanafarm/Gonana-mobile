// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CustomDropDown extends StatefulWidget {
  CustomDropDown({
    Key? key,
    required this.initialOption,
    required this.hintText,
    required this.options,
    required this.onChanged,
    this.width = double.infinity,
    this.height = 56,
    this.fillColor = Colors.white,
    required this.elevation,
    this.hasError = false,
    required this.margin,
    this.hidesUnderline = false,
    required this.labelText,
  }) : super(key: key);

  final String initialOption;
  final String hintText;
  final List<String> options;
  final Function(String) onChanged;
  double width;
  double height;
  Color fillColor;
  bool hasError;
  final double elevation;
  final EdgeInsetsGeometry margin;
  final bool hidesUnderline;
  final String labelText;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  late String dropDownValue;
  List<String> get effectiveOptions =>
      widget.options.isEmpty ? ['[Option]'] : widget.options;

  @override
  void initState() {
    super.initState();
    dropDownValue = widget.initialOption;
  }

  @override
  Widget build(BuildContext context) {
    final dropdownWidget = DropdownButton<String>(
      value: effectiveOptions.contains(dropDownValue) ? dropDownValue : null,
      hint: widget.hintText != null
          ? Text(
              widget.hintText,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff444444)),
            )
          : null,
      items: effectiveOptions
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e),
              ))
          .toList(),
      elevation: widget.elevation.toInt(),
      onChanged: (value) {
        dropDownValue = value!;
        widget.onChanged(value);
      },
      icon: Icon(Icons.keyboard_arrow_down_outlined),
      isExpanded: true,
      dropdownColor: Theme.of(context).scaffoldBackgroundColor,
      focusColor: Colors.transparent,
    );
    final childWidget = DecoratedBox(
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xFF444444), width: 1.0),
        color: widget.fillColor,
      ),
      child: Padding(
        padding: widget.margin,
        child: widget.hidesUnderline
            ? DropdownButtonHideUnderline(child: dropdownWidget)
            : dropdownWidget,
      ),
    );
    // if (widget.height != null || widget.width != null) {
    //   return Container(
    //       width: widget.width, height: widget.height, child: childWidget);
    // }
    return childWidget;
  }
}
