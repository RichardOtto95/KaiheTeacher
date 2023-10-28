import 'student_data_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'student_data_page.dart';

class StudentDataModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => StudentDataController()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/',
        child: (_, args) => StudentDataPage(
              studentModel: args.data,
            )),
  ];
}
