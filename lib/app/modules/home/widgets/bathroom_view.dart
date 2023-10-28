import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teacher_side/app/Model/constants.dart';
import 'package:teacher_side/shared/components/custom_textField.dart';
import 'package:teacher_side/shared/components/responsive.dart';

class BathroomView extends StatefulWidget {
  BathroomView({Key? key}) : super(key: key);

  @override
  _BathroomViewState createState() => _BathroomViewState();
}

class _BathroomViewState extends State<BathroomView>
    with AutomaticKeepAliveClientMixin {
  int whatValue = 0;
  int howValue = 0;
  int whereValue = 0;
  String _text = "";

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Column(children: [
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
                    color: BathroomColor,
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
                          image:
                              AssetImage("assets/images/pagina_banheiro.png")))
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
                child: Column(children: [
                  if (!Responsive.isMobile(context)) topWeb(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
                      Text("O que?"),
                      SizedBox(height: defaultPadding / 2),
                      Container(
                        width: double.infinity,
                        child: CupertinoSlidingSegmentedControl(
                            groupValue: whatValue,
                            children: whatTabs,
                            backgroundColor: BathroomColorAlpha,
                            onValueChanged: (value) {
                              setState(() {
                                whatValue = value as int;
                              });
                            }),
                      ),
                    ],
                  ),
                  if (whatValue == 0)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: defaultPadding),
                        Text("Como?"),
                        SizedBox(height: defaultPadding / 2),
                        Container(
                          width: double.infinity,
                          child: CupertinoSlidingSegmentedControl(
                              groupValue: howValue,
                              children: howTabs,
                              backgroundColor: BathroomColorAlpha,
                              onValueChanged: (value) {
                                setState(() {
                                  howValue = value as int;
                                });
                              }),
                        ),
                      ],
                    ),
                  if (whatValue == 0 || whatValue == 1)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: defaultPadding),
                        Text("Onde?"),
                        SizedBox(height: defaultPadding / 2),
                        Container(
                          width: double.infinity,
                          child: CupertinoSlidingSegmentedControl(
                              groupValue: whereValue,
                              children: whereTabs,
                              backgroundColor: BathroomColorAlpha,
                              onValueChanged: (value) {
                                setState(() {
                                  whereValue = value as int;
                                });
                              }),
                        ),
                      ],
                    ),
                  if (whatValue == 2)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: defaultPadding),
                        Text("Opções"),
                        SizedBox(height: defaultPadding / 2),
                        Container(
                          width: double.infinity,
                          child: CupertinoSlidingSegmentedControl(
                              groupValue: howValue,
                              children: optionsTabs,
                              backgroundColor: BathroomColorAlpha,
                              onValueChanged: (value) {
                                setState(() {
                                  howValue = value as int;
                                });
                              }),
                        ),
                      ],
                    ),
                  if (whatValue == 2 && howValue == 0)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: defaultPadding),
                        Text("Escovou os dentes"),
                        SizedBox(height: defaultPadding / 2),
                        Container(
                          width: double.infinity,
                          child: CupertinoSlidingSegmentedControl(
                              groupValue: whereValue,
                              children: toothTabs,
                              backgroundColor: BathroomColorAlpha,
                              onValueChanged: (value) {
                                setState(() {
                                  whereValue = value as int;
                                });
                              }),
                        ),
                      ],
                    ),
                  if (whatValue == 2 && howValue == 1)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Tomou banho"),
                        SizedBox(height: defaultPadding),
                        Container(
                          width: double.infinity,
                          child: CupertinoSlidingSegmentedControl(
                              groupValue: whereValue,
                              children: bathTabs,
                              backgroundColor: BathroomColorAlpha,
                              onValueChanged: (value) {
                                setState(() {
                                  whereValue = value as int;
                                });
                              }),
                        ),
                      ],
                    ),
                  CustomTextField(
                    BathroomColorAlpha,
                    (String value) {},
                    null,
                    null,
                  ),
                  SizedBox(
                      height: defaultPadding *
                          (Responsive.isMobile(context) ? 1 : 3))
                ]),
              ),
            ),
          )
        ]));
  }

  String getMessage() {
    if (whatValue == 0) {
      return "Evacuou" +
          (howValue == 0 ? " consistente" : " inconsistente") +
          (whereValue == 0
              ? " na fralda"
              : whereValue == 1
                  ? " no banheiro"
                  : " na roupa");
    } else if (whatValue == 1) {
      return "Urinou" +
          (whereValue == 0
              ? " na fralda"
              : whereValue == 1
                  ? " no banheiro"
                  : " na roupa");
    } else
      return (howValue == 0
          ? whereValue == 0
              ? "Escovou os dentes"
              : "Não escovou os dentes"
          : whereValue == 0
              ? "Tomou banho"
              : "Não tomou banho");
  }

  CupertinoSlidingSegmentedControl<int> segmentedControl(
      int variable, Map<int, Widget> tabs) {
    return CupertinoSlidingSegmentedControl(
        groupValue: variable,
        children: tabs,
        backgroundColor: BathroomColor,
        onValueChanged: (value) {
          setState(() {
            variable = value as int;
          });
        });
  }

  Column topWeb() {
    return Column(children: [
      SizedBox(height: defaultPadding * 5),
      topMenu(),
      SizedBox(height: defaultPadding * 1.5),
      messageBox(),
    ]);
  }

  Row topMenu() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      TextButton(
        onPressed: () {
          // print("Voltar para tela de atividades");
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
          "assets/icons/Icon_banheiro.svg",
          height: 40,
          width: 40,
          color: Colors.white,
        ),
        SizedBox(width: defaultPadding),
        Text("Banheiro", style: TextStyle(color: Colors.white, fontSize: 16))
      ]),
      TextButton(
        onPressed: () {
          // print("Apagar; os dados");
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

  Padding messageBox() {
    return Padding(
      padding: EdgeInsets.fromLTRB((Responsive.isMobile(context) ? 30 : 0), 0,
          (Responsive.isMobile(context) ? 30 : 0), 10),
      child: Center(
        child: SizedBox(
          width: double.infinity,
          height: Responsive.isMobile(context) ? 40 : 50,
          child: Container(
            decoration: BoxDecoration(
              color: BathroomColorAlpha,
              borderRadius: new BorderRadius.circular(
                  Responsive.isMobile(context) ? 17 : 10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/Paperclip.svg",
                  height: 30,
                  width: 30,
                  color: BathroomColor,
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

  //-------------------------------------------------------------------------
  final Map<int, Widget> whatTabs = <int, Widget>{
    0: Padding(padding: EdgeInsets.all(10), child: Text("Evacuou")),
    1: Padding(padding: EdgeInsets.all(10), child: Text("Urinou")),
    2: Padding(padding: EdgeInsets.all(10), child: Text("Higiene"))
  };

  final Map<int, Widget> howTabs = const <int, Widget>{
    0: Padding(padding: EdgeInsets.all(10), child: Text("Consistente")),
    1: Padding(padding: EdgeInsets.all(10), child: Text("Inconsistente"))
  };

  final Map<int, Widget> whereTabs = const <int, Widget>{
    0: Padding(padding: EdgeInsets.all(10), child: Text("Na fralda")),
    1: Padding(padding: EdgeInsets.all(10), child: Text("No banheiro")),
    2: Padding(padding: EdgeInsets.all(10), child: Text("Na roupa"))
  };

  final Map<int, Widget> optionsTabs = const <int, Widget>{
    0: Padding(padding: EdgeInsets.all(10), child: Text("Dentes")),
    1: Padding(padding: EdgeInsets.all(10), child: Text("Banho"))
  };

  final Map<int, Widget> toothTabs = const <int, Widget>{
    0: Padding(padding: EdgeInsets.all(10), child: Text("Escovou os dentes")),
    1: Padding(
        padding: EdgeInsets.all(10), child: Text("Não escovou os dentes"))
  };

  final Map<int, Widget> bathTabs = const <int, Widget>{
    0: Padding(padding: EdgeInsets.all(10), child: Text("Tomou banho")),
    1: Padding(padding: EdgeInsets.all(10), child: Text("Não tomou banho"))
  };
}
