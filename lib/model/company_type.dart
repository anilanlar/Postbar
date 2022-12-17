import 'dart:convert';

import 'package:equatable/equatable.dart';

class CompanyType extends Equatable {
  const CompanyType({
    this.id,
    this.title,
    this.description,
    this.image,
  });

  factory CompanyType.fromRawJson(String str) => CompanyType.fromJson(json.decode(str));

  factory CompanyType.fromJson(dynamic json) => CompanyType(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
      );

  final int? id;
  final String? title;
  final String? description;
  final String? image;

  @override
  List<Object?> get props => <Object?>[
        id,
        title,
        description,
        image,
      ];
}
