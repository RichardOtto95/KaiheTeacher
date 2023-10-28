import 'package:flutter/src/widgets/framework.dart';

import 'food_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'food_page.dart';

class FoodModule extends WidgetModule {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => FoodController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => FoodPage()),
  ];

  @override
  Widget get view => FoodPage();
}
