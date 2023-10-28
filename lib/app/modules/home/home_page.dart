import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teacher_side/app/core/empty_states/noConnection.dart';
import 'package:teacher_side/app/core/root/root_controller.dart';
import 'package:teacher_side/app/modules/bathroom/bathroom_module.dart';
import 'package:teacher_side/app/modules/food/food_module.dart';
import 'package:teacher_side/app/modules/home/home_store.dart';
import 'package:teacher_side/app/modules/homework/homework_module.dart';
import 'package:teacher_side/app/modules/main/main_controller.dart';
import 'package:teacher_side/app/modules/moment/moment_module.dart';
import 'package:teacher_side/app/modules/note/note_module.dart';
import 'package:teacher_side/app/modules/report/report_module.dart';
import 'package:teacher_side/app/modules/sleep/sleep_module.dart';
import 'package:teacher_side/shared/components/activity_menu.dart';
import 'package:teacher_side/shared/components/responsive.dart';
import 'package:teacher_side/shared/components/student_list.dart';
import '../attendence/attendence_module.dart';
import 'widgets/attendence_student_list.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  final MainController mainController = Modular.get();
  final RootController rootController = Modular.get();
  List<Widget> pageList = [
    ActivityMenu(),
    AttendenceModule(),
    FoodModule(),
    BathroomModule(),
    HomeworkModule(),
    NoteModule(),
    MomentModule(),
    ReportModule(),
    SleepModule(),
  ];

  @override
  void initState() {
    rootController.checkConnectivityState().then((value) => {
          if (value)
            {}
          else
            {
              showDialog(
                  context: context,
                  builder: (context) {
                    return NoConnection();
                  })
            }
        });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        print('WillPop home');
        mainController.pageListIndex = 0;

        if (mainController.pageListIndex != 0) {
          mainController.pageListIndex = 0;
          store.selectedStudentsList.clear();
          store.studentAttendenceMap.clear();
          store.studentAttendenceAltered.clear();
          // store.foodStudentsMap.clear();
          store.allAreSelected = false;
        }
        return false;
      },
      child: Responsive(
        mobile: Observer(builder: (context) {
          // print('Observer: ${mainController.pageListIndex}');
          return PageView(
            physics: mainController.pageListIndex == 1
                ? NeverScrollableScrollPhysics()
                : null,
            children: [
              mainController.pageListIndex == 1
                  ? AtendenceStudentList()
                  : StudentList(),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 0),
                child: pageList[mainController.pageListIndex],
              )
            ],
            onPageChanged: (value) {
              mainController.currentPage = value;
            },
            controller: mainController.pageController,
          );
        }),
        tablet: Row(
          children: [
            Expanded(
              flex: 8,
              child: Observer(builder: (context) {
                print('Observer: ${mainController.pageListIndex}');
                if (mainController.pageListIndex == 1) {
                  return AtendenceStudentList();
                } else {
                  return StudentList();
                }
              }),
            ),
            Expanded(
              flex: 6,
              child: Observer(builder: (context) {
                return AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
                  child: pageList[mainController.pageListIndex],
                );
              }),
            ),
          ],
        ),
        desktop: Row(
          children: [
            Expanded(
              flex: _size.width > 1340 ? 6 : 8,
              child: Observer(builder: (context) {
                print('Observer: ${mainController.pageListIndex}');
                if (mainController.pageListIndex == 1) {
                  return AtendenceStudentList();
                } else {
                  return StudentList();
                }
              }),
            ),
            Expanded(
              flex: _size.width > 1340 ? 5 : 7,
              child: Observer(builder: (context) {
                return AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
                  child: pageList[mainController.pageListIndex],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
