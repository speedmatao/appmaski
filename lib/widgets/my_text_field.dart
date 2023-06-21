import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/light_colors.dart';

class MyTextFieldController extends StatelessWidget {
  MyTextFieldController(
      {Key? key,
      required this.label,
      this.maxLines = 1,
      this.minLines = 1,
      this.icon,
      this.controller,
      this.onChanged,
      this.claro = false,
      this.keyboardType,
      this.allSelect,
      this.textAlign,
      this.readOnly = false,
      this.inputFormaters,
      this.ontap,
      this.pass = false,
      this.style})
      : super(key: key);

  final bool claro;
  final TextEditingController? controller;
  final Widget? icon;
  final String label;
  final int maxLines;
  final int minLines;
  final bool readOnly;
  final bool? allSelect;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormaters;
  final Function? ontap;
  final bool pass;
  final FocusNode _focusNode = FocusNode();
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.requestFocus();
      },
      onDoubleTap: () {},
      child: TextField(
        readOnly: readOnly,
        focusNode: _focusNode,
        obscureText: pass,
        controller: controller,
        onChanged: onChanged,
        onTap: () => allSelect ?? false
            ? controller!.selection = TextSelection(
                baseOffset: 0, extentOffset: controller!.value.text.length)
            : ontap != null
                ? ontap!()
                : null,
        style: style ??
            TextStyle(
                color: claro ? LightColors().kLavender : Colors.black87,
                fontSize: 20),
        minLines: minLines,
        maxLines: maxLines,
        keyboardType: keyboardType,
        textAlign: textAlign ?? TextAlign.center,
        inputFormatters: inputFormaters,
        decoration: InputDecoration(
            fillColor: LightColors().kLavender,
            filled: true,
            suffixIcon: icon,
            labelText: label,
            labelStyle: TextStyle(
                color: claro ? LightColors().kLightYellow : Colors.black87,
                fontWeight: FontWeight.bold),
            focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(
                    color:
                        claro ? LightColors().kLightYellow : Colors.black87)),
            border: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(
                    color:
                        claro ? LightColors().kLightYellow : Colors.black87))),
      ),
    );
  }
}

class MyTimeFieldController extends StatelessWidget {
  const MyTimeFieldController(
      {Key? key,
      required this.label,
      this.maxLines = 1,
      this.minLines = 1,
      this.icon,
      this.controller,
      this.onChanged,
      this.claro = false,
      this.fontSize,
      required this.ontap,
      this.fondoClaro = false})
      : super(key: key);

  final bool claro;
  final TextEditingController? controller;
  final Widget? icon;
  final String label;
  final int maxLines;
  final int minLines;
  final VoidCallback ontap;
  final double? fontSize;
  final Function(String)? onChanged;
  final bool fondoClaro;

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(
            color: claro ? LightColors().kLavender : Colors.black87,
            fontSize: fontSize ?? 20,
            fontWeight: FontWeight.bold),
        minLines: minLines,
        maxLines: maxLines,
        textAlign: TextAlign.center,
        readOnly: true,
        decoration: InputDecoration(
            fillColor:
                !fondoClaro ? Colors.black.withOpacity(0.07) : Colors.white,
            filled: true,
            suffixIcon: icon,
            labelText: label,
            labelStyle: TextStyle(
                color: claro ? LightColors().kLavender : Colors.black87),
            focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(
                    color: claro ? LightColors().kLavender : Colors.black87)),
            border: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide:
                    BorderSide(color: claro ? Colors.white : Colors.black87))),
        onTap: ontap);
  }
}
