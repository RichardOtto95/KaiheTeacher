// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:teacher_side/app/Model/constants.dart';
// import 'package:teacher_side/shared/components/responsive.dart';

// class ActivityScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: Colors.white,
//         child: SafeArea(
//           child: Column(
//             children: [
//               Header(),
//               Divider(thickness: 1),
//               Expanded(
//                 child: SingleChildScrollView(
//                   padding: EdgeInsets.all(defaultPadding),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       CircleAvatar(
//                         maxRadius: 24,
//                         backgroundColor: Colors.transparent,
//                         backgroundImage: AssetImage("assets/images/Foto.png"),
//                       ),
//                       SizedBox(width: defaultPadding),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text.rich(
//                                         TextSpan(
//                                           text: "Nome da atividade",
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .button,
//                                           children: [
//                                             TextSpan(
//                                                 text: "  Suellen - Mãe",
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .caption),
//                                           ],
//                                         ),
//                                       ),
//                                       Text(
//                                         "Deu ruim hoje prof",
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .headline6,
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(width: defaultPadding / 2),
//                                 Text(
//                                   "Hoje 15:32",
//                                   style: Theme.of(context).textTheme.caption,
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: defaultPadding),
//                             LayoutBuilder(
//                               builder: (context, constraints) => SizedBox(
//                                 width: constraints.maxWidth > 850
//                                     ? 800
//                                     : constraints.maxWidth,
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       "Êh, êh-êh-êh, êh-êh\nIsso é pegada de vaqueiro\nJoão Gomes tá na voz\nMeu pedaço de pecado\nDe corpo colado, vem dançar comigo\nQuero ser teu namorado\nFicar do seu lado e falar no ouvido que...\nVocê é a mais bonita\nUm pedaço da vida, de felicidade\nVem matar logo o desejo\nFaz esse vaqueiro feliz de verdade\nVem matar logo de beijo\nEu quando te vejo acabo com a saudade",
//                                       style: TextStyle(
//                                         height: 1.5,
//                                         color: Color(0xFF4D5875),
//                                         fontWeight: FontWeight.w300,
//                                       ),
//                                     ),
//                                     SizedBox(height: defaultPadding),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class Header extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(defaultPadding),
//       child: Row(
//         children: [
//           // We need this back button on mobile only
//           if (Responsive.isMobile(context)) BackButton(),
//           IconButton(
//             icon: SvgPicture.asset(
//               "assets/Icons/Trash.svg",
//               width: 24,
//             ),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: SvgPicture.asset(
//               "assets/Icons/Reply.svg",
//               width: 24,
//             ),
//             onPressed: () {},
//           ),

//           Spacer(),
//           // We don't need print option on mobile
//           if (Responsive.isDesktop(context))
//             IconButton(
//               icon: SvgPicture.asset(
//                 "assets/Icons/More vertical.svg",
//                 width: 24,
//               ),
//               onPressed: () {},
//             ),
//         ],
//       ),
//     );
//   }
// }
