import 'package:flutter/material.dart';
import 'package:postbar/core/theme/index.dart';
import 'package:postbar/ui/widgets/base_widgets/index.dart';

class CustomGradientButton extends StatelessWidget {
  const CustomGradientButton({
    Key? key,
    required this.onPressed,
    this.child,
    this.borderRadius,
    this.boxShadow,
    this.gradient,
    this.textColor = Colors.white,
    this.text,
    this.fontSize,
    this.fontWeight = FontWeight.w600,
    this.onLongPress,
    this.focusNode,
    this.borderColor = Colors.transparent,
    this.elevation = 2,
  }) : super(key: key);

  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Gradient? gradient;
  final Widget? child;

  final Color textColor;
  final String? text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final FocusNode? focusNode;
  final Color borderColor;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return BaseGradientButton(
      boxShadow: boxShadow,
      gradient: gradient ??
          const LinearGradient(
            colors: <Color>[
              ThemeColors.secondaryColor,
              ThemeColors.thirdColor,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
      child: child ??
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              text ?? '',
              style: TextStyles.buttonText,
            ),
          ),
      onPressed: onPressed,
    );
  }
}
