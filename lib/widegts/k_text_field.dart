// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    this.maxLine = 1,
  });
  final String? hint;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final bool? enabled;
  final Widget? suffixIcon;
  final String? errorText;
  final int maxLine;

  @override
  State<KTextField> createState() => _KTextFieldState();
}

class _KTextFieldState extends State<KTextField> {
  bool passHide = true;

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
            color: AppColor.darkTextColor,
          ),
        ),
        TextField(
          maxLines: widget.maxLine,
          enabled: widget.enabled,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
          controller: widget.controller,
          obscureText: (widget.isPassword) ? passHide : widget.isPassword,
          textInputAction: widget.textInputAction,
          keyboardType: widget.textInputType,
          cursorColor: AppColor.darkTextColor,
          cursorRadius: Radius.circular(8),
          cursorOpacityAnimates: true,
          decoration: InputDecoration(
            errorText: widget.errorText,
            border: _border(),
            focusedBorder: _border(),
            disabledBorder: _border(),
            enabledBorder: _border(),
            errorBorder: _border(),
            suffixIconConstraints: BoxConstraints(minWidth: 16 + 24),
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

  OutlineInputBorder _border() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: BorderSide(
          color: AppColor.textFeildBorderColor,
          width: 0.5,
        ),
      );
}

//K Search field
class KSearchField extends StatelessWidget {
  const KSearchField({
    super.key,
    this.onSubmmit,
  });
  final Function(String v)? onSubmmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border.all(color: AppColor.softBorderColor),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Icon(Icons.search_rounded),
          // 12.width,
          // Text(
          //   "Search",
          //   style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xff656565)),
          // ),
          Expanded(
            child: TextField(
              enabled: true,
              // controller: widget.controller,
              textInputAction: TextInputAction.go,
              keyboardType: TextInputType.text,
              cursorColor: AppColor.mainColor,
              cursorRadius: Radius.circular(8),
              cursorOpacityAnimates: true,
              cursorHeight: 18,
              textAlign: TextAlign.left,
              style: textStyle.copyWith(color: Colors.black),
              onSubmitted: onSubmmit,
              decoration: InputDecoration(
                border: _border(),
                focusedBorder: _border(),
                disabledBorder: _border(),
                enabledBorder: _border(),
                errorBorder: _border(),
                hintText: "Search",
                hintStyle: textStyle,
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder _border() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: BorderSide.none,
      );
}

final TextStyle textStyle = GoogleFonts.inter(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: Color(0xff656565),
);
