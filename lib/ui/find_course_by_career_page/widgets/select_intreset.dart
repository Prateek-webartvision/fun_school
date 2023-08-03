// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../style/color.dart';

class SelectIntreset extends StatelessWidget {
  const SelectIntreset({
    super.key,
    required this.interestSet,
    this.init,
    required this.onItemClick,
  });
  final Set<String> interestSet;
  final int? init;
  final Function(String? interest) onItemClick;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Interest",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
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
          child: DropdownButton(
            value: init != null ? interestSet.elementAt(init!) : null,
            hint: Text("Select Interest", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
            isExpanded: true,
            icon: Icon(Icons.arrow_drop_down),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(4),
            alignment: Alignment.centerLeft,
            dropdownColor: AppColor.white,
            underline: SizedBox(),
            isDense: true,
            onChanged: onItemClick,
            //
            items: interestSet.map((String value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
