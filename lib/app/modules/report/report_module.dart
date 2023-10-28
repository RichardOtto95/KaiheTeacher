import 'package:flutter/material.dart';
import 'package:teacher_side/app/modules/report/report_page.dart';
import 'report_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ReportModule extends WidgetModule {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ReportController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => ReportPage()),
  ];

  @override
  Widget get view => ReportPage();
}
