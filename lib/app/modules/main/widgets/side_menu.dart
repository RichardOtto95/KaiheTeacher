// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:teacher_side/app/Model/constants.dart';
// import 'package:teacher_side/app/Model/neumorphism.dart';
// import 'package:teacher_side/app/core/models/teacher_model.dart';
// import 'package:teacher_side/app/modules/main/main_controller.dart';
// import 'package:teacher_side/shared/components/responsive.dart';
// import 'side_menu_item.dart';

// class SideMenu extends StatefulWidget {
//   final Function? onTap;

//   const SideMenu({
//     Key? key,
//     this.onTap,
//   }) : super(key: key);
//   @override
//   _SideMenuState createState() => _SideMenuState();
// }

// class _SideMenuState extends State<SideMenu> {
//   final MainController mainController = Modular.get();

//   @override
//   Widget build(BuildContext context) {
//     final double screenHeight =
//         MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
//     return Container(
//       padding: EdgeInsets.only(top: kIsWeb ? defaultPadding : 0),
//       color: BgLightColor,
//       child: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: defaultPadding),
//           child: Observer(builder: (context) {
//             return Column(
//               children: [
//                 Container(
//                   height: screenHeight * 0.7,
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Image.asset(
//                             "assets/images/kaihe_logo.png",
//                             width: 46,
//                           ),
//                           Spacer(),
//                           if (!Responsive.isDesktop(context)) CloseButton(),
//                         ],
//                       ),
//                       SizedBox(height: defaultPadding),

//                       Container(
//                         height: screenHeight * 0.2,
//                         margin: EdgeInsets.only(bottom: defaultPadding),
//                         child: FutureBuilder<QuerySnapshot<Object?>>(
//                           future: mainController.getClasses(),
//                           builder: (context, snapshotClasses) {
//                             if (!snapshotClasses.hasData) {
//                               return Center(child: CircularProgressIndicator());
//                             }

//                             QuerySnapshot<Object?>? classesQuery =
//                                 snapshotClasses.data;

//                             return ListView.builder(
//                               shrinkWrap: true,
//                               itemCount: classesQuery!.docs.length,
//                               itemBuilder: (context, index) {
//                                 DocumentSnapshot classDoc =
//                                     classesQuery.docs[index];

//                                 return ClassButton(
//                                   title: classDoc['class_id'],
//                                   onPressed: () {
//                                     print('onPressed');
//                                     mainController.classId =
//                                         classDoc['class_id'];
//                                     if (widget.onTap != null) {
//                                       widget.onTap!();
//                                     }
//                                   },
//                                   selected: mainController.classId ==
//                                       classDoc['class_id'],
//                                 );
//                               },
//                             );
//                           },
//                         ),
//                       ),

//                       // Menu Items
//                       SideMenuItem(
//                         press: () {
//                           mainController.pageIndex = 0;
//                         },
//                         title: "Minha turma",
//                         iconSrc: Icons.add_box_outlined,
//                         isActive: mainController.pageIndex == 0,
//                         itemCount: 3,
//                       ),

//                       SideMenuItem(
//                         press: () {},
//                         title: "Mensagens",
//                         iconSrc: Icons.email,
//                         isActive: mainController.pageIndex == 1,
//                       ),
//                       SideMenuItem(
//                         press: () {},
//                         title: "Atividades Realizadas",
//                         iconSrc: Icons.check_box_outlined,
//                         isActive: mainController.pageIndex == 2,
//                       ),
//                       SideMenuItem(
//                         press: () {},
//                         title: "Prefência da turma",
//                         iconSrc: Icons.settings,
//                         isActive: mainController.pageIndex == 3,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   height: screenHeight * 0.3,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//                           stream: FirebaseFirestore.instance
//                               .collection('teachers')
//                               .doc(FirebaseAuth.instance.currentUser!.uid)
//                               .snapshots(),
//                           builder: (context, snapshotTeacher) {
//                             String name = 'Perfil';
//                             if (snapshotTeacher.hasData) {
//                               DocumentSnapshot teacherDoc =
//                                   snapshotTeacher.data!;
//                               name = teacherDoc['username'];
//                               mainController.teacherModel =
//                                   TeacherModel.fromDocument(teacherDoc);
//                             }
//                             return SideMenuItem(
//                               press: () {
//                                 mainController.pageIndex = 4;
//                               },
//                               title: name,
//                               iconSrc: Icons.person_outline_outlined,
//                               isActive: mainController.pageIndex == 4,
//                             );
//                           }),
//                       SideMenuItem(
//                         press: () {
//                           mainController.signOut();
//                         },
//                         title: "Sair",
//                         iconSrc: Icons.logout,
//                         isActive: false,
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }

// class ClassButton extends StatelessWidget {
//   final bool selected;
//   final Function onPressed;
//   final String title;

//   const ClassButton({
//     Key? key,
//     required this.selected,
//     required this.onPressed,
//     required this.title,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         FlatButton.icon(
//           height: 30,
//           minWidth: double.infinity,
//           padding: EdgeInsets.symmetric(
//             vertical: defaultPadding,
//           ),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           color: selected ? AppColor : BgDarkColor,
//           onPressed: () {
//             onPressed();
//           },
//           icon: SvgPicture.asset("assets/icons/school.svg", width: 16),
//           label: Text(
//             title,
//             style: TextStyle(color: selected ? Colors.white : TextColor),
//           ),
//         ).addNeumorphism(),
//         SizedBox(height: defaultPadding),
//       ],
//     );
//   }
// }
