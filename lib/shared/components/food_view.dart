import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:teacher_side/app/Model/constants.dart';
import 'package:teacher_side/app/modules/home/home_store.dart';
import 'package:teacher_side/app/modules/main/main_controller.dart';
import 'package:teacher_side/shared/components/responsive.dart';

import 'custom_textField.dart';

class FoodView extends StatefulWidget {
  FoodView({Key? key}) : super(key: key);

  @override
  _FoodViewState createState() => _FoodViewState();
}

class _FoodViewState extends State<FoodView>
    with AutomaticKeepAliveClientMixin {
  final HomeStore homeStore = Modular.get();
  final MainController mainController = Modular.get();
  int whatValue = 0;
  int whichValue = 1;

  final _formKey = GlobalKey<FormState>();
  String _text = "";
  bool bootle = false;
  late PageController pageController;
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    textEditingController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        floatingActionButton: Observer(
          builder: (context) {
            if (mainController.currentPage == 1) {
              return InkWell(
                onTap: () {
                  if (whatValue == 1 && homeStore.amtWater == 0) {
                    Fluttertoast.showToast(
                        msg: "Defina uma quantidade de água");
                  } else {
                    String mealOfTheDay = "";
                    switch (whichValue) {
                      case 1:
                        mealOfTheDay = "BREAKFAST";
                        break;
                      case 2:
                        mealOfTheDay = "LUNCH";
                        break;
                      case 3:
                        mealOfTheDay = "SNACK";
                        break;
                      case 4:
                        mealOfTheDay = "DINNER";
                        break;
                      default:
                    }
                    homeStore.sendFoodData(whatValue == 0 ? "FOOD" : "WATER",
                        mealOfTheDay, _text, context, getMessage());
                    mainController.currentPage = 0;
                  }
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: FoodColor,
                  ),
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              );
            }
            return Container();
          },
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Column(
            children: [
              if (Responsive.isMobile(context))
                Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: Offset(0, 1))
                        ],
                        color: FoodColor,
                        borderRadius: new BorderRadius.only(
                            bottomLeft: Radius.circular(17.0),
                            bottomRight: Radius.circular(17.0))),
                    child: messageBox()),
              SizedBox(
                height: Responsive.isMobile(context)
                    ? defaultPadding
                    : defaultPadding * 5,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: !Responsive.isMobile(context)
                      ? BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                  "assets/images/pagina_alimentacao.png")))
                      : null,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        Responsive.isMobile(context)
                            ? defaultPadding
                            : defaultPadding * 3.5,
                        0,
                        Responsive.isMobile(context)
                            ? defaultPadding
                            : defaultPadding * 5,
                        0),
                    child: Column(
                      children: [
                        if (!Responsive.isMobile(context)) topWeb(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                              defaultPadding, 0, defaultPadding, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("O que?"),
                              SizedBox(height: defaultPadding / 2),
                              Container(
                                width: double.infinity,
                                child: CupertinoSlidingSegmentedControl(
                                    groupValue: whatValue,
                                    children: whatTabs,
                                    backgroundColor: FoodColorAlpha,
                                    onValueChanged: (value) {
                                      setState(() {
                                        whatValue = value as int;
                                      });
                                    }),
                              ),
                            ],
                          ),
                        ),
                        whatValue == 0 ? FoodColumn() : WaterColumn(),
                        if (whatValue == 0)
                          CustomTextField(
                            FoodColorAlpha,
                            (txt) {
                              _text = txt;
                            },
                            textEditingController,
                            null,
                          ),
                        SizedBox(height: defaultPadding * 2)
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String getMessage() {
    if (whatValue == 0)
      return "Comeu" +
          (whichValue == 1
              ? " o lanche da manhã"
              : whichValue == 2
                  ? " o almoço"
                  : whichValue == 3
                      ? " o lanche da tarde"
                      : " o jantar");
    else
      return this.bootle
          ? "Não trouxe a garrafa d’água"
          : "Tomou ${homeStore.amtWater}" +
              (homeStore.amtWater < 1.1
                  ? " garrafa de água"
                  : " garrafas de água");
  }

  Padding messageBox() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
      child: Center(
        child: SizedBox(
          width: double.infinity,
          height: 40,
          child: Container(
            decoration: BoxDecoration(
              color: FoodColorAlpha,
              borderRadius: new BorderRadius.circular(
                  Responsive.isMobile(context) ? 17 : 10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/icon_alimentacao.svg",
                  height: 30,
                  width: 30,
                  color: FoodColor,
                ),
                SizedBox(width: 10),
                Text("${getMessage()}")
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column topWeb() {
    return Column(children: [
      SizedBox(height: defaultPadding * 5),
      topMenu(),
      SizedBox(height: defaultPadding * 1.5),
      messageBox(),
    ]);
  }

  Widget WaterColumn() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Quanto?"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      SizedBox(
                          height: Responsive.isMobile(context) ? 350 : 280,
                          child: Image.asset("assets/images/WatterBottle.png")),
                      Container(
                          width: 90,
                          height: 50,
                          decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(10),
                              color: FoodColorAlpha),
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Container(
                              decoration: new BoxDecoration(
                                  borderRadius: new BorderRadius.circular(10),
                                  color: Colors.white),
                              child: Center(
                                child: Text(
                                  "${homeStore.amtWater}",
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                  Column(
                    children: [
                      WatterButton("Adicionar", "+"),
                      SizedBox(
                        height: defaultPadding,
                      ),
                      WatterButton("Remover", "-")
                    ],
                  )
                ],
              ),
              Responsive.isMobile(context)
                  ? SizedBox(height: defaultPadding * 4)
                  : SizedBox(height: defaultPadding),
              Container(
                  width: double.infinity,
                  height: 50,
                  decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(10),
                      color: FoodColorAlpha),
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: TextButton(
                        style: ButtonStyle(
                            overlayColor: MaterialStateColor.resolveWith(
                                (states) => Colors.transparent),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white)),
                        onPressed: () {
                          setState(() {
                            this.bootle = !this.bootle;
                            homeStore.amtWater = 0;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Não trouxe a garrafa d’água",
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        )),
                  ))
            ]),
      ),
    );
  }

  Widget FoodColumn() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
        Widget>[
      Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Qual refeição?"),
            SizedBox(height: defaultPadding / 2),
            Row(
              children: [
                FoodButton("Lanche da manhã", 1),
                SizedBox(width: 5),
                FoodButton("Almoço", 2),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                FoodButton("Lanche da tarde", 3),
                SizedBox(width: 5),
                FoodButton("Jantar", 4),
              ],
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(defaultPadding, 0, 0, 15),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Qual a quantidade?",
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text("Click uma vez", style: TextStyle(color: Colors.black45)),
              Image.asset(
                "assets/images/EatAllIcon.png",
                scale: 0.8,
              ),
              Text("Comeu bem", style: TextStyle(color: Colors.black)),
            ],
          ),
          Column(
            children: [
              Text("Click duas vezes", style: TextStyle(color: Colors.black45)),
              Image.asset(
                "assets/images/EatHalfIcon.png",
                scale: 0.8,
              ),
              Text("Comeu parte", style: TextStyle(color: Colors.black)),
            ],
          ),
          Column(
            children: [
              Text("Click três vezes", style: TextStyle(color: Colors.black45)),
              Image.asset(
                "assets/images/DidntEatIcon.png",
                scale: 0.8,
              ),
              Text("Não comeu", style: TextStyle(color: Colors.black)),
            ],
          )
        ],
      ),
    ]);
  }

  Container WatterButton(String text, String icon) {
    return Container(
        width: 120,
        height: 50,
        decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(10), color: FoodColorAlpha),
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: TextButton(
              style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                      (states) => Colors.transparent),
                  backgroundColor: MaterialStateProperty.all(Colors.white)),
              onPressed: () {
                setState(() {
                  if (text == "Adicionar") {
                    this.bootle = false;
                    homeStore.amtWater += homeStore.amtWater < 10 ? 0.5 : 0;
                  } else {
                    this.bootle = false;
                    homeStore.amtWater -= homeStore.amtWater != 0 ? 0.5 : 0;
                  }
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    icon,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                  Text(
                    text,
                    style: TextStyle(color: Colors.black),
                  )
                ],
              )),
        ));
  }

  Expanded FoodButton(String text, int position) {
    return Expanded(
        child: Container(
            decoration: new BoxDecoration(
                borderRadius: new BorderRadius.circular(10),
                color: FoodColorAlpha),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(6, 1, 6, 1),
              child: TextButton(
                  style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith(
                          (states) => Colors.transparent),
                      backgroundColor: MaterialStateProperty.all(
                          this.whichValue == position
                              ? Colors.white
                              : FoodColorAlpha)),
                  onPressed: () {
                    setState(() {
                      this.whichValue = position;
                    });
                  },
                  child: Text(
                    text,
                    style: TextStyle(color: Colors.black),
                  )),
            )));
  }

  Row topMenu() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      TextButton(
        onPressed: () {
          print("Voltar para tela de atividades");
        },
        child: Row(
          children: [
            Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            Text(
              "Voltar",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ],
        ),
        style: ButtonStyle(
            overlayColor:
                MaterialStateColor.resolveWith((states) => Colors.transparent)),
      ),
      Row(children: [
        SvgPicture.asset(
          "assets/icons/icon_alimentacao.svg",
          height: 40,
          width: 40,
          color: Colors.white,
        ),
        SizedBox(width: defaultPadding),
        Text("Alimentação", style: TextStyle(color: Colors.white, fontSize: 16))
      ]),
      TextButton(
        onPressed: () {
          print("Apagar os dados");
        },
        child: Text(
          "Apagar",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        style: ButtonStyle(
            overlayColor:
                MaterialStateColor.resolveWith((states) => Colors.transparent)),
      ),
    ]);
  }

  CupertinoSlidingSegmentedControl<int> segmentedControl(
      int variable, Map<int, Widget> tabs) {
    return CupertinoSlidingSegmentedControl(
        groupValue: variable,
        children: tabs,
        backgroundColor: FoodColorAlpha,
        onValueChanged: (value) {
          setState(() {
            variable = value as int;
          });
        });
  }

  //-------------------------------------------------------------------------
  final Map<int, Widget> whatTabs = <int, Widget>{
    0: Padding(padding: EdgeInsets.all(10), child: Text("Refeição")),
    1: Padding(padding: EdgeInsets.all(10), child: Text("Água")),
  };
}
