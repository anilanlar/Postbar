import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:postbar/core/theme/index.dart';
import 'package:postbar/ui/widgets/base_widgets/index.dart';

class CustomInputBox extends StatelessWidget {
  const CustomInputBox({
    Key? key,
    required this.textEditingController,
    required this.labelText,
    required this.hintText,
    this.focusNode,
    this.nextFocusNode,
    this.obscureText = false,
    this.textInputAction,
    this.keyboardType,
    this.autofillHints,
    this.decoration,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly = false,
    this.style,
    this.enabled = true,
    this.inputFormatters,
    this.maxLines = 1,
    this.maxLength,
    this.maxLengthEnforcement,
    this.cursorColor = Colors.white,
  }) : super(key: key);

  final String? hintText;
  final String? labelText;
  final TextEditingController? textEditingController;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final List<String>? autofillHints;
  final InputDecoration? decoration;
  final Function(String?)? onChanged;
  final VoidCallback? onEditingComplete;
  final Function(String?)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool readOnly;
  final TextStyle? style;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final Color? cursorColor;

  @override
  Widget build(BuildContext context) {
    return BaseInputBox(
      textEditingController: textEditingController,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Colors.white,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Colors.white,
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Colors.white,
          ),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: ThemeColors.errorColor,
          ),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: ThemeColors.errorColor,
          ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelText: labelText,
        hintText: hintText,
        labelStyle: TextStyles.inputBoxLabel,
        hintStyle: TextStyles.inputBoxHint,
      ),
      style: TextStyles.inputBox,
      enabled: enabled,
      focusNode: focusNode,
      obscureText: obscureText,
      textInputAction: textInputAction,
      keyboardType: keyboardType ?? TextInputType.visiblePassword,
      autofillHints: autofillHints ?? <String>[],
      maxLength: maxLength,
      maxLengthEnforcement: maxLengthEnforcement,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: (String? value) {
        if (focusNode != null) {
          focusNode!.unfocus();
        }
        if (onFieldSubmitted != null) {
          onFieldSubmitted!(value);
        }
        if (nextFocusNode != null) {
          nextFocusNode!.requestFocus();
        }
      },
      validator: validator,
      readOnly: readOnly,
      cursorColor: cursorColor ?? ThemeColors.primaryColor,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
    );
  }
}
