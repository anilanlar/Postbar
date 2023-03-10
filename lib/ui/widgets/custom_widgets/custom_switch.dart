import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({
    Key? key,
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
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> with SingleTickerProviderStateMixin {
  late Animation<dynamic> _toggleAnimation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      value: widget.value ? 1.0 : 0.0,
      duration: widget.duration,
    );
    _toggleAnimation = AlignmentTween(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(CustomSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value == widget.value) {
      return;
    }

    if (widget.value) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    Color _toggleColor = Colors.white;
    Color _switchColor = Colors.white;
    Border? _switchBorder;
    Border? _toggleBorder;

    if (widget.value) {
      _toggleColor = widget.activeToggleColor ?? widget.toggleColor;
      _switchColor = widget.activeColor;
      _switchBorder = widget.activeSwitchBorder as Border? ?? widget.switchBorder as Border?;
      _toggleBorder = widget.activeToggleBorder as Border? ?? widget.toggleBorder as Border?;
    } else {
      _toggleColor = widget.inactiveToggleColor ?? widget.toggleColor;
      _switchColor = widget.inactiveColor;
      _switchBorder = widget.inactiveSwitchBorder as Border? ?? widget.switchBorder as Border?;
      _toggleBorder = widget.inactiveToggleBorder as Border? ?? widget.toggleBorder as Border?;
    }

    final double _textSpace = widget.width - widget.toggleWidth;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        return Align(
          child: GestureDetector(
            onTap: () {
              if (!widget.disabled) {
                if (widget.value) {
                  _animationController.forward();
                } else {
                  _animationController.reverse();
                }

                widget.onToggle(!widget.value);
              }
            },
            child: Opacity(
              opacity: widget.disabled ? 0.6 : 1,
              child: Container(
                clipBehavior: Clip.none,
                width: widget.width,
                height: widget.height,
                padding: EdgeInsets.all(widget.padding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  color: _switchColor,
                  border: _switchBorder,
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    AnimatedOpacity(
                      opacity: widget.value ? 1.0 : 0.0,
                      duration: widget.duration,
                      child: Container(
                        width: _textSpace,
                        padding: const EdgeInsets.only(left: 15.0),
                        alignment: Alignment.centerLeft,
                        child: _activeText,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: AnimatedOpacity(
                        opacity: !widget.value ? 1.0 : 0.0,
                        duration: widget.duration,
                        child: Container(
                          width: _textSpace,
                          padding: const EdgeInsets.only(right: 15.0),
                          alignment: Alignment.centerRight,
                          child: _inactiveText,
                        ),
                      ),
                    ),
                    OverflowBox(
                      alignment: widget.value ? Alignment.centerRight : Alignment.centerLeft,
                      maxHeight: 50,
                      child: SizedBox(
                        width: widget.toggleWidth,
                        height: widget.toggleHeight,
                        child: Align(
                          alignment: _toggleAnimation.value,
                          child: Container(
                            width: widget.toggleWidth,
                            height: widget.toggleHeight,
                            padding: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(widget.toggleBorderRadius),
                              color: _toggleColor,
                              border: _toggleBorder,
                            ),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: SizedBox(
                                child: Stack(
                                  children: <Widget>[
                                    Center(
                                      child: AnimatedOpacity(
                                        opacity: widget.value ? 1.0 : 0.0,
                                        duration: widget.duration,
                                        child: widget.activeIcon,
                                      ),
                                    ),
                                    Center(
                                      child: AnimatedOpacity(
                                        opacity: !widget.value ? 1.0 : 0.0,
                                        duration: widget.duration,
                                        child: widget.inactiveIcon,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  FontWeight get _activeTextFontWeight => widget.activeTextFontWeight ?? FontWeight.w900;

  FontWeight get _inactiveTextFontWeight => widget.inactiveTextFontWeight ?? FontWeight.w900;

  Widget get _activeText {
    if (widget.showOnOff) {
      return Text(
        widget.activeText ?? "On",
        style: TextStyle(
          color: widget.activeTextColor,
          fontWeight: _activeTextFontWeight,
          fontSize: widget.valueFontSize,
        ),
      );
    }

    return const Text("");
  }

  Widget get _inactiveText {
    if (widget.showOnOff) {
      return Text(
        widget.inactiveText ?? "Off",
        style: TextStyle(
          color: widget.inactiveTextColor,
          fontWeight: _inactiveTextFontWeight,
          fontSize: widget.valueFontSize,
        ),
        textAlign: TextAlign.right,
      );
    }

    return const Text("");
  }
}
