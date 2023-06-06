// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../style/color.dart';

class MyNoteTab extends StatelessWidget {
  const MyNoteTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColor.white,
            border: Border.all(color: AppColor.softBorderColor),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            children: [
              Container(
                // color: Colors.green,
                height: 44,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Text(
                        //   "Up next for you",
                        //   style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: context.theme.colorScheme.primary),
                        // ),
                        // 2.height,
                        Text(
                          "Alegbra Foundations",
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    // notes count
                    Container(
                      decoration: BoxDecoration(
                        color: AppColor.scaffoldBg,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: AppColor.textFeildBorderColor),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      child: Text(
                        "3 Notes",
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // notes
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    // note 1
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Overview and history algebra",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        4.height,
                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            border: Border.all(color: AppColor.softBorderColor),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          child: Row(
                            children: [
                              Icon(
                                Icons.note_rounded,
                                color: context.theme.colorScheme.primary,
                              ),
                              12.width,
                              Expanded(
                                child: Text(
                                  "“Sample Note”",
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              12.width,
                              Icon(Icons.copy_rounded),
                              12.width,
                              Icon(Icons.notes_rounded)
                            ],
                          ),
                        )
                      ],
                    ),
                    12.height,
                    // note 2
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Introduction to variables",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        4.height,
                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            border: Border.all(color: AppColor.softBorderColor),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          child: Row(
                            children: [
                              Icon(
                                Icons.note_rounded,
                                color: context.theme.colorScheme.primary,
                              ),
                              12.width,
                              Expanded(
                                child: Text(
                                  "“Sample Note”",
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              12.width,
                              Icon(Icons.copy_rounded),
                              12.width,
                              Icon(Icons.notes_rounded)
                            ],
                          ),
                        )
                      ],
                    ),
                    12.height,
                    // note 3
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Substitution and evaluating expressions",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        4.height,
                        Container(
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            border: Border.all(color: AppColor.softBorderColor),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          child: Row(
                            children: [
                              Icon(
                                Icons.note_rounded,
                                color: context.theme.colorScheme.primary,
                              ),
                              12.width,
                              Expanded(
                                child: Text(
                                  "“Sample Note”",
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              12.width,
                              Icon(Icons.copy_rounded),
                              12.width,
                              Icon(Icons.notes_rounded)
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              12.height,
            ],
          ),
        ),
      ],
    );
  }
}
