import 'package:flutter/material.dart';

import '../../../style/color.dart';

class ProficiencyDropdown extends StatelessWidget {
  const ProficiencyDropdown({
    super.key,
    required this.levelList,
    this.initSelected,
    required this.onItemClick,
  });
  final List<String> levelList;
  final String? initSelected;
  final Function(String? level) onItemClick;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String?>(
      value: initSelected,
      hint: const Text("Select Level"),
      isExpanded: true,
      icon: const Icon(Icons.arrow_drop_down),
      style: const TextStyle(fontSize: 14, color: Colors.black),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      borderRadius: BorderRadius.circular(4),
      alignment: Alignment.center,
      dropdownColor: AppColor.white,
      underline: const SizedBox(),
      isDense: true,
      onChanged: onItemClick,
      //
      items: levelList.map((value) {
        return DropdownMenuItem(
          value: value.toString(),
          child: Text(value.toString()),
        );
      }).toList(),
    );
  }
}
