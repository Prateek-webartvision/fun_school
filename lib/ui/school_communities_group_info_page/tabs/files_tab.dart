// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fun_school/repo/community/community_group_repo.dart';
import 'package:fun_school/router/app_router.dart';
import 'package:fun_school/style/color.dart';
import 'package:fun_school/widgets/k_btn.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:kd_utils/kd_utils.dart';
import '../../../widgets/error_page.dart';
import '../controller/image_picker.controller.dart';
import '../school_communities_group_info_page.dart';
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
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return FileUploadDialog(
                        groupID: controller.groupID,
                      );
                    },
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add_rounded),
                    Text("Add Files"),
                  ],
                ),
              ),
            );
          } else {
            return RefreshIndicator(
              onRefresh: () async => await controller.reLoad,
              child: ListView(
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
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return FileUploadDialog(
                                groupID: controller.groupID,
                              );
                            },
                          );
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
                        uploaderID: item.uploaderId ?? "",
                        fileName: item.fileName ?? "",
                        fileURl: item.fileLink ?? "",
                        fileID: item.fileId ?? "",
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
              ),
            );
          }
        });
  }
}

class FileUploadDialog extends StatefulWidget {
  const FileUploadDialog({
    super.key,
    required this.groupID,
  });
  final String groupID;

  @override
  State<FileUploadDialog> createState() => _FileUploadDialogState();
}

class _FileUploadDialogState extends State<FileUploadDialog> {
  FilePicker filePicker = FilePicker.platform;
  ImagePickerController fileController = ImagePickerController();
  UploadFileController uploadFileController = UploadFileController();
  RegExp imageReg = RegExp(r'.(png|jpg|jpeg)');

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GetBuilder(
          init: uploadFileController,
          builder: (uController) {
            return GetBuilder(
                init: fileController,
                builder: (fcnt) {
                  return Container(
                    width: 360,
                    color: Colors.white,
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              (uController.startUploading)
                                  ? "Please wait, uploading in progress..."
                                  : "Pick your file",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                // log("message");
                                context.pop();
                              },
                              icon: Icon(Icons.close),
                            )
                          ],
                        ),
                        if (fileController.image != null) 10.height,
                        if (fileController.image != null)
                          Column(children: [
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8),
                                  image: (imageReg.hasMatch(fcnt.image!.path!))
                                      ? DecorationImage(
                                          image: FileImage(
                                            File(fcnt.image!.path!),
                                          ),
                                        )
                                      : null),
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(16),
                              child: (imageReg.hasMatch(fcnt.image!.path!))
                                  ? null
                                  : Text(
                                      fileController.image!.path!
                                          .split('/')
                                          .last,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                            ),
                          ]),
                        20.height,
                        if (uController.startUploading)
                          LinearProgressIndicator()
                        else
                          KBtn(
                              width: double.maxFinite,
                              onClick: () async {
                                if ((fcnt.image == null)) {
                                  final res = await filePicker.pickFiles();
                                  if (res?.files != null &&
                                      res!.files.isNotEmpty) {
                                    fileController.setImage = res.files.first;
                                  }
                                } else {
                                  // uploadFile
                                  uController.upload(
                                    fcnt.image!.path!,
                                    groupId: widget.groupID,
                                  );
                                }
                              },
                              text: (fcnt.image == null)
                                  ? "Select File"
                                  : "upload")
                      ],
                    ),
                  );
                });
          }),
    );
  }
}

class UploadFileController extends GetxController {
  bool startUploading = false;

  Future upload(
    String filePath, {
    required String groupId,
  }) async {
    startUploading = true;
    update();

    try {
      // upload file with dio
      await CommunityGroupRepository.uploadGroupFile(filePath, groupId);
      startUploading = false;
      update();
      appRoutes.pop();
      Get.find<GroupFilesController>().reLoad;
    } catch (e) {
      startUploading = false;
      update();
    }
  }
}
