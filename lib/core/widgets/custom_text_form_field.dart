import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {super.key,
      this.label,
      this.maxLines = 1,
      this.prefixIcon,
      this.suffixIcon,
      this.controller,
      this.isSecure = false,
      this.onPress,
      this.hint,
      this.keyboardType = TextInputType.text,
      this.validator});

  final String? label;
  final String? hint;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool isSecure;
  final VoidCallback? onPress;
  final TextInputType keyboardType;
  final int? maxLines;
  final TextEditingController? controller;
  String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType!,
      obscureText: isSecure,
      decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon != null
              ? IconButton(onPressed: onPress, icon: Icon(suffixIcon))
              : null),
    );
  }
}
