import 'package:flutter/material.dart';
import 'package:teacher_side/app/authorization_note/authorizationNote_module.dart';
import 'package:teacher_side/app/authorization_note/stores/authorizationNote_store.dart';
import 'package:teacher_side/app/modules/classroom/classroom_controller.dart';
import 'main_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'main_page.dart';

class MainModule extends WidgetModule {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => MainController()),
    Bind.lazySingleton((i) => ClassroomController()),
    Bind.lazySingleton((i) => AuthorizationNoteStore())
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => MainPage()),
  ];

  @override
  Widget get view => MainPage();
}
