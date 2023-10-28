import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teacher_side/app/Model/constants.dart';
import 'package:teacher_side/app/Model/neumorphism.dart';
import 'package:teacher_side/app/authorization_note/authorizationNote_module.dart';
import 'package:teacher_side/app/authorization_note/stores/authorizationNote_store.dart';
import 'package:teacher_side/app/core/models/teacher_model.dart';
import 'package:teacher_side/app/modules/home/home_store.dart';
import 'package:teacher_side/app/modules/main/main_controller.dart';
import 'package:teacher_side/shared/components/responsive.dart';
import 'side_menu_item.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);
  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final MainController mainController = Modular.get();
  final AuthorizationNoteStore authorizationNoteModule = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: EdgeInsets.only(top: kIsWeb ? defaultPadding : 0),
      color: BgLightColor,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Observer(builder: (context) {
            return Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/images/kaihe_logo.png",
                      width: 46,
                    ),
                    Spacer(),
                    if (!Responsive.isDesktop(context))
                      CloseButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                  ],
                ),
                SizedBox(height: defaultPadding),
                FutureBuilder<QuerySnapshot<Object?>>(
                  future: mainController.getClasses(),
                  builder: (context, snapshotClasses) {
                    if (!snapshotClasses.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    QuerySnapshot<Object?>? classesQuery = snapshotClasses.data;

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: classesQuery!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot classDoc = classesQuery.docs[index];

                        // print('Future classes ${classDoc['id']}');

                        return Observer(builder: (context) {
                          return ClassButton(
                            id: classDoc['id'],
                            onPressed: () {
                              print('onPressed');
                              print(
                                  "${mainController.classId} ${classDoc['id']}");

                              mainController.classId = classDoc['id'];
                              authorizationNoteModule.getNotes(classDoc['id']);
                            },
                            selected: mainController.classId == classDoc['id'],
                          );
                        });
                      },
                    );
                  },
                ),

                // Menu Items
                SideMenuItem(
                  press: () {
                    mainController.pageChange(0);
                  },
                  title: "Minha turma",
                  iconSrc: Icons.add_box_outlined,
                  isActive: mainController.pageIndex == 0,
                  //itemCount: 3,
                ),

                SideMenuItem(
                  press: () {
                    mainController.pageChange(1);
                  },
                  title: "Mensagens",
                  iconSrc: Icons.email,
                  isActive: mainController.pageIndex == 1,
                ),
                SideMenuItem(
                  press: () {
                    mainController.pageChange(2);
                  },
                  title: "Atividades Realizadas",
                  iconSrc: Icons.check_box_outlined,
                  isActive: mainController.pageIndex == 2,
                ),
                SideMenuItem(
                  press: () {
                    mainController.pageChange(3);
                  },
                  title: "Preferência da turma",
                  iconSrc: Icons.settings,
                  isActive: mainController.pageIndex == 3,
                ),
                SideMenuItem(
                  press: () {
                    mainController.pageChange(6);
                    print(mainController.pageIndex);
                  },
                  title: "Autorizações e confirmações",
                  iconSrc: Icons.check_circle_outline,
                  isActive: mainController.pageIndex == 6,
                ),

                StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('teachers')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, snapshotTeacher) {
                    String name = 'Perfil';
                    DocumentSnapshot? teacherDoc;
                    if (snapshotTeacher.hasData) {
                      teacherDoc = snapshotTeacher.data!;
                      WidgetsBinding.instance!.addPostFrameCallback((_) {
                        print('side menu teacher id: ${teacherDoc!.id}');
                        mainController.teacherModel =
                            TeacherModel.fromDocument(teacherDoc);
                      });
                      name = teacherDoc['username'];
                    }
                    return SideMenuItem(
                      press: () {
                        User? _user = FirebaseAuth.instance.currentUser;
                        mainController.getTeacherFunctionExample(_user!.uid);
                        mainController.pageChange(4);
                      },
                      title: name,
                      iconSrc: Icons.person_outline_outlined,
                      isActive: mainController.pageIndex == 4,
                    );
                  },
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class ClassButton extends StatelessWidget {
  final bool selected;
  final Function onPressed;
  final String id;

  ClassButton({
    Key? key,
    required this.selected,
    required this.onPressed,
    required this.id,
  }) : super(key: key);

  String className = 'Turma';
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('classes').doc(id).get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            DocumentSnapshot? classDoc = snapshot.data;
            className = classDoc!['name'];
          }
          return Column(
            children: [
              FlatButton.icon(
                height: 30,
                minWidth: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: defaultPadding,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: selected ? AppColor : BgDarkColor,
                onPressed: () {
                  onPressed();
                },
                icon: SvgPicture.asset("assets/icons/school.svg", width: 16),
                label: Text(
                  className,
                  style: TextStyle(color: selected ? Colors.white : TextColor),
                ),
              ).addNeumorphism(),
              SizedBox(height: defaultPadding),
            ],
          );
        });
  }
}
