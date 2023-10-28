import 'package:flutter/src/widgets/framework.dart';
import 'package:teacher_side/app/modules/moment/moment_Page.dart';
import 'package:teacher_side/app/modules/moment/moment_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MomentModule extends WidgetModule {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => MomentStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => MomentPage()),
  ];

  @override
  // TODO: implement view
  Widget get view => MomentPage();
}
