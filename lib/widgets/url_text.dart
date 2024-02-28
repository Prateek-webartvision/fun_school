import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class UrlText extends StatefulWidget {
  const UrlText({
    super.key,
    required this.message,
    this.onUrlClick,
    this.color,
    this.urlColor,
  });

  final String message;
  final Function(Uri uri)? onUrlClick;
  final Color? color, urlColor;

  @override
  State<UrlText> createState() => _UrlTextState();
}

class _UrlTextState extends State<UrlText> {
  final urlRegExp = RegExp(
      r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");

  late List<String> texts;
  @override
  void initState() {
    texts = widget.message.split(" ");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: List.generate(
          texts.length,
          (index) {
            String t = texts[index];
            final isUrl = urlRegExp.hasMatch(t);
            return TextSpan(
              text: t,
              children: [
                if ((texts.length - 1) > index)
                  TextSpan(
                    text: " ",
                  ),
              ],
              style: TextStyle(
                color: (isUrl) ? widget.urlColor : widget.color,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  if (isUrl == true) {
                    widget.onUrlClick!(Uri.parse(t));
                  }
                },
            );
          },
        ),
      ),
      //
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: widget.color,
      ),
    );
  }
}
