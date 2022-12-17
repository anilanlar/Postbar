import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class VkUser extends Equatable {
  late final String? title;
  late final String? franchiseName;

  late final List<String?> designList;

  VkUser(dynamic jsonResponse){
    String? distributorTitle = jsonResponse[0].toString();
    if(distributorTitle != null){
      title = distributorTitle;
    }else{
      debugPrint("Title couldn't be fetched");
    }

    designList = [];
    for (int i=1; i< jsonResponse.length; i++){
      String? designLinkFromStorage = jsonResponse[i].toString();
      if(designLinkFromStorage != null){
        designList.add(designLinkFromStorage);
      }else{
        debugPrint("Image link number: $i couldn't be fetched");
      }

    }
  }



  @override
  List<Object?> get props => <Object?>[
        title,
        designList,
      ];
}
