import 'package:flutter/material.dart';
import 'package:postbar/core/theme/index.dart';
import 'package:postbar/ui/widgets/custom_widgets/index.dart';

class BaseDropdownMenu<T> extends StatelessWidget {
  const BaseDropdownMenu({
    Key? key,
    this.suffixIconData = Icons.arrow_forward_ios_outlined,
    this.title,
    this.hintText,
    this.dividerThickness = 1.2,
    this.height = 60,
    required this.value,
    required this.itemList,
    required this.onChanged,
    this.hasError = false,
    this.enableSearch,
    this.clearOption = false,
    this.dropDownItemCount = 6,
  }) : super(key: key);

  final IconData suffixIconData;
  final String? title;
  final String? hintText;
  final double dividerThickness;
  final double height;
  final T? value;
  final List<T> itemList;
  final Function(T?)? onChanged;
  final bool hasError;
  final bool? enableSearch;
  final bool clearOption;
  final int dropDownItemCount;

  @override
  Widget build(BuildContext context) {
    final BorderSide borderSide = BorderSide(color: hasError ? ThemeColors.errorColor : ThemeColors.borderColorDisable);

    return SizedBox(
      height: height,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: DropDownTextField(
              initialValue: value,
              clearOption: clearOption,
              enableSearch: enableSearch ?? itemList.length > dropDownItemCount,
              searchText: hintText,
              dropDownItemCount: dropDownItemCount,
              dropDownList: itemList.map((T item) {
                return DropDownValueModel(name: item.toString(), value: item);
              }).toList(),
              onChanged: (dynamic val) {
                if (onChanged != null) {
                  onChanged!((val as DropDownValueModel).value as T);
                }
              },
              textFieldDecoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: hasError ? ThemeColors.errorColor : ThemeColors.borderColorEnable),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: borderSide,
                ),
                border: OutlineInputBorder(
                  borderSide: borderSide,
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: borderSide,
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: borderSide,
                ),
                labelText: value != null ? hintText : null,
                hintText: hintText,
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
          ),
        ],
      ),
    );
  }
}
