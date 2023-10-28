// import 'package:flutter/material.dart';
// import 'package:teacher_side/shared/components/responsive.dart';
// import 'package:teacher_side/shared/components/side_menu.dart';
// // import 'package:teacher_side/Controller/responsive.dart';
// // import 'package:teacher_side/View/StudentData/Message/activity_list.dart';
// // import 'package:teacher_side/View/StudentData/Message/activity_screen.dart';
// // import 'package:teacher_side/View/components/side_menu.dart';

// class ActivityView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Size _size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Responsive(
//         mobile: ActivityScreen(),
//         tablet: Row(
//           children: [
//             Expanded(
//               flex: 6,
//               child: ActivityList(),
//             ),
//             Expanded(
//               flex: 9,
//               child: ActivityScreen(),
//             ),
//           ],
//         ),
//         desktop: Row(
//           children: [
//             Expanded(
//               flex: _size.width > 1340 ? 2 : 3,
//               child: SideMenu(),
//             ),
//             Expanded(
//               flex: _size.width > 1340 ? 4 : 6,
//               child: ActivityList(),
//             ),
//             Expanded(
//               flex: _size.width > 1340 ? 7 : 9,
//               child: ActivityScreen(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
