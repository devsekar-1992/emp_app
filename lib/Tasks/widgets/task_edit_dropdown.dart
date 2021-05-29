import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TaskFormDropdown<T> extends StatelessWidget {
  const TaskFormDropdown(
      {required this.dropdownMenuItemList,
      required this.onChanged,
      required this.selectedValue,
      required this.onValidate,
      required this.labelText});

  final List<DropdownMenuItem<T>> dropdownMenuItemList;
  final T selectedValue;
  final ValueChanged<T?> onChanged;
  // ignore: non_constant_identifier_names
  final FormFieldValidator<T?> onValidate;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white))),
      validator: onValidate,
      hint: Text(
        labelText,
        style: TextStyle(color: Colors.blue),
      ),
      isExpanded: true,
      value: selectedValue,
      onChanged: onChanged,
      items: dropdownMenuItemList,
    );
  }
}
