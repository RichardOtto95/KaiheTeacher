import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teacher_side/app/Model/constants.dart';
import 'package:teacher_side/shared/components/responsive.dart';
import 'classroom_controller.dart';
import 'widgets/classroom_information.dart';
import 'widgets/student_list_classroom.dart';

class ClassroomPage extends StatefulWidget {
  final String title;
  const ClassroomPage({
    Key? key,
    this.title = "Classroom",
  }) : super(key: key);

  @override
  _ClassroomPageState createState() => _ClassroomPageState();
}

class _ClassroomPageState
    extends ModularState<ClassroomPage, ClassroomController> {
  final ClassroomController classroomController = Modular.get();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    controller.addStudentOverlay = OverlayEntry(
      builder: (context) => getAddStudentDialog(
        () {
          // print('onCancel');
          controller.addStudentOverlay!.remove();
        },
        context,
      ),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Responsive(
        mobile: Observer(
          builder: (context) {
            return Column(
              children: [
                // Container(
                //   padding: EdgeInsets.fromLTRB(
                //     defaultPadding,
                //     Responsive.isMobile(context)
                //         ? defaultPadding
                //         : defaultPadding * 7,
                //     defaultPadding,
                //     0,
                //   ),
                //   child: ClassRoomInformation(),
                // ),
                Expanded(child: ClassRoomInformation()),
                Expanded(child: StudentListClassRoom()),
              ],
            );
          },
        ),
        tablet: Row(
          children: [
            Expanded(
              flex: 8,
              child: StudentListClassRoom(),
            ),
            Expanded(
              flex: 6,
              child: ClassRoomInformation(),
            ),
          ],
        ),
        desktop: Row(
          children: [
            Expanded(
              flex: _size.width > 1340 ? 6 : 8,
              child: StudentListClassRoom(),
            ),
            Expanded(
              flex: _size.width > 1340 ? 5 : 7,
              child: ClassRoomInformation(),
            ),
          ],
        ),
      ),
    );
  }

  getAddStudentDialog(void Function() onCancel, BuildContext _context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: onCancel,
        child: Container(
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(_context).viewInsets.bottom),
          height: MediaQuery.of(_context).size.height,
          width: MediaQuery.of(_context).size.width,
          color: Color(0xff000000).withOpacity(0.6),
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.all(defaultPadding),
            color: AppColor,
            height: MediaQuery.of(_context).size.height * 0.255,
            width: MediaQuery.of(_context).size.width * 0.8,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Nome"),
                      SizedBox(width: defaultPadding),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: new BorderRadius.circular(7.0),
                          ),
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration.collapsed(
                              hintText: "Nome do professor",
                              border: InputBorder.none,
                            ),
                            onChanged: (String value) {
                              controller.teacherName = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Campo obrigatório';
                              }

                              return null;
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: defaultPadding,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Matrícula"),
                      SizedBox(width: defaultPadding),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: new BorderRadius.circular(7.0),
                          ),
                          child: TextFormField(
                            decoration: InputDecoration.collapsed(
                              hintText: "Kaihe1234",
                              border: InputBorder.none,
                            ),
                            onChanged: (String value) {
                              controller.teacherRegister = value;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Campo obrigatório';
                              }

                              if (value.length != 5) {
                                return 'Campo deve conter 5 dígitos';
                              }

                              return null;
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        controller.addTeacher(context);
                      }
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
