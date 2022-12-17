import 'package:flutter/material.dart';

class BaseGradientButton extends StatefulWidget {
  const BaseGradientButton({
    Key? key,
    required this.onPressed,
    this.child,
    this.borderRadius,
    this.width,
    this.height = 50.0,
    required this.gradient,
    this.boxShadow,
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
  final double? width;
  final double height;
  final Gradient gradient;
  final List<BoxShadow>? boxShadow;
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
  State<BaseGradientButton> createState() => _BaseGradientButtonState();
}

class _BaseGradientButtonState extends State<BaseGradientButton> {
  late Gradient gradient;

  @override
  void initState() {
    super.initState();
    gradient = widget.gradient;
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      setState(() {
        gradient = LinearGradient(
          colors: gradient.colors.reversed.toList(),
          stops: gradient.stops?.reversed.toList(),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final BorderRadiusGeometry borderRadius = widget.borderRadius ?? BorderRadius.circular(20);
    return Material(
      color: Colors.transparent,
      elevation: widget.elevation,
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        onEnd: () {
          setState(() {
            gradient = LinearGradient(
              colors: gradient.colors.reversed.toList(),
              stops: gradient.stops,
            );
          });
        },
        clipBehavior: Clip.antiAlias,
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: borderRadius,
          boxShadow: widget.boxShadow,
        ),
        child: ElevatedButton(
          onPressed: () {
            try {
              widget.onPressed();
            } catch (e) {
              debugPrint("ButtonPressedError: $e");
            }
          },
          onLongPress: widget.onLongPress,
          focusNode: widget.focusNode,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: borderRadius),
          ),
          child: widget.child ??
              Text(
                widget.text ?? "",
                style: TextStyle(
                  color: widget.textColor,
                  fontWeight: widget.fontWeight,
                  fontSize: widget.fontSize,
                ),
              ),
        ),
      ),
    );
  }
}
