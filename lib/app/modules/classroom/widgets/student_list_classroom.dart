import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teacher_side/app/Model/constants.dart';
import 'package:teacher_side/app/core/models/student_model.dart';
import 'package:teacher_side/app/modules/classroom/classroom_controller.dart';
import 'package:teacher_side/app/modules/classroom/widgets/student_cell_classroom.dart';
import 'package:teacher_side/app/modules/home/home_store.dart';
import 'package:teacher_side/app/modules/main/main_controller.dart';
import 'package:teacher_side/shared/components/responsive.dart';

class StudentListClassRoom extends StatefulWidget {
  const StudentListClassRoom({Key? key}) : super(key: key);

  @override
  _StudentListClassRoomState createState() => _StudentListClassRoomState();
}

class _StudentListClassRoomState extends State<StudentListClassRoom> {
  OverlayEntry? overlayEntry;
  final ClassroomController classroomController = Modular.get();

  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(bottom: defaultPadding),
      child: Stack(
        children: [
          Column(
            children: [
              if (!Responsive.isMobile(context))
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      defaultPadding, defaultPadding, 0, defaultPadding),
                  child: Row(
                    children: [
                      if (!Responsive.isDesktop(context))
                        IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: () {
                            // _scaffoldKey.currentState!.openDrawer();
                          },
                        )
                    ],
                  ),
                ),
              if (!Responsive.isMobile(context))
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Atividades",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    IconButton(
                      onPressed: () {
                        if (overlayEntry != null && overlayEntry!.mounted) {
                          overlayEntry!.remove();
                          overlayEntry = null;
                        } else {
                          overlayEntry = getMenuOverlay();
                          Overlay.of(context)!.insert(overlayEntry!);
                        }
                      },
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              Expanded(
                child: Responsive(
                  mobile: StudentCellGridView(
                    crossAxisCount: _size.width < 650 ? 3 : 5,
                  ),
                  tablet: StudentCellGridView(
                    crossAxisCount: 5,
                  ),
                  desktop: StudentCellGridView(
                    crossAxisCount: 5,
                  ),
                ),
              ),
            ],
          ),
          Observer(builder: (context) {
            return Positioned(
              bottom: 20,
              right: 10,
              child: Visibility(
                visible: classroomController.removingStudents,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        classroomController.removingStudents = false;
                        classroomController.removeStudentsList.clear();
                      },
                      child: Container(
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.red),
                          alignment: Alignment.center,
                          child: Text(
                            "Cancelar",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    SizedBox(height: 15),
                    Visibility(
                      visible:
                          classroomController.removeStudentsList.isNotEmpty,
                      child: InkWell(
                        onTap: () =>
                            classroomController.removeStudents(context),
                        child: Container(
                            height: 30,
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: Colors.red),
                            alignment: Alignment.center,
                            child: Text(
                              "Concluir",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  getMenuOverlay() {
    final ClassroomController store = Modular.get();

    return OverlayEntry(builder: (context) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            overlayEntry!.remove();
            overlayEntry = null;
          },
          child: Container(
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Color(0xff000000).withOpacity(0.6),
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                overlayEntry!.remove();
                overlayEntry = null;
                store.removingStudents = !store.removingStudents;
              },
              child: Container(
                height: 30,
                width: 160,
                color: Colors.white,
                alignment: Alignment.center,
                child: Text("  Editar"),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class StudentCellGridView extends StatefulWidget {
  StudentCellGridView({Key? key, this.crossAxisCount = 4});

  final int crossAxisCount;

  @override
  State<StudentCellGridView> createState() => _StudentCellGridViewState();
}

class _StudentCellGridViewState extends State<StudentCellGridView> {
  final ClassroomController controller = Modular.get();

  final MainController mainController = Modular.get();

  final HomeStore homeStore = Modular.get();

  final _formKey = GlobalKey<FormState>();

  String studentName = "";

  String matricula = "";

  @override
  Widget build(BuildContext buildContext) {
    return Observer(builder: (context) {
      return FutureBuilder<List<DocumentSnapshot>>(
        future: homeStore.getStudents(mainController.classId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          List<DocumentSnapshot>? studentsQuery = snapshot.data;

          // print("studentsQuery: ${studentsQuery!.length}");
          return GridView.builder(
            addAutomaticKeepAlives: true,
            addRepaintBoundaries: true,
            padding: EdgeInsets.only(bottom: defaultPadding),
            itemCount: studentsQuery!.length + 1,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.crossAxisCount,
              mainAxisSpacing: defaultPadding,
            ),
            itemBuilder: (context, index) {
              if (index == 0) {
                return addStudent(buildContext);
              }
              // print("index - 1: ${index - 1}");
              // print("studentsQuery: ${studentsQuery.first.data()}");
              int _index = index - 1;
              DocumentSnapshot studentDoc = studentsQuery[_index];
              StudentModel studentModel = StudentModel.fromDocument(studentDoc);
              return StudentCellClassRoom(
                studentModel: studentModel,
              );
            },
          );
        },
      );
    });
  }

  late OverlayEntry? overlayEntry;

  getOverlay(buildContext) {
    return OverlayEntry(builder: (context) {
      return Positioned(
          child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () => overlayEntry!.remove(),
          child: Container(
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Color(0xff000000).withOpacity(0.6),
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(defaultPadding),
              color: AppColor,
              height: MediaQuery.of(context).size.height * 0.255,
              width: MediaQuery.of(context).size.width * 0.8,
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
                                hintText: "Nome do aluno",
                                border: InputBorder.none,
                              ),
                              onChanged: (String value) {
                                studentName = value;
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
                                matricula = value;
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
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          bool allRight = await controller.addStudent(
                              buildContext, studentName, matricula, () {
                            setState(() {});
                          });
                          if (allRight) {
                            overlayEntry!.remove();
                            overlayEntry = null;
                            studentName = "";
                            matricula = "";
                          }
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
      ));
    });
  }

  addStudent(context) {
    return Stack(
      children: [
        TextButton(
          style: ButtonStyle(
            overlayColor:
                MaterialStateColor.resolveWith((states) => Colors.transparent),
          ),
          onPressed: () {
            overlayEntry = getOverlay(context);
            Overlay.of(context)!.insert(overlayEntry!);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                  child: Icon(
                    Icons.people_alt,
                    size: 80,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 32,
                    child: Center(
                      child: Text(
                        "Adicionar estudante",
                        maxLines: 2,
                        style: TextStyle(color: Colors.black),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.add,
              color: Colors.green,
            ),
            SizedBox(
              width: defaultPadding,
            )
          ],
        ),
      ],
    );
  }
}
