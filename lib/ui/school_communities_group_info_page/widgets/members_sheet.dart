// member list sheet
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';
import '../../../style/theme.dart';
import '../controller/school_communities_group_info_page.controller.dart';

class MembersSheet extends StatefulWidget {
  const MembersSheet({
    super.key,
    required this.controller,
  });

  final GroupInfoPageController controller;

  @override
  State<MembersSheet> createState() => _MembersSheetState();
}

class _MembersSheetState extends State<MembersSheet> {
  DraggableScrollableController scrollableController =
      DraggableScrollableController();

  // @override
  // void initState() {
  //   scrollableController.addListener(() {
  //     log(scrollableController.size.toString());
  //   });
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   scrollableController.removeListener(() {});
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scrollableController,
      builder: (context, constraints) {
        return DraggableScrollableSheet(
          controller: scrollableController,
          minChildSize: 0.5,
          maxChildSize: 1,
          initialChildSize: 0.5,
          expand: false,
          builder: (context, scrollController) {
            return CustomScrollView(
              controller: scrollController,
              slivers: [
                // if (scrollableController.size >= 0.95)
                //   SliverToBoxAdapter(child: 40.height),
                SliverToBoxAdapter(
                  child: Container(
                    height: 48,
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(color: AppColor.softBorderColor),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Members",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        InkWell(
                          onTap: () {
                            // rootNavigator.currentState!.pop();
                            context.pop();
                          },
                          child: Icon(Icons.close_rounded),
                        )
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        16.height,
                        Text("Ways to add people",
                            style: TextStyle(fontSize: 14)),
                        10.height,
                        Container(
                          height: 56,
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: AppShadow.mainShadow,
                          ),
                          padding: EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Container(
                                height: 32,
                                width: 32,
                                decoration: BoxDecoration(
                                    color: AppColor.mainColor,
                                    borderRadius: BorderRadius.circular(32)),
                                child: Icon(
                                  Icons.add,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                              10.width,
                              Expanded(
                                  child: Text("Add people",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500))),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 20,
                              )
                            ],
                          ),
                        ),
                        8.height,
                        Container(
                          height: 56,
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: AppShadow.mainShadow,
                          ),
                          padding: EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Container(
                                height: 32,
                                width: 32,
                                decoration: BoxDecoration(
                                    color: AppColor.pinkColor,
                                    borderRadius: BorderRadius.circular(32)),
                                child: Icon(
                                  Icons.link,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                              10.width,
                              Expanded(
                                  child: Text("Share a link",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500))),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 20,
                              )
                            ],
                          ),
                        ),

                        //
                        10.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Members", style: TextStyle(fontSize: 14)),
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: AppColor.mainColor,
                                ),
                                4.width,
                                Text("2", style: TextStyle(fontSize: 14)),
                              ],
                            ),
                          ],
                        ),
                        10.height,
                        ListView(
                          shrinkWrap: true,
                          children: [
                            ListTile(
                              dense: true,
                              leading: CircleAvatar(
                                foregroundImage: NetworkImage(
                                    "https://imgv3.fotor.com/images/gallery/Realistic-Male-Profile-Picture.jpg"),
                              ),
                              title: Text(
                                "Tanner Worthington",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(
                                "Admin",
                                style: TextStyle(
                                    fontSize: 12, color: AppColor.mainColor),
                              ),
                            ),
                            ListTile(
                              dense: true,
                              leading: CircleAvatar(
                                foregroundImage: NetworkImage(
                                    "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg"),
                              ),
                              title: Text(
                                "Devon Lane",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(
                                "You",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              trailing: Icon(Icons.more_horiz_rounded),
                            ),
                            ListTile(
                              dense: true,
                              leading: CircleAvatar(
                                foregroundImage: NetworkImage(
                                    "https://images.pexels.com/photos/428364/pexels-photo-428364.jpeg"),
                              ),
                              title: Text(
                                "Leon Satterfield",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(
                                "@EcoWarrior",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                              trailing: Icon(Icons.more_horiz_rounded),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                // SliverToBoxAdapter(
                //   child: Text(
                //       "sad ${context.viewPadding.top} ${scrollableController.size}"),
                // )
              ],
            );
          },
        );
      },
    );

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
                  "Members",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                InkWell(
                  onTap: () {
                    // rootNavigator.currentState!.pop();
                    context.pop();
                  },
                  child: Icon(Icons.close_rounded),
                )
              ],
            ),
          ),
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.height,
                Text("Ways to add people", style: TextStyle(fontSize: 14)),
                10.height,
                Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: AppShadow.mainShadow,
                  ),
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                            color: AppColor.mainColor,
                            borderRadius: BorderRadius.circular(32)),
                        child: Icon(
                          Icons.add,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                      10.width,
                      Expanded(
                          child: Text("Add people",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500))),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 20,
                      )
                    ],
                  ),
                ),
                8.height,
                Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: AppShadow.mainShadow,
                  ),
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                            color: AppColor.pinkColor,
                            borderRadius: BorderRadius.circular(32)),
                        child: Icon(
                          Icons.link,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                      10.width,
                      Expanded(
                          child: Text("Share a link",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500))),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 20,
                      )
                    ],
                  ),
                ),

                //
                10.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Members", style: TextStyle(fontSize: 14)),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: AppColor.mainColor,
                        ),
                        4.width,
                        Text("2", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ],
                ),
                10.height,
                ListView(
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      dense: true,
                      leading: CircleAvatar(
                        foregroundImage: NetworkImage(
                            "https://imgv3.fotor.com/images/gallery/Realistic-Male-Profile-Picture.jpg"),
                      ),
                      title: Text(
                        "Tanner Worthington",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        "Admin",
                        style:
                            TextStyle(fontSize: 12, color: AppColor.mainColor),
                      ),
                    ),
                    ListTile(
                      dense: true,
                      leading: CircleAvatar(
                        foregroundImage: NetworkImage(
                            "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg"),
                      ),
                      title: Text(
                        "Devon Lane",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        "You",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      trailing: Icon(Icons.more_horiz_rounded),
                    ),
                    ListTile(
                      dense: true,
                      leading: CircleAvatar(
                        foregroundImage: NetworkImage(
                            "https://images.pexels.com/photos/428364/pexels-photo-428364.jpeg"),
                      ),
                      title: Text(
                        "Leon Satterfield",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        "@EcoWarrior",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      trailing: Icon(Icons.more_horiz_rounded),
                    )
                  ],
                )
              ],
            ),
          ),
          20.height,
        ],
      ),
    );
  }
}
