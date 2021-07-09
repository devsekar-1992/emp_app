import 'package:flutter/material.dart';

class TaskFormDropdown extends StatelessWidget {
  const TaskFormDropdown(
      {required this.dropdownMenuItemList,
      required this.onChanged,
      required this.selectedValue,
      required this.onValidate,
      required this.dropdownLabel});

  final List<DropdownMenuItem<int>> dropdownMenuItemList;
  final String dropdownLabel;
  final int selectedValue;
  final ValueSetter<int> onChanged;
  // ignore: non_constant_identifier_names
  final FormFieldValidator onValidate;

  @override
  Widget build(BuildContext context) {
    print('Build once again');
    return DropdownButtonFormField(
        decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.blue),
            labelText: dropdownLabel),
        hint: Text('Dropdown'),
        isExpanded: true,
        onChanged: (int? value) {
          onChanged(value!);
        },
        value: selectedValue,
        items: dropdownMenuItemList);
  }
}
