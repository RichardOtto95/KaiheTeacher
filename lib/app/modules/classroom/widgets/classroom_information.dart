import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teacher_side/app/Model/constants.dart';
import 'package:teacher_side/app/modules/classroom/classroom_controller.dart';
import 'package:teacher_side/app/modules/main/main_controller.dart';
import 'package:teacher_side/shared/components/responsive.dart';

class ClassRoomInformation extends StatefulWidget {
  // final void Function() onPressed;
  ClassRoomInformation({
    Key? key,
    // required this.onPressed,
  }) : super(key: key);

  @override
  _ClassRoomInformationState createState() => _ClassRoomInformationState();
}

class _ClassRoomInformationState extends State<ClassRoomInformation> {
  final ClassroomController classroomController = Modular.get();
  final MainController mainController = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Observer(builder: (context) {
          return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('classes')
                  .doc(mainController.classId)
                  .snapshots(),
              builder: (context, snapshot) {
                String? avatar;
                String? name;
                if (snapshot.hasData) {
                  DocumentSnapshot classDoc = snapshot.data!;
                  avatar = classDoc['avatar'];
                  name = classDoc['name'];
                }

                return Row(
                  children: [
                    avatar == null
                      ? Image.asset(
                        "assets/images/person.jpeg",
                        height: Responsive.isMobile(context) ? 170 : 210,
                        width: Responsive.isMobile(context) ? 170 : 200,
                        fit: BoxFit.cover,
                      )
                        // ? Container(
                        //     height: Responsive.isMobile(context) ? 170 : 210,
                        //     width: Responsive.isMobile(context) ? 170 : 200,
                        //     child: Center(
                        //       child: CircularProgressIndicator(),
                        //     ),
                        //   )
                        : GestureDetector(
                            onTap: () {
                              classroomController.setClassroomImage(context);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(7.0),
                              child: CachedNetworkImage(
                                imageUrl: avatar,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            AppColor),
                                    value: downloadProgress.progress,
                                    strokeWidth: 4,
                                  ),
                                ),
                                height:
                                    Responsive.isMobile(context) ? 170 : 210,
                                width: Responsive.isMobile(context) ? 170 : 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                    SizedBox(width: defaultPadding),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Nome da turma"),
                              SizedBox(height: 10),
                              Container(
                                height: 45,
                                decoration: BoxDecoration(
                                  color: ClassColor,
                                  borderRadius: new BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Text(name ?? ""),
                                ),
                              ),
                              SizedBox(height: defaultPadding),
                              Text("Login"),
                              SizedBox(height: 10),
                              Container(
                                height: 45,
                                decoration: BoxDecoration(
                                  color: ClassColor,
                                  borderRadius: new BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child:
                                      Text(mainController.teacherModel!.email),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              });
        }),
        SizedBox(
          height: defaultPadding,
        ),
        Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Container(
              height: 45,
              decoration: BoxDecoration(
                color: ClassColor,
                borderRadius: new BorderRadius.circular(12),
              ),
              child: Center(
                child: Text("Professores"),
              ),
            ),
            InkWell(
              // onTap: widget.onPressed,
              onTap: () {
                // classroomController.addStudentOverlay = OverlayEntry(
                //   builder: (context) => AddStudent(
                //     onCancel: () {
                //       print('onCancel');
                //       classroomController.addStudentOverlay!.remove();
                //     },
                //   ),
                // );
                Overlay.of(context)!
                    .insert(classroomController.addStudentOverlay!);
              },
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: AppColor,
                  borderRadius: new BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(
                    Icons.add,
                    color: GrayColor,
                    size: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: defaultPadding,
        ),
        Expanded(
          child: Observer(
            builder: (context) {
              return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('classes').doc(mainController.classId).collection('teachers').snapshots(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData)
                    return Center(child: CircularProgressIndicator());

                  QuerySnapshot teachers = snapshot.data!;
                  print('teachers: ${teachers.docs.length}');
                  return ListView.builder(
                    itemCount: teachers.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot teacherDoc = teachers.docs[index];
                      return TeacherBox(
                        teacherId: teacherDoc.id,
                      );
                    }
                  );
                }
              );
            }
          ),
        ),        
      ],
    );
  }
}

class TeacherBox extends StatelessWidget {
  final String teacherId;

  const TeacherBox({Key? key, required this.teacherId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('teachers').doc(teacherId).get(),
      builder: (context, snapshot) {
        // bool hasData = snapshot.hasData;
        DocumentSnapshot? teacherDoc = snapshot.data;
        // if (hasData){
        //   teacherDoc = snapshot.data;
        // }
        return Container(
          margin: EdgeInsets.only(bottom: defaultPadding),
          padding: EdgeInsets.only(left: defaultPadding),
          height: 70,
          decoration: BoxDecoration(
            color: ClassColor,
            borderRadius: new BorderRadius.circular(12),
          ),
          // child: teacherDoc == null ?
          child: teacherDoc == null ?
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(7.0),
                child: Container(
                  height: 65,
                  width: 65,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ) : Row(children: [
            ClipRRect(
                  borderRadius: BorderRadius.circular(7.0),
              child: teacherDoc['avatar'] == null
                ? Image.asset(
                  "assets/images/person.jpeg",
                  height: 65,
                  width: 65,
                  fit: BoxFit.cover,
                )
                : CachedNetworkImage(
                  imageUrl: teacherDoc['avatar'],
                  progressIndicatorBuilder:
                      (context, url, downloadProgress) => Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(AppColor),
                      value: downloadProgress.progress,
                      strokeWidth: 4,
                    ),
                  ),
                  height: 65,
                  width: 65,
                  fit: BoxFit.cover,
                ),
            ),
            Text(teacherDoc['username']),
          ]),
        );
      }
    );
  }
}