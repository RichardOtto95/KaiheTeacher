import 'package:flutter/src/widgets/framework.dart';

import 'bathroom_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'bathroom_page.dart';

class BathroomModule extends WidgetModule {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => BathroomController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => BathroomPage()),
  ];

  @override
  // TODO: implement view
  Widget get view => BathroomPage();
}
