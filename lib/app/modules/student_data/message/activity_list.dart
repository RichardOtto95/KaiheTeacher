// import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:flutter_svg/svg.dart';
// import 'package:teacher_side/app/Model/constants.dart';
// import 'package:teacher_side/shared/components/responsive.dart';
// import 'package:teacher_side/shared/components/side_menu.dart';
// import 'activity_card.dart';

// class ActivityList extends StatefulWidget {
//   @override
//   _ActivityListState createState() => _ActivityListState();
// }

// class _ActivityListState extends State<ActivityList> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       drawer: ConstrainedBox(
//         constraints: BoxConstraints(maxWidth: 250),
//         child: SideMenu(),
//       ),
//       appBar: Responsive.isMobile(context)
//           ? AppBar(
//               shape: RoundedRectangleBorder(
//                   borderRadius:
//                       BorderRadius.vertical(bottom: Radius.circular(20))),
//               backgroundColor: MessageColor,
//               title: Row(
//                 children: [
//                   SvgPicture.asset("assets/icons/Icon_mensagem.svg", width: 26),
//                   SizedBox(width: defaultPadding),
//                   Text("Mensagem"),
//                 ],
//               ))
//           : null,
//       body: Container(
//         padding: EdgeInsets.only(top: kIsWeb ? defaultPadding : 0),
//         child: SafeArea(
//           child: Column(
//             children: [
//               Padding(
//                   padding: const EdgeInsets.all(defaultPadding),
//                   child: Row(children: [
//                     if (Responsive.isTablet(context))
//                       IconButton(
//                         icon: Icon(Icons.menu),
//                         onPressed: () {
//                           _scaffoldKey.currentState!.openDrawer();
//                         },
//                       ),
//                     if (!Responsive.isDesktop(context)) SizedBox(width: 5),
//                     Expanded(
//                       child: TextField(
//                         onChanged: (value) {},
//                         decoration: InputDecoration(
//                           hintText: "Pesquisar",
//                           fillColor: Colors.white60,
//                           filled: true,
//                           prefixIcon: Padding(
//                             padding: const EdgeInsets.all(
//                                 defaultPadding * 0.75), //15
//                             child: SvgPicture.asset(
//                               "assets/icons/Search.svg",
//                               width: 24,
//                               color: Colors.red,
//                             ),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(10)),
//                             borderSide: BorderSide(color: Colors.red),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(10)),
//                             borderSide: BorderSide(color: Colors.red),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ])),
//               // Padding(
//               //   padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
//               //   child: Row(
//               //     children: [
//               //       SvgPicture.asset("assets/Icons/Angle down.svg",
//               //           width: 16, color: Colors.red),
//               //       SizedBox(width: 5),
//               //       Text(
//               //         "Ordernar por data",
//               //         style: TextStyle(fontWeight: FontWeight.w500),
//               //       ),
//               //       Spacer(),
//               //       MaterialButton(
//               //         minWidth: 20,
//               //         onPressed: () {},
//               //         child: SvgPicture.asset(
//               //           "assets/Icons/Sort.svg",
//               //           width: 16,
//               //         ),
//               //       ),
//               //     ],
//               //   ),
//               // ),
//               // SizedBox(height: defaultPadding),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: 10,
//                   itemBuilder: (context, index) => ActivityCard(
//                     isActive: Responsive.isMobile(context) ? false : index == 0,
//                     press: () {
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(
//                       //     builder: (context) =>
//                       //         EmailScreen(email: emails[index]),
//                       //   ),
//                       // );
//                       print("Clicou na atividade!");
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
