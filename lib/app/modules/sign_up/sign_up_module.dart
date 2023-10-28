import 'sign_up_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'sign_up_page.dart';

class SignUpModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => SignUpController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => SignUpPage()),
  ];
}
