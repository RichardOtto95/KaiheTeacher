import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teacher_side/app/Model/constants.dart';
import 'package:teacher_side/app/authorization_note/authorizationNote_module.dart';
import 'package:teacher_side/app/authorization_note/pages/authorizationNote_page.dart';
import 'package:teacher_side/app/modules/account_menu/account_menu_module.dart';
import 'package:teacher_side/app/modules/activity_performed/activity_performed_module.dart';
import 'package:teacher_side/app/modules/classroom/classroom_controller.dart';
import 'package:teacher_side/app/modules/classroom/classroom_module.dart';
import 'package:teacher_side/app/modules/home/home_module.dart';
import 'package:teacher_side/app/modules/home/home_store.dart';
import 'package:teacher_side/app/modules/main/main_controller.dart';
import 'package:teacher_side/app/modules/messages/messages_module.dart';
import 'package:teacher_side/shared/components/responsive.dart';
import 'package:teacher_side/shared/components/side_menu.dart';

import 'widgets/addTeacher.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends ModularState<MainPage, MainController> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   RemoteNotification? notification = message.notification;
    //   if(notification != null){
    //     print('Notification: ${notification.title}');
    //     print('Notification2: ${notification.body}');
    //     Fluttertoast.showToast(msg: notification.body!);
    //   }
    // });
    store.sendNotification();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Responsive: ${Responsive.isTablet(context)}");
    Size _size = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Responsive(
        mobile: WillPopScope(
          onWillPop: () async {
            print('WillPop main');

            if (controller.pageListIndex != 0 && controller.pageIndex == 0) {
              controller.pageListIndex = 0;
              final HomeStore homeStore = Modular.get();
              homeStore.selectedStudentsList.clear();
              homeStore.studentAttendenceMap.clear();
              homeStore.studentAttendenceAltered.clear();
              homeStore.allAreSelected = false;
              // homeStore.foodStudentsMap.clear();
              setState(() {});
            }

            return store.chatPage;
          },
          child: Listener(
            onPointerDown: (_) =>
                FocusScope.of(context).requestFocus(FocusNode()),
            child: Observer(
              builder: (context) {
                return new Scaffold(
                  key: _scaffoldKey,
                  backgroundColor: getScaffoldColor(controller.pageIndex),
                  appBar: getAppBar(
                    context: context,
                    currentPage: controller.currentPage,
                    pageListIndex: controller.pageListIndex,
                  )
                    ? AppBar(
                        bottomOpacity: 0.0,
                        elevation: 0.0,
                        leading: IconButton(
                          icon: Icon(
                            Icons.menu,
                            color: getIconColor(controller.pageIndex),
                          ),
                          onPressed: () {
                            _scaffoldKey.currentState!.openDrawer();
                          },
                        ),
                        backgroundColor: getBackgroundColor(
                            controller.pageIndex, controller.pageListIndex),
                        title: getTitle(),
                        actions: getActions(
                            controller.pageIndex, controller.pageListIndex),
                    )
                    : null,
                  body: Builder(builder: (context) {
                    if (controller.pageIndex == 6) {
                      return AuthorizationNoteModule();
                    }
                    // print("controller.pageIndex: ${controller.pageIndex}");
                    if (controller.pageIndex == 4) {
                      return AccountMenuModule();
                    }

                    if (controller.pageIndex == 3) {
                      return ClassroomModule();
                    }

                    if (controller.pageIndex == 2) {
                      return ActivityPerformedModule();
                    }

                    if (controller.pageIndex == 1) {
                      return MessagesModule();
                    }
                    return HomeModule();
                  }),
                  drawer: Responsive.isMobile(context)
                      ? Drawer(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 250),
                            child: SideMenu(),
                          ),
                        )
                      : null,
                );
              },
            ),
          ),
        ),
        desktop: Scaffold(
          body: Row(
            children: [
              Expanded(
                flex: _size.width > 1340 ? 2 : 3,
                child: SideMenu(),
              ),
              Expanded(
                flex: _size.width > 1340 ? 8 : 8,
                child: Observer(
                  builder: ((context) {
                    if (controller.pageIndex == 6) {
                      return AuthorizationNoteModule();
                    }
                    if (controller.pageIndex == 4) {
                      return AccountMenuModule();
                    }

                    if (controller.pageIndex == 5) {
                      return AddTeacherPage();
                    }

                    if (controller.pageIndex == 3) {
                      return ClassroomModule();
                    }

                    if (controller.pageIndex == 2) {
                      return ActivityPerformedModule();
                    }

                    if (controller.pageIndex == 1) {
                      return MessagesModule();
                    }
                    return HomeModule();
                  }),
                ),
              ),
            ],
          ),
        ),
        tablet: Scaffold(
          body: Row(
            children: [
              Expanded(
                flex: _size.width > 1340 ? 2 : 3,
                child: SideMenu(),
              ),
              Expanded(
                flex: _size.width > 1340 ? 8 : 8,
                child: Observer(
                  builder: ((context) {
                    if (controller.pageIndex == 6) {
                      return AuthorizationNoteModule();
                    }
                    if (controller.pageIndex == 4) {
                      return AccountMenuModule();
                    }

                    if (controller.pageIndex == 3) {
                      return ClassroomModule();
                    }

                    if (controller.pageIndex == 2) {
                      return ActivityPerformedModule();
                    }

                    if (controller.pageIndex == 1) {
                      return MessagesModule();
                    }
                    return HomeModule();
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool getAppBar({
    required BuildContext context,
    required int currentPage,
    required int pageListIndex,
  }) {
    print("pageIndex: $currentPage");
    print("pageListIndex: $pageListIndex");
    if (!Responsive.isMobile(context)) return false;

    // if (currentPage == 0 && pageListIndex == 1) return false;

    if (currentPage == 0) return true;

    if (pageListIndex == 0 || pageListIndex == 1) return true;

    return false;
  }

  Color getIconColor(int _pageIndex) {
    switch (_pageIndex) {
      case 0:
        return Colors.white;

      case 2:
        return BathroomColor;

      case 4:
        return AppColor;

      default:
        return Colors.white;
    }
  }

  Color getBackgroundColor(int _pageIndex, int _pageListIndex) {
    switch (_pageIndex) {
      case 0:
        switch (_pageListIndex) {
          case 1:
            return AttendanceColor;

          case 2:
            return FoodColor;

          case 3:
            return BathroomColor;

          case 4:
            return HomeWorkColor;

          case 5:
            return NoteColor;

          case 6:
            return MomentColor;

          case 7:
            return ReportColor;

          case 8:
            return SleepColor;

          default:
            return BathroomColor;
        }

      case 4:
        return TeacherColor;

      case 2:
        return Colors.white;

      case 1:
        return MessageColor;

      default:
        return BathroomColor;
    }
  }

  Widget? getTitle() {
    String className = 'Turma';
    Color titleColor = Colors.white;
    return Observer(builder: (context) {
      if (controller.classId != null) {
        return FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('classes')
              .doc(controller.classId)
              .get(),
          builder: (context, snapshot) {
            switch (controller.pageIndex) {
              case 0:
                if (snapshot.hasData) {
                  DocumentSnapshot? classDoc = snapshot.data;
                  className = classDoc!['name'];
                }
                break;

              case 2:
                if (snapshot.hasData) {
                  DocumentSnapshot? classDoc = snapshot.data;
                  className = classDoc!['name'];
                  titleColor = Colors.black;
                }
                break;

              case 1:
                return Container(
                  color: MessageColor,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/icons/Icon_mensagem.svg",
                          width: 26),
                      SizedBox(width: defaultPadding),
                      Text(
                        'Mensagem',
                        style: new TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );

              case 3:
                className = 'Preferência da turma';
                break;

              case 4:
                className = 'Minha conta';
                titleColor = GrayColor;
                break;

              default:
                break;
            }

            return Text(
              className,
              style: new TextStyle(
                fontSize: 18.0,
                color: titleColor,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        );
      } else {
        return Text(className,
            style: new TextStyle(
              fontSize: 18.0,
              color: titleColor,
              fontWeight: FontWeight.bold,
            ));
      }
    });
  }

  final ClassroomController classroomController = Modular.get();

  OverlayEntry? overlayEntry;

  getMenuOverlay() {
    return OverlayEntry(builder: (context) {
      return Positioned(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Material(
          color: Colors.transparent,
          child: GestureDetector(
            onTap: () {
              overlayEntry!.remove();
              overlayEntry = null;
            },
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 80, right: 20),
              alignment: Alignment.topRight,
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  overlayEntry!.remove();
                  overlayEntry = null;
                  classroomController.removingStudents =
                      !classroomController.removingStudents;
                },
                child: Container(
                  height: 30,
                  width: 160,
                  color: Colors.white,
                  alignment: Alignment.centerLeft,
                  child: Text("  Editar"),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  List<Widget>? getActions(int _pageIndex, int _pageListIndex) {
    switch (_pageIndex) {
      // case 0:
      //   if (_pageListIndex != 0) {
      //     return <Widget>[
      //       Builder(
      //         builder: (context) {
      //           return TextButton(
      //             onPressed: () {
      //               if (_pageListIndex == 1) {
      //                 print('onPressed');
      //                 final AttendenceStore attendenceStore = Modular.get();

      //                 attendenceStore.sendAttendence();
      //               }

      //               if (_pageListIndex == 7) {
      //                 final ReportController reportController = Modular.get();

      //                 reportController.toSend();
      //               }
      //             },
      //             child: Text(
      //               "Enviar",
      //               style: TextStyle(color: Colors.white),
      //             ),
      //             style: ButtonStyle(
      //               overlayColor: MaterialStateColor.resolveWith(
      //                   (states) => Colors.transparent),
      //             ),
      //           );
      //         },
      //       )
      //     ];
      //   } else {
      //     return null;
      //   }

      case 3:
        return [
          IconButton(
              onPressed: () {
                overlayEntry = getMenuOverlay();
                Overlay.of(context)!.insert(overlayEntry!);
              },
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ))
        ];

      case 4:
        return <Widget>[
          TextButton(
            onPressed: () {
              controller.enableFields = true;
            },
            child: Text("Editar"),
            style: ButtonStyle(
              overlayColor: MaterialStateColor.resolveWith(
                  (states) => Colors.transparent),
            ),
          )
        ];

      default:
        return null;
    }
  }

  Color? getScaffoldColor(int _pageIndex) {
    switch (_pageIndex) {
      case 4:
        return TeacherColor;

      // case 1:
      //   return MessageColor;

      default:
        return null;
    }
  }
}
