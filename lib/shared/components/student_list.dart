import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teacher_side/app/Model/constants.dart';
import 'package:teacher_side/app/core/empty_states/noStudantAtClass.dart';
import 'package:teacher_side/app/core/models/student_model.dart';
import 'package:teacher_side/app/modules/home/home_store.dart';
import 'package:teacher_side/app/modules/main/main_controller.dart';
import 'package:teacher_side/shared/components/responsive.dart';
import 'package:teacher_side/shared/components/student_cell.dart';
import 'package:teacher_side/shared/components/student_food_cell.dart';

class StudentList extends StatefulWidget {
  const StudentList({Key? key}) : super(key: key);

  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(bottom: defaultPadding),
        child: Column(
          children: [
            // if (Responsive.isMobile(context))
            //   Padding(
            //     padding: const EdgeInsets.fromLTRB(
            //         defaultPadding, defaultPadding, 0, defaultPadding),
            //     child: Row(
            //       children: [
            //         // if (!Responsive.isDesktop(context))
            //           IconButton(
            //             icon: Icon(Icons.menu),
            //             onPressed: () {
            //               _scaffoldKey.currentState!.openDrawer();
            //             },
            //           )
            //       ],
            //     ),
            //   ),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      if (!Responsive.isMobile(context))
                        Text(
                          "Atividades",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      SizedBox(height: defaultPadding),
                      Text(
                        "Selecionar estudantes",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
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
      ),
    );
  }
}

class StudentCellGridView extends StatelessWidget {
  StudentCellGridView({
    Key? key,
    this.crossAxisCount = 4,
  });

  final MainController mainController = Modular.get();
  final HomeStore homeStore = Modular.get();
  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      // return FutureBuilder<List<DocumentSnapshot>>(
      return FutureBuilder(
        future: homeStore.getStudents(mainController.classId),
        // future: FirebaseFirestore.instance
        //   .collection('classes')
        //   .doc('qcni9vxwQaQp5gWRaqWP')
        //   .collection("students")
        //   .orderBy('username', descending: false)
        //   .get(),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            print(snapshot.error);
            return Container();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
        

          // List<DocumentSnapshot>? studentsQuery = snapshot.data;
          dynamic studentsQuery = snapshot.data;
          if(studentsQuery!.length == 0){
              return Container(child: NoStudentAtClass());
          }
          return GridView.builder(
            addAutomaticKeepAlives: true,
            addRepaintBoundaries: true,
            padding: EdgeInsets.only(bottom: defaultPadding),
            itemCount: studentsQuery!.length + 1,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: defaultPadding,
            ),
            itemBuilder: (context, index) {
              if (index == 0) {
                return _selectAll(context);
              }
              return Observer(
                builder: (context) {
                  DocumentSnapshot studentDoc = studentsQuery[index - 1];
                  StudentModel studentModel =
                      StudentModel.fromDocument(studentDoc);
                  if (mainController.pageListIndex == 2 &&
                      homeStore.whatValue == 0) {
                    // if (homeStore.foodStudentsMap.isEmpty) {
                    //   return Center(child: CircularProgressIndicator());
                    // }
                    return StudentFoodCell(studentModel: studentModel);
                  }
                  return StudentCell(
                    studentModel: studentModel,
                  );
                },
              );
            },
          );
        },
      );
    });
  }

  Widget _selectAll(context) {
    return Stack(
      children: [
        TextButton(
          style: ButtonStyle(
            overlayColor:
                MaterialStateColor.resolveWith((states) => Colors.transparent),
          ),
          onPressed: () {
            homeStore.selectAll();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                  child: 
                  // Image.asset(
                  //   "assets/images/person.jpeg",
                  //   height: 80,
                  //   width: 80,
                  //   fit: BoxFit.cover,
                  // ),
                  Icon(
                    Icons.people_alt,
                    size: 80,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 32,
                    child: Center(
                      child: Text(
                        "Selecionar todos",
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
            Observer(
              builder: (context) {
                return Container(
                  width: 20,
                  height: 20,
                  decoration: new BoxDecoration(
                    color:
                        homeStore.allAreSelected ? Colors.green : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                );
              },
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
