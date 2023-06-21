// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../style/color.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class SelectIntreset extends StatelessWidget {
  const SelectIntreset({
    super.key,
    required this.interestList,
    this.initInterest,
    required this.onItemClick,
  });
  final List<String> interestList;
  final String? initInterest;
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
          child: DropdownButton<String?>(
            value: initInterest,
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
            items: interestList.map((String value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
        //
        // 100.height,
        // Container(
        //   height: 40,
        //   decoration: BoxDecoration(
        //     color: AppColor.white,
        //     borderRadius: BorderRadius.circular(4),
        //     border: Border.all(color: AppColor.softBorderColor),
        //   ),
        //   padding: EdgeInsets.symmetric(horizontal: 10),
        //   child: Row(
        //     children: [
        //       Expanded(
        //         child: Text(
        //           "Lawyer, Poet",
        //           style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        //           maxLines: 1,
        //           overflow: TextOverflow.ellipsis,
        //         ),
        //       ),
        //       10.width,
        //       GestureDetector(onTap: () {}, child: Icon(Icons.arrow_drop_down))
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
