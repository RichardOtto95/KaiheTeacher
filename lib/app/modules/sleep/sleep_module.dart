import 'package:flutter/src/widgets/framework.dart';

import 'sleep_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'sleep_page.dart';

class SleepModule extends WidgetModule {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SleepController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => SleepPage()),
  ];

  @override
  // TODO: implement view
  Widget get view => SleepPage();
}
