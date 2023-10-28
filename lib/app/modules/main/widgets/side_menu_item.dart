// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:teacher_side/app/Model/constants.dart';

// import 'counter_badge.dart';

// class SideMenuItem extends StatelessWidget {
//   const SideMenuItem({
//     Key? key,
//     this.isActive = false,
//     this.isHover = false,
//     this.itemCount = 0,
//     required this.iconSrc,
//     required this.title,
//     required this.press,
//   }) : super(key: key);

//   final bool isActive, isHover;
//   final int itemCount;
//   final String title;
//   final IconData iconSrc;
//   final VoidCallback press;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: defaultPadding),
//       child: InkWell(
//         onTap: press,
//         child: Row(
//           children: [
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: (isActive || isHover) ? AppColor : Colors.transparent,
//                   borderRadius: new BorderRadius.circular(12),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Row(
//                     children: [
//                       Icon(iconSrc,
//                           color:
//                               (isActive || isHover) ? Colors.white : AppColor,
//                           size: 20),
//                       SizedBox(width: defaultPadding * 0.75),
//                       Expanded(
//                         flex: 10,
//                         child: Text(
//                           title,
//                           style: Theme.of(context).textTheme.button!.copyWith(
//                                 color: (isActive || isHover)
//                                     ? Colors.white
//                                     : GrayColor,
//                               ),
//                         ),
//                       ),
//                       Spacer(),
//                       if (itemCount != 0) CounterBadge(count: itemCount)
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
