// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:citycloud_school/style/assets.dart';
import 'package:citycloud_school/style/color.dart';
import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../widgets/file_tile.dart';
import '../widgets/folders_tile.dart';

class FilesTab extends StatelessWidget {
  const FilesTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 11),
      children: [
        // folders
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Folders",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            GestureDetector(
              onTap: () {
                // print("click");
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add, color: AppColor.mainColor),
                  6.width,
                  Text(
                    "Upload Files",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColor.mainColor),
                  )
                ],
              ),
            )
          ],
        ),
        16.height,
        // folders
        ListView(
          shrinkWrap: true,
          primary: false,
          children: [
            FolderCardTile(name: "Main Archive"),
            16.height,
            FolderCardTile(name: "Office Pictures"),
          ],
        ),
        8.height,
        Text(
          "Files",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        16.height,
        GridView(
          shrinkWrap: true,
          primary: false,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 10, mainAxisExtent: 208),
          children: [
            FileTile(svgIcon: AppAssets.svg.zipIcon),
            FileTile(svgIcon: AppAssets.svg.jpg),
            FileTile(svgIcon: AppAssets.svg.jpg),
            FileTile(svgIcon: AppAssets.svg.zipIcon),
            FileTile(svgIcon: AppAssets.svg.zipIcon),
            FileTile(svgIcon: AppAssets.svg.zipIcon),
          ],
        )
      ],
    );
  }
}
