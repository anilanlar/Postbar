import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class VkUser extends Equatable {
  late final String? title;
  late final String? franchiseAddress;
  late final String? franchisePhone;

  late final List<String?> designPostList;
  late final List<String?> designStoryList;

  VkUser(dynamic jsonResponse) {
    Map<dynamic,dynamic> section_info = jsonResponse["section_info"];

    if (section_info != null) {
      title = section_info["section_name"];
      franchiseAddress = section_info["section_address"];
      franchisePhone = section_info["section_phone"];
    } else {
      debugPrint("section_info couldn't be fetched");
    }


    designPostList = [];
    for (int i = 0; i < jsonResponse["posts"].length; i++) {
      String? designLinkFromStorage = jsonResponse["posts"][i].toString();
      if (designLinkFromStorage != null) {
        designPostList.add(designLinkFromStorage);
      } else {
        debugPrint("POST link number: $i couldn't be fetched");
      }
    }

    designStoryList = [];
    for (int i = 0; i < jsonResponse["stories"].length; i++) {
      String? designLinkFromStorage = jsonResponse["stories"][i].toString();
      if (designLinkFromStorage != null) {
        designStoryList.add(designLinkFromStorage);
      } else {
        debugPrint("STORY link number: $i couldn't be fetched");
      }
    }


  }


  @override
  List<Object?> get props =>
      <Object?>[
        title,
        franchiseAddress,
        designPostList,
        designStoryList,
      ];
}
