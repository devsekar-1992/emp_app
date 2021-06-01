import 'package:flutter/material.dart';

class TaskFormDropdown extends StatelessWidget {
  const TaskFormDropdown(
      {required this.dropdownMenuItemList,
      required this.onChanged,
      required this.selectedValue,
      required this.onValidate});

  final List<DropdownMenuItem<int>> dropdownMenuItemList;
  final int selectedValue;
  final ValueSetter<int> onChanged;
  // ignore: non_constant_identifier_names
  final FormFieldValidator onValidate;

  @override
  Widget build(BuildContext context) {
    print('Build once again');
    return DropdownButtonHideUnderline(
        child: DropdownButton(
            isExpanded: true,
            onChanged: (int? value) {
              onChanged(value!);
            },
            value: selectedValue,
            items: dropdownMenuItemList));
  }
}
