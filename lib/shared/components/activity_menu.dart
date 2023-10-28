import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teacher_side/app/Model/constants.dart';
import 'package:teacher_side/app/modules/home/home_store.dart';
import 'package:teacher_side/app/modules/main/main_controller.dart';
import 'package:teacher_side/shared/components/responsive.dart';

class ActivityMenu extends StatelessWidget {
  final HomeStore homeStore = Modular.get();
  final MainController mainController = Modular.get();

  ActivityMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var padding = Responsive.isDesktop(context) ? 2.3 : 1.0;

    return Padding(
      padding: EdgeInsets.only(top: Responsive.isMobile(context) ? 20 : 100),
      child: Stack(children: [
        Container(
          width: double.infinity,
          decoration: !Responsive.isMobile(context)
              ? BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/images/activity_menu.png"),
                  ),
                )
              : null,
          child: Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  Responsive.isMobile(context)
                      ? defaultPadding
                      : defaultPadding * 3.5,
                  Responsive.isMobile(context)
                      ? defaultPadding
                      : defaultPadding * 4,
                  Responsive.isMobile(context)
                      ? defaultPadding
                      : defaultPadding * 5,
                  defaultPadding * 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(defaultPadding * padding,
                          padding, defaultPadding * padding, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MenuCell(
                            color: AttendanceColor,
                            asset: "assets/icons/Icon_chamada.svg",
                            text: "Chamada",
                            isWhite: true,
                            onPressed: () {
                              mainController.pageListIndex = 1;
                              mainController.pageController.jumpTo(0);
                            }),
                          SizedBox(
                            width: defaultPadding,
                          ),
                          MenuCell(
                            color: FoodColor,
                            asset: "assets/icons/icon_alimentacao.svg",
                            text: "Alimentação",
                            isWhite: true,
                            onPressed: () {
                              mainController.pageListIndex = 2;
                              // homeStore.getClasseStudents();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: defaultPadding * 2),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(defaultPadding * padding,
                          padding, defaultPadding * padding, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MenuCell(
                            color: BathroomColor,
                            asset: "assets/icons/Icon_banheiro.svg",
                            text: "Banheiro",
                            isWhite: false,
                            onPressed: () {
                              mainController.pageListIndex = 3;
                            },
                          ),
                          SizedBox(
                            width: defaultPadding,
                          ),
                          MenuCell(
                            color: HomeWorkColor,
                            asset: "assets/icons/Icon_deverdecasa.svg",
                            text: "Dever de casa",
                            isWhite: false,
                            onPressed: () {
                              mainController.pageListIndex = 4;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: defaultPadding * 2),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(defaultPadding * padding,
                          padding, defaultPadding * padding, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MenuCell(
                            color: NoteColor,
                            asset: "assets/icons/Icon_bilhete.svg",
                            text: "Bilhete",
                            isWhite: false,
                            onPressed: () {
                              mainController.pageListIndex = 5;
                            },
                          ),
                          SizedBox(
                            width: defaultPadding,
                          ),
                          MenuCell(
                            color: MomentColor,
                            asset: "assets/icons/Icon_momentos.svg",
                            text: "Momento",
                            isWhite: false,
                            onPressed: () {
                              mainController.pageListIndex = 6;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: defaultPadding * 2),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(defaultPadding * padding, 0,
                          defaultPadding * padding, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MenuCell(
                            color: ReportColor,
                            asset: "assets/icons/Icon_registro.svg",
                            text: "Relatórios",
                            isWhite: false,
                            onPressed: () {
                              mainController.pageListIndex = 7;
                            },
                          ),
                          SizedBox(
                            width: defaultPadding,
                          ),
                          MenuCell(
                            color: SleepColor,
                            asset: "assets/icons/icon_soneca.svg",
                            text: "Soneca",
                            isWhite: false,
                            onPressed: () {
                              mainController.pageListIndex = 8;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class MenuCell extends StatelessWidget {
  const MenuCell({
    Key? key,
    required this.color,
    required this.asset,
    required this.text,
    required this.isWhite,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final Color color;
  final String asset;
  final bool isWhite;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: () {
          onPressed();
        },
        child: Container(
          decoration: BoxDecoration(
            color: this.color,
            borderRadius: const BorderRadius.all(Radius.circular(14)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: defaultPadding / 2),
              SvgPicture.asset(
                this.asset,
                height: 50,
                color: isWhite ? Colors.white : null,
              ),
              SizedBox(height: defaultPadding * 0.17),
              Center(
                child: Text(
                  this.text,
                  maxLines: 2,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        style: ButtonStyle(
            overlayColor:
                MaterialStateColor.resolveWith((states) => Colors.transparent)),
      ),
    );
  }
}
