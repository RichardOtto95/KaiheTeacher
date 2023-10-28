import 'package:flutter/src/widgets/framework.dart';
import 'package:teacher_side/app/modules/note/note_Page.dart';
import 'package:teacher_side/app/modules/note/note_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class NoteModule extends WidgetModule {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => NoteStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => NotePage()),
  ];

  @override
  Widget get view => NotePage();
}
