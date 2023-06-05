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
  });
  final String? hint;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;

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
          controller: widget.controller,
          obscureText: (widget.isPassword) ? passHide : widget.isPassword,
          textInputAction: widget.textInputAction,
          keyboardType: widget.textInputType,
          cursorColor: AppColor.textFeildColor,
          cursorRadius: Radius.circular(8),
          cursorOpacityAnimates: true,
          decoration: InputDecoration(
            border: _border(),
            focusedBorder: _border(),
            disabledBorder: _border(),
            enabledBorder: _border(),
            errorBorder: _border(),
            suffixIcon: (widget.isPassword)
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
