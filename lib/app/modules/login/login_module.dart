import 'package:flutter/src/widgets/framework.dart';
import 'package:teacher_side/app/modules/login/login_Page.dart';
import 'package:teacher_side/app/modules/login/login_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teacher_side/app/modules/sign_up/sign_up_module.dart';

class LoginModule extends WidgetModule {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LoginStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => LoginPage()),
  ];

  @override
  Widget get view => LoginPage();
}
