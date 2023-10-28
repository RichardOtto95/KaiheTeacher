import 'package:flutter/material.dart';
import 'package:teacher_side/app/modules/messages/messages_Page.dart';
import 'package:teacher_side/app/modules/messages/messages_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MessagesModule extends WidgetModule {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => MessagesStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => MessagesPage()),
  ];

  @override
  Widget get view => MessagesPage();
}
