// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';
import 'dart:io';

import 'package:easy_folder_picker/FolderPicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fun_school/network/data/app_storage.dart';
import 'package:fun_school/repo/community/community_group_repo.dart';
import 'package:fun_school/router/app_router.dart';
import 'package:fun_school/ui/school_communities_group_info_page/school_communities_group_info_page.dart';
import 'package:fun_school/utils/app_utils.dart';
import 'package:fun_school/widgets/k_btn.dart';
import 'package:get/get.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/assets.dart';
import '../../../style/color.dart';
import '../../../style/theme.dart';

class FileTile extends StatelessWidget {
  const FileTile({
    super.key,
    required this.fileURl,
    required this.fileName,
    required this.uploaderID,
    required this.fileID,
  });
  // final String svgIcon;
  final String fileURl;
  final String fileName;
  final String uploaderID;
  final String fileID;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: AppShadow.mainShadow,
      ),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(fileSvg(fileName)),
                ),
                Positioned(
                  right: 16,
                  top: 16,
                  child: PopupMenuButton(
                    icon: Icon(
                      Icons.more_horiz_rounded,
                      color: Colors.black45,
                    ),
                    itemBuilder: (context) {
                      return [
                        if (AppStorage.user.current?.userId?.toString() ==
                            uploaderID)
                          PopupMenuItem(
                            value: "remove",
                            child: Text("Remove"),
                          ),
                        // download
                        PopupMenuItem(
                          value: "download",
                          child: Text("Download"),
                        ),
                      ];
                    },
                    onSelected: (value) async {
                      if (value == "remove") {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return RemoveFileDialog(
                              fileId: fileID,
                            );
                          },
                        );
                      }
                      if (value == "download") {
                        // select folder

                        // Directory directory = selectedDirectory;
                        // if (directory == null) {
                        //   directory = Directory(FolderPicker.ROOTPATH);
                        // }

                        Directory? newDirectory = await FolderPicker.pick(
                            allowFolderCreation: true,
                            context: context,
                            rootDirectory: Directory(FolderPicker.rootPath),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))));

                        log(newDirectory.toString());
                        // setState(() {
                        //   // selectedDirectory = newDirectory;
                        //   // print(selectedDirectory);
                        // });
                      }
                    },
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 54,
            width: double.maxFinite,
            alignment: Alignment.center,
            child: Text(
              // "StudyFile.${(svgIcon == AppAssets.svg.zipIcon) ? "zip" : "jpg"}",
              fileName,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  String fileSvg(String fileName) {
    final fileType = fileName.split('.').last;
    switch (fileType.toLowerCase()) {
      case "zip":
        return AppAssets.svg.zipIcon;

      case "jpg":
        return AppAssets.svg.jpg;

      default:
        return AppAssets.svg.openedFolderIcon;
    }
  }
}

class RemoveFileDialog extends StatelessWidget {
  const RemoveFileDialog({
    super.key,
    required this.fileId,
  });
  final String fileId;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 340,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Warning",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            20.height,
            Text("Are sure you want to delete file"),
            20.height,
            KBtn(
              width: double.maxFinite,
              bgColor: Colors.red,
              onClick: () {
                AppUtils.showLoadingOverlay(() async {
                  try {
                    await CommunityGroupRepository.removeGroupFile(
                        fileID: fileId);
                    await Get.find<GroupFilesController>().reLoad;
                    appRoutes.pop();
                  } catch (e) {
                    appRoutes.pop();
                    AppUtils.showSnack(e.toString());
                  }
                });
              },
              text: "Delete",
            )
          ],
        ),
      ),
    );
  }
}
