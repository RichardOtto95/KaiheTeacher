import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teacher_side/app/Model/constants.dart';
import 'package:teacher_side/app/core/models/student_model.dart';
import 'package:teacher_side/app/modules/attendence/attendence_store.dart';
import 'package:teacher_side/app/modules/home/home_store.dart';
import 'package:teacher_side/app/modules/main/main_controller.dart';
import 'package:teacher_side/shared/components/responsive.dart';
import '../../../Animations/Loader.dart';
import 'attendence_student_cell.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


class AtendenceStudentList extends StatefulWidget {
  const AtendenceStudentList({Key? key}) : super(key: key);

  @override
  _AtendenceStudentListState createState() => _AtendenceStudentListState();
}

class _AtendenceStudentListState extends State<AtendenceStudentList> {
  final MainController mainController = Modular.get();
  final AttendenceStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(bottom: defaultPadding),
        child: Column(
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
            Responsive.isMobile(context) ?                
            topMenu() : Container(),
            kIsWeb ? Container()
            : Container(
              height: 110,
              padding: const EdgeInsets.all(defaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(5, (index) {
                  return studentSatus(index);
                }),
              ),
            ),
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
                mobile: AttendenceStudentCellGridView(
                  crossAxisCount: _size.width < 650 ? 3 : 5,
                ),
                tablet: AttendenceStudentCellGridView(
                  crossAxisCount: 5,
                ),
                desktop: AttendenceStudentCellGridView(
                  crossAxisCount: 5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Container topMenu() {
    return !kIsWeb ?
    Container(
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 1))
          ],
          color: AttendanceColor,
          borderRadius: new BorderRadius.only(
              bottomLeft: Radius.circular(17.0),
              bottomRight: Radius.circular(17.0))),
      width: MediaQuery.of(context).size.width,
      // padding: EdgeInsets.symmetric(horizontal: 22),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 100,
              height: 40,
              child: TextButton(
                onPressed: () {
                  // print("Voltar para tela de atividades");
                  mainController.pageListIndex = 0;
                },
                child: Row(
                  children: [
                    // Icon(
                    //   Icons.arrow_back_ios,
                    //   color: Colors.white,
                    // ),
                    Text(
                      "Cancelar",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 16),
                    ),
                  ],
                ),
                style: ButtonStyle(
                    overlayColor: MaterialStateColor.resolveWith(
                        (states) => Colors.transparent)),
              ),
            ),
            Row(children: [
              SvgPicture.asset(
                "assets/icons/Icon_chamada.svg",
                height: 40,
                width: 40,
                color: Colors.white,
              ),
              SizedBox(width: defaultPadding),
              Text("Chamada",
                  style: TextStyle(color: Colors.white, fontSize: 16))
            ]),
            Container(
              width: 100,
              height: 40,
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () async{
                  // print("Apagar os dados");
                  await store.sendAttendence(context).then((value) => {
                    if(value){
                      showDialog(context: context, builder: (context){
                        Future.delayed(Duration(seconds: 3), (){
                          Navigator.pop(context);    
                        }).then((value) => (){
                          Navigator.pop(context);
                        }); 
                        return  ColorLoader();
                      })
                    
                    }
                  });                
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/send.svg",
                      height: 16,
                      width: 16,
                      color: Colors.white,
                    ),
                    SizedBox(width: 3),
                    Text(
                      "Enviar",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 16),
                    ),
                  ],
                ),
                style: ButtonStyle(
                    overlayColor: MaterialStateColor.resolveWith(
                        (states) => Colors.transparent)),
              ),
            ),
          ]),
    ): Container();
  }
}

class AttendenceStudentCellGridView extends StatelessWidget {
  AttendenceStudentCellGridView({
    Key? key,
    this.crossAxisCount = 4,
  });

  final MainController mainController = Modular.get();
  final HomeStore homeStore = Modular.get();
  // final AttendenceStore store = Modular.get();
  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return FutureBuilder<List<DocumentSnapshot>>(
        future: homeStore.getStudents(mainController.classId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          List<DocumentSnapshot>? studentsQuery = snapshot.data;
          return GridView.builder(
            addAutomaticKeepAlives: true,
            addRepaintBoundaries: true,
            padding: EdgeInsets.only(bottom: defaultPadding),
            itemCount: studentsQuery!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: defaultPadding,
            ),
            itemBuilder: (context, index) {
              DocumentSnapshot studentDoc = studentsQuery[index];
              StudentModel studentModel = StudentModel.fromDocument(studentDoc);
              // homeStore.studentAttendenceMap
              //     .putIfAbsent(studentDoc.id, () => null);
              homeStore.getStudentStatusColor(studentDoc.id);
              return AttendenceStudentCell(
                studentModel: studentModel,
              );
            },
          );
        },
      );
    });
  }
}

Widget studentSatus(int index) {
  List colorsList = [
    Colors.green,
    Colors.red,
    Colors.orange,
    Colors.blue,
    Colors.purple,
  ];

  return Column(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Stack(
          children: [
            Container(
              height: 60,
              width: 60,
              color: AttendanceColorAlpha,
              child: Icon(
                Icons.person,
                color: Colors.blue,
                size: 40,
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 15,
                height: 15,
                decoration: new BoxDecoration(
                  color: colorsList[index],
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
      Text(
        getTitle(index),
      ),
    ],
  );
}

String getTitle(int index) {
  switch (index) {
    case 0:
      return 'Presente';

    case 1:
      return 'Faltou';

    case 2:
      return 'Atrasado';

    case 3:
      return 'Adiantado';

    case 4:
      return 'Virtual';

    default:
      return '';
  }
}
