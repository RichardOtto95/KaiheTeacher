import 'package:flutter/material.dart';
import 'classroom_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'classroom_page.dart';

class ClassroomModule extends WidgetModule {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ClassroomController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => ClassroomPage()),
  ];

  @override
  Widget get view => ClassroomPage();
}
