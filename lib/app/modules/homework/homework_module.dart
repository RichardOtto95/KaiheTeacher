// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:teacher_side/app/modules/homework/homework_Page.dart';
import 'package:teacher_side/app/modules/homework/homework_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeworkModule extends WidgetModule {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeworkStore()),
  ];

  @override
  // ignore: override_on_non_overriding_member
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => HomeworkPage()),
  ];

  @override
  Widget get view => HomeworkPage();
}
