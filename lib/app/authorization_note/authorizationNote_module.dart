import 'package:flutter/src/widgets/framework.dart';
import 'package:teacher_side/app/authorization_note/pages/authorizationNote_page.dart';

import 'package:teacher_side/app/authorization_note/stores/authorizationNote_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthorizationNoteModule extends WidgetModule {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AuthorizationNoteStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => AuthorizationNotePage()),
  ];

  @override
  // TODO: implement view
  Widget get view => AuthorizationNotePage();
}
