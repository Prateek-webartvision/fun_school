// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:detectable_text_field/detectable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fun_school/ui/school_communities_page/school_communities_page.dart';
import 'package:get/state_manager.dart';
import 'package:kd_utils/kd_utils.dart';
import '../../../router/app_router.dart';
import '../../../style/assets.dart';
import '../../../style/color.dart';

class NewPostSheet extends StatelessWidget {
  const NewPostSheet({
    super.key,
    this.onPostClick,
    required this.topic,
    required this.subject,
    required this.hashTag,
    this.onFilePicker,
    required this.imagesController,
  });
  final TextEditingController topic, subject;
  final DetectableTextEditingController hashTag;
  final SelectedImagesController imagesController;
  final Function()? onPostClick;
  final Function()? onFilePicker;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      color: AppColor.white,
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 48,
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(color: AppColor.softBorderColor))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Post Discussion",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                InkWell(
                  onTap: () {
                    rootNavigator.currentState!.pop();
                  },
                  child: Icon(Icons.close_rounded),
                )
              ],
            ),
          ),
          //* hash Tag text

          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     border: Border(
          //       bottom: BorderSide(color: AppColor.softBorderColor),
          //     ),
          //   ),
          //   child: Row(
          //     children: [
          //       SvgPicture.asset(AppAssets.svg.listIcon),
          //       16.width,
          //       Expanded(
          //         child: Text("Select topic category"),
          //       ),
          //       16.width,
          //       SvgPicture.asset(AppAssets.svg.arrowRight),
          //     ],
          //   ),
          // ),

          //* topic Text fields
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: AppColor.softBorderColor),
              ),
            ),
            child: Column(
              children: [
                // * hash Tag text
                DetectableTextField(
                  controller: hashTag,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Your HashTags",
                  ),
                  // detectedStyle: ,
                  // regExp: hashTagRegExp,
                ),
                Divider(),
                TextField(
                  controller: topic,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Write your topic or question",
                    border: InputBorder.none,
                  ),
                ),
                Divider(),
                TextField(
                  controller: subject,
                  minLines: 1,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: "Elaborate on your topic ",
                    border: InputBorder.none,
                  ),
                ),
              ],
            ),
          ),
          10.height,
          GetBuilder(
            init: imagesController,
            builder: (controller) {
              return SizedBox(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  itemCount: controller.selectedImages.length,
                  itemBuilder: (context, index) {
                    final file = controller.selectedImages[index];
                    return Container(
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: FileImage(
                            File(file.path!),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          imagesController.remove(file);
                        },
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(1, 1),
                                color: Colors.black38,
                              )
                            ],
                          ),
                          child: Icon(Icons.close, size: 16),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => 10.width,
                ),
              );
            },
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  // bottom: BorderSide(color: AppColor.softBorderColor),
                  ),
            ),
            child: Row(
              children: [
                // Container(
                //   height: 48,
                //   width: 48,
                //   alignment: Alignment.center,
                //   child: SvgPicture.asset(AppAssets.svg.happyFaceIcon),
                // ),
                GestureDetector(
                  onTap: onFilePicker,
                  child: Container(
                    height: 48,
                    width: 48,
                    alignment: Alignment.center,
                    child: SvgPicture.asset(AppAssets.svg.attachmentIcon),
                  ),
                ),
                // Container(
                //   height: 48,
                //   width: 48,
                //   alignment: Alignment.center,
                //   child: SvgPicture.asset(AppAssets.svg.chatPollIcon),
                // ),
                Spacer(),
                ElevatedButton(
                  style: ButtonStyle(
                      fixedSize: MaterialStatePropertyAll(Size.fromHeight(48)),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4))),
                      backgroundColor: MaterialStatePropertyAll(
                          (onPostClick != null)
                              ? AppColor.mainColor
                              : AppColor.textFeildBorderColor),
                      foregroundColor:
                          MaterialStatePropertyAll(AppColor.white)),
                  onPressed: onPostClick,
                  child: Text(
                    "Post Discussion",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
