// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../style/color.dart';
import '../controller/school_selector_controller.dart';

class SelectSchoolLevelDropDown extends StatelessWidget {
  const SelectSchoolLevelDropDown({
    super.key,
    this.initInterest,
    required this.schoolSelectorController,
    required this.onSelect,
  });
  final SchoolSelectorController schoolSelectorController;
  final String? initInterest;
  final Function(int index) onSelect;

  @override
  Widget build(BuildContext context) {
    // print(schoolSelectorController.schools);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select School Level",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: AppColor.softBorderColor),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.center,
          child: DropdownButton<String>(
            // value: initInterest,
            value: schoolSelectorController.schools[schoolSelectorController.schoolSeletedIndex].key,
            // hint: Text("Select Interest", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
            isExpanded: true,
            icon: Icon(Icons.arrow_drop_down),
            style: TextStyle(
              fontSize: 14,
              // fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(4),
            alignment: Alignment.centerLeft,
            dropdownColor: AppColor.white,
            underline: SizedBox(),
            isDense: true,
            // onChanged: onItemClick,
            onChanged: (value) {
              if (value != null) {
                final index = schoolSelectorController.schools.indexWhere((element) => element.key == value);
                onSelect(index);
              }
            },

            items: schoolSelectorController.schools.map((value) {
              return DropdownMenuItem(
                value: value.key,
                child: Text(value.name),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
