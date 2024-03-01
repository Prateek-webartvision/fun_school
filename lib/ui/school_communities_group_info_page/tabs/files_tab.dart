// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fun_school/style/assets.dart';
import 'package:fun_school/style/color.dart';
import 'package:flutter/material.dart';
import 'package:fun_school/ui/school_communities_group_info_page/school_communities_group_info_page.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../widgets/error_page.dart';
import '../widgets/file_tile.dart';

class FilesTab extends StatelessWidget {
  const FilesTab({
    super.key,
    required this.controller,
  });
  final GroupFilesController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        builder: (cnt) {
          if (controller.state == ApiState.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (controller.state == ApiState.error) {
            return ErrorPage(
              error: controller.error,
              onError: () async => controller.initLoad,
            );
          }

          if (controller.files.isEmpty) {
            return Center(
              child: Text("No Files"),
            );
          } else {
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 11),
              children: [
                // folders

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      // "Folders",
                      "Files",
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
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColor.mainColor),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                // 16.height,
                // folders
                // ListView(
                //   shrinkWrap: true,
                //   primary: false,
                //   children: [
                //     FolderCardTile(name: "Main Archive"),
                //     16.height,
                //     FolderCardTile(name: "Office Pictures"),
                //   ],
                // ),
                // 8.height,
                // Text(
                //   "Files",
                //   style: TextStyle(
                //     fontSize: 18,
                //     fontWeight: FontWeight.w600,
                //   ),
                // ),
                16.height,
                // *  files List
                GridView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: controller.files.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 208,
                  ),
                  itemBuilder: (context, index) {
                    final item = controller.files[index];
                    // return Text(file.fileId.toString());
                    return FileTile(
                      fileName: item.fileName ?? "",
                      fileURl: item.fileLink ?? "",
                    );
                  },
                  // children: [
                  //   FileTile(svgIcon: AppAssets.svg.zipIcon),
                  //   FileTile(svgIcon: AppAssets.svg.jpg),
                  //   FileTile(svgIcon: AppAssets.svg.jpg),
                  //   FileTile(svgIcon: AppAssets.svg.zipIcon),
                  //   FileTile(svgIcon: AppAssets.svg.zipIcon),
                  //   FileTile(svgIcon: AppAssets.svg.zipIcon),
                  // ],
                )
              ],
            );
          }
        });
  }
}
