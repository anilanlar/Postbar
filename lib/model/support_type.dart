import 'dart:convert';

import 'package:equatable/equatable.dart';

enum SupportTypes {
  DESIGN,
  CONTACT,
}

class SupportType extends Equatable {
  const SupportType({
    this.id,
    this.title,
    this.description,
    this.image,
    this.thumbnail,
    this.video,
    this.phone,
    this.type,
  });

  factory SupportType.fromRawJson(String str) => SupportType.fromJson(json.decode(str));

  factory SupportType.fromJson(dynamic json) => SupportType(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        thumbnail: json["thumbnail"],
        video: json["video"],
        phone: json["phone"],
        type: supportTypesMap[json["type"]],
      );

  final int? id;
  final String? title;
  final String? description;
  final String? image;
  final String? thumbnail;
  final String? video;
  final String? phone;
  final SupportTypes? type;

  @override
  List<Object?> get props => <Object?>[
        id,
        title,
        description,
        image,
        thumbnail,
        video,
        phone,
        type,
      ];
}

Map<String, SupportTypes> supportTypesMap = <String, SupportTypes>{
  "design": SupportTypes.DESIGN,
  "contact": SupportTypes.CONTACT,
};
