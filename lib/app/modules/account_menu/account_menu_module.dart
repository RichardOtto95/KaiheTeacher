import 'package:flutter/material.dart';

import 'account_menu_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'account_menu_page.dart';

class AccountMenuModule extends WidgetModule {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AccountMenuController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => AccountMenuPage()),
  ];

  @override
  Widget get view => AccountMenuPage();
}
