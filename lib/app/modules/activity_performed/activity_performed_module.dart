import 'package:flutter/material.dart';
import 'activity_performed_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'activity_performed_page.dart';

class ActivityPerformedModule extends WidgetModule {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ActivityPerformedController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => ActivityPerformedPage()),
  ];

  @override
  Widget get view => ActivityPerformedPage();
}
