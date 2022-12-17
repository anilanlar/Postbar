import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Design extends Equatable {
  const Design({
    this.id,
    this.title,
    this.image,
    this.companyInfoPosBottom,
    this.companyInfoPosLeft,
    this.companyInfoPosRight,
    this.companyInfoPosTop,
    this.companyInfoColor,
    this.companyTitlePosBottom,
    this.companyTitlePosLeft,
    this.companyTitlePosRight,
    this.companyTitlePosTop,
    this.companyTitleColor,
  });

  factory Design.fromRawJson(String str) => Design.fromJson(json.decode(str));

  factory Design.fromJson(dynamic json) {
    return Design(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        companyInfoPosBottom: json["company_info_pos_bottom"],
        companyInfoPosLeft: json["company_info_pos_left"],
        companyInfoPosRight: json["company_info_pos_right"],
        companyInfoPosTop: json["company_info_pos_top"],
        companyInfoColor: json["company_info_color"] != null ? Color(int.parse(json["company_info_color"])) : null,
        companyTitlePosBottom: json["company_title_pos_bottom"],
        companyTitlePosLeft: json["company_title_pos_left"],
        companyTitlePosRight: json["company_title_pos_right"],
        companyTitlePosTop: json["company_title_pos_top"],
        companyTitleColor: json["company_title_color"] != null ? Color(int.parse(json["company_title_color"])) : null,
      );}

  final int? id;
  final String? title;
  final String? image;
  final double? companyInfoPosBottom;
  final double? companyInfoPosLeft;
  final double? companyInfoPosRight;
  final double? companyInfoPosTop;
  final Color? companyInfoColor;
  final double? companyTitlePosBottom;
  final double? companyTitlePosLeft;
  final double? companyTitlePosRight;
  final double? companyTitlePosTop;
  final Color? companyTitleColor;

  @override
  List<Object?> get props => <Object?>[
        id,
        title,
        image,
      ];
}
