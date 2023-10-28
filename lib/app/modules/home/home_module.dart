// import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teacher_side/app/modules/student_data/student_data_controller.dart';
import '../attendence/attendence_store.dart';
import '../home/home_store.dart';
import 'home_page.dart';

class HomeModule extends WidgetModule {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeStore()),
    Bind.lazySingleton((i) => StudentDataController()),
    Bind.lazySingleton((i) => AttendenceStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => HomePage()),
  ];

  @override
  Widget get view => HomePage();
}
