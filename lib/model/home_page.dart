import 'package:flutter/material.dart';

enum HomePages {
  CompanyType,
  SupportType,
  ContactUs,
  DesignList,
  FinalSettings,
  ExportDesign,
}

class HomePage {
  const HomePage({
    required this.index,
    this.previousPage,
    required this.type,
    required this.page,
    this.leading,
    this.actions,
    required this.showNextPageButton,
  });

  final int index;
  final HomePages? previousPage;
  final HomePages type;
  final Widget page;
  final Widget? leading;
  final List<Widget>? actions;
  final bool showNextPageButton;
}
