import 'package:flutter/material.dart';

import '../../../style/color.dart';
import '../../find_courses_by_school_page/controller/school_selector_controller.dart';

class SchoolDropdown extends StatelessWidget {
  const SchoolDropdown({
    super.key,
    required this.controller,
    this.selectedScholl,
    required this.onItemClick,
  });
  final SchoolSelectorController controller;
  final String? selectedScholl;
  final Function(String? lavel) onItemClick;

  @override
  Widget build(BuildContext context) {
    // print(controller.schools);

    return DropdownButton<String>(
      value: selectedScholl,
      hint: const Text("Select School Level"),
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
      items: controller.schools.map((value) {
        return DropdownMenuItem(
          value: value['key'].toString(),
          child: Text(value['name'].toString()),
        );
      }).toList(),
    );
  }
}
