import 'package:flutter/material.dart';
import 'package:postbar/core/utils/index.dart';

class RequestInterceptor {
  static Map<String, String> get getHeaders {
    final Map<String, String> headers = <String, String>{
      "Content-Type": "application/json",
      "Accept-Type": "application/json",
      if (LanguageHelper.getLanguageCode() != null && LanguageHelper.getCountryCode() != null) "Accept-Language": "${LanguageHelper.getLanguageCode()}-${LanguageHelper.getCountryCode()}",
    };
    debugPrint("Headers - ${headers.keys} : ${headers.values}");
    return headers;
  }

  static Map<String, dynamic> get getQueries {
    final Map<String, dynamic> queries = <String, dynamic>{
      if (LanguageHelper.getLanguageCode() != null && LanguageHelper.getCountryCode() != null) "language": "${LanguageHelper.getLanguageCode()}-${LanguageHelper.getCountryCode()}",
    };
    debugPrint("Queries - ${queries.keys} : ${queries.values}");
    return queries;
  }
}
