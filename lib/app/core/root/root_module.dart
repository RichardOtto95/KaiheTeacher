import 'package:teacher_side/app/modules/login/login_page.dart';
import 'package:teacher_side/app/modules/sign_up/sign_up_module.dart';
import 'package:teacher_side/app/modules/student_data/student_data_page.dart';

import 'root_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'root_page.dart';

class RootModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => RootController()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => RootPage()),
        ModuleRoute('/sign-up', module: SignUpModule()),
        ChildRoute(
          '/login',
          child: (_, args) => LoginPage(),
        ),
        ChildRoute(
          '/student-data-view',
          child: (_, args) => StudentDataPage(
            studentModel: args.data,
          ),
        ),
      ];
}
