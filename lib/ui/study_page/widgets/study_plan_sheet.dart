// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kd_utils/kd_utils.dart';

import '../../../repo/study_plan_repo/study_plan_repo.dart';
import '../../../router/app_router.dart';
import '../../../style/color.dart';
import '../../../uitls/app_utils.dart';
import '../../../widegts/k_btn.dart';
import '../../../widegts/k_text_field.dart';

class AddStudyPlanSheet extends StatefulWidget {
  const AddStudyPlanSheet({
    super.key,
  });

  @override
  State<AddStudyPlanSheet> createState() => _AddStudyPlanSheetState();
}

class _AddStudyPlanSheetState extends State<AddStudyPlanSheet> {
  TextEditingController titleTextController = TextEditingController();
  TextEditingController desTextController = TextEditingController();

  @override
  void dispose() {
    titleTextController.dispose();
    desTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 48,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: AppColor.scaffoldBg,
          ),
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: SizedBox(height: 48, child: Icon(Icons.close))),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Create Study Plan",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),

        // note take
        Container(
          // height: 141,
          width: double.maxFinite,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              KTextField(
                controller: titleTextController,
                hint: "Title",
                textInputAction: TextInputAction.next,
              ),
              12.height,
              KTextField(
                controller: desTextController,
                hint: "Description",
                maxLine: 3,
              ),
            ],
          ),
        ),

        // btns
        SizedBox(
          height: 56,
          width: double.maxFinite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              KBtn(
                height: 44,
                width: 165,
                onClick: () {
                  Navigator.of(context).pop();
                },
                text: "Cancel",
                bgColor: AppColor.white,
                borderSide: BorderSide(color: AppColor.softBorderColor),
                fbColor: Colors.black,
                borderRadius: 4,
              ),
              12.width,
              KBtn(
                width: 165,
                height: 44,
                onClick: () {
                  if (titleTextController.text.isEmpty || desTextController.text.isEmpty) {
                    AppUtils.showSnack("Enter Title and Description");
                  } else {
                    rootNavigator.currentState!.focusNode.unfocus();
                    AppUtils.showloadingOverlay(() async {
                      await StudyPlanRepository.addStudyPlan(title: titleTextController.text, description: desTextController.text).then((value) {
                        if (value['code'] == 200) {
                          Navigator.of(context).pop("yes");
                          AppUtils.showSnack(value['message']);
                        } else {
                          throw value['message'];
                        }
                        // print(value);
                      }).onError((error, stackTrace) {
                        AppUtils.showSnack(error.toString());
                      });
                    });
                  }
                },
                text: "Add Study Plan",
                borderRadius: 4,
              ),
            ],
          ),
        ),
        20.height,
      ],
    );
  }
}
