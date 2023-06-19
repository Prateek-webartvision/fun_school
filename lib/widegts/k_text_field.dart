// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kd_utils/kd_utils.dart';

import '../style/color.dart';

class KTextField extends StatefulWidget {
  const KTextField({
    super.key,
    this.hint,
    this.isPassword = false,
    this.controller,
    this.textInputType,
    this.textInputAction,
    this.enabled,
    this.suffixIcon,
    this.errorText,
  });
  final String? hint;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final bool? enabled;
  final Icon? suffixIcon;
  final String? errorText;

  @override
  State<KTextField> createState() => _KTextFieldState();
}

class _KTextFieldState extends State<KTextField> {
  bool passHide = true;
  OutlineInputBorder _border() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: BorderSide(color: AppColor.textFeildBorderColor, width: .5),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.hint ?? "",
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: AppColor.textFeildColor,
          ),
        ),
        TextField(
          enabled: widget.enabled,
          controller: widget.controller,
          obscureText: (widget.isPassword) ? passHide : widget.isPassword,
          textInputAction: widget.textInputAction,
          keyboardType: widget.textInputType,
          cursorColor: AppColor.textFeildColor,
          cursorRadius: Radius.circular(8),
          cursorOpacityAnimates: true,
          decoration: InputDecoration(
            errorText: widget.errorText,
            border: _border(),
            focusedBorder: _border(),
            disabledBorder: _border(),
            enabledBorder: _border(),
            errorBorder: _border(),
            suffixIcon: (widget.suffixIcon != null)
                ? widget.suffixIcon
                : (widget.isPassword)
                    ? GestureDetector(
                        onTap: () {
                          setState(() => passHide = !passHide);
                        },
                        child: Icon((passHide) ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                      )
                    : null,
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            isDense: true,
          ),
        ),
      ],
    );
  }
}

//K Search field
class KSearchField extends StatelessWidget {
  const KSearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border.all(color: AppColor.softBorderColor),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          Icon(Icons.search_rounded),
          12.width,
          Text(
            "Search",
            style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff656565)),
          ),
        ],
      ),
    );
  }
}
