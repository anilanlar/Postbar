import "package:flutter/material.dart";
import 'package:postbar/core/theme/index.dart';
import 'package:postbar/ui/widgets/base_widgets/index.dart';
import 'package:postbar/ui/widgets/custom_widgets/index.dart';

class BaseSwitch extends StatefulWidget {
  const BaseSwitch({
    Key? key,
    this.hintText,
    required this.value,
    required this.onToggle,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
    this.activeTextColor = Colors.white70,
    this.inactiveTextColor = Colors.white70,
    this.toggleColor = Colors.white,
    this.activeToggleColor,
    this.inactiveToggleColor,
    this.width = 70.0,
    this.height = 35.0,
    this.toggleWidth = 20.0,
    this.toggleHeight = 25.0,
    this.valueFontSize = 16.0,
    this.borderRadius = 20.0,
    this.toggleBorderRadius = 15,
    this.padding = 0,
    this.showOnOff = false,
    this.activeText,
    this.inactiveText,
    this.activeTextFontWeight,
    this.inactiveTextFontWeight,
    this.switchBorder,
    this.activeSwitchBorder,
    this.inactiveSwitchBorder,
    this.toggleBorder,
    this.activeToggleBorder,
    this.inactiveToggleBorder,
    this.activeIcon,
    this.inactiveIcon,
    this.duration = const Duration(milliseconds: 200),
    this.disabled = false,
  })  : assert(
            (switchBorder == null || activeSwitchBorder == null) && (switchBorder == null || inactiveSwitchBorder == null),
            "Cannot provide switchBorder when an activeSwitchBorder or inactiveSwitchBorder was given\n"
            'To give the switch a border, use "activeSwitchBorder: border" or "inactiveSwitchBorder: border".'),
        assert(
            (toggleBorder == null || activeToggleBorder == null) && (toggleBorder == null || inactiveToggleBorder == null),
            "Cannot provide toggleBorder when an activeToggleBorder or inactiveToggleBorder was given\n"
            'To give the toggle a border, use "activeToggleBorder: color" or "inactiveToggleBorder: color".'),
        super(key: key);

  final String? hintText;
  final bool value;
  final ValueChanged<bool> onToggle;
  final bool showOnOff;
  final String? activeText;
  final String? inactiveText;
  final Color activeColor;
  final Color inactiveColor;
  final Color activeTextColor;
  final Color inactiveTextColor;
  final FontWeight? activeTextFontWeight;
  final FontWeight? inactiveTextFontWeight;
  final Color toggleColor;
  final Color? activeToggleColor;
  final Color? inactiveToggleColor;
  final double width;
  final double height;
  final double toggleWidth;
  final double toggleHeight;
  final double valueFontSize;
  final double borderRadius;
  final double toggleBorderRadius;
  final double padding;
  final BoxBorder? switchBorder;
  final BoxBorder? activeSwitchBorder;
  final BoxBorder? inactiveSwitchBorder;
  final BoxBorder? toggleBorder;
  final BoxBorder? activeToggleBorder;
  final BoxBorder? inactiveToggleBorder;
  final Widget? activeIcon;
  final Widget? inactiveIcon;
  final Duration duration;
  final bool disabled;

  @override
  State<BaseSwitch> createState() => _BaseSwitchState();
}

class _BaseSwitchState extends State<BaseSwitch> {
  late bool value;

  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          value = !value;
          widget.onToggle(value);
        });
      },
      child: BaseInputBox(
        textEditingController: TextEditingController(text: value ? (widget.activeText ?? widget.hintText) : (widget.inactiveText ?? widget.hintText)),
        enabled: false,
        decoration: InputDecoration(
          suffixIcon: SizedBox(
            height: widget.height / 10,
            width: 100,
            child: CustomSwitch(
              activeColor: widget.activeColor,
              inactiveColor: widget.inactiveColor,
              activeToggleColor: widget.activeToggleColor,
              inactiveToggleColor: widget.inactiveToggleColor,
              toggleBorderRadius: widget.toggleBorderRadius,
              valueFontSize: widget.valueFontSize,
              toggleHeight: widget.toggleHeight,
              toggleWidth: widget.toggleWidth,
              value: value,
              borderRadius: widget.borderRadius,
              showOnOff: widget.showOnOff,
              activeText: "",
              activeTextColor: widget.activeTextColor,
              inactiveText: "",
              inactiveTextFontWeight: widget.inactiveTextFontWeight,
              inactiveTextColor: widget.inactiveTextColor,
              onToggle: widget.onToggle,
            ),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: ThemeColors.borderColorEnable),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: ThemeColors.borderColorDisable),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: ThemeColors.borderColorDisable),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: ThemeColors.errorColor),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: ThemeColors.errorColor),
          ),
          labelText: widget.hintText,
          hintText: widget.hintText,
          alignLabelWithHint: true,
          disabledBorder: null,
          hintStyle: const TextStyle(
            color: ThemeColors.secondaryTextColor,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          labelStyle: const TextStyle(
            color: ThemeColors.secondaryTextColor,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
