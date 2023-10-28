import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teacher_side/app/Animations/Loader.dart';
import 'package:teacher_side/app/Model/constants.dart';
import 'package:teacher_side/app/core/empty_states/selectOption.dart';
import 'package:teacher_side/app/core/empty_states/studentListEmptyMobile.dart';
import 'package:teacher_side/app/modules/home/home_store.dart';
import 'package:teacher_side/app/modules/main/main_controller.dart';
import 'package:teacher_side/shared/components/custom_textField.dart';
import 'package:teacher_side/shared/components/responsive.dart';
import 'sleep_controller.dart';

class SleepPage extends StatefulWidget {
  final String title;
  const SleepPage({Key? key, this.title = "Sleep"}) : super(key: key);

  @override
  _SleepPageState createState() => _SleepPageState();
}

class _SleepPageState extends ModularState<SleepPage, SleepController>
    with AutomaticKeepAliveClientMixin {
  DateTime whenStarted = DateTime.now();
  DateTime duration = DateTime(0);
  String text = "";

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: Responsive.isMobile(context)
          ? AppBar(
              title: topMenu(),
              elevation: 0,
              backgroundColor: SleepColor,
            )
          : null,
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
                        color: SleepColor,
                        borderRadius: new BorderRadius.only(
                            bottomLeft: Radius.circular(17.0),
                            bottomRight: Radius.circular(17.0))),
                    child: messageBox()),
              SizedBox(
                height: Responsive.isMobile(context)
                    ? defaultPadding
                    : defaultPadding * 1,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: !Responsive.isMobile(context)
                      ? BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                  "assets/images/pagina_soneca.png")))
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
                    child: Observer(builder: (context) {
                      return ListView(
                        children: [
                          !Responsive.isMobile(context)
                              ? topWeb()
                              : Container(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("O que?"),
                              SizedBox(height: defaultPadding),
                              Container(
                                width: double.infinity,
                                child: CupertinoSlidingSegmentedControl(
                                    groupValue: store.slept ? 0 : 1,
                                    children: whatTabs,
                                    backgroundColor: SleepColorAlpha,
                                    onValueChanged: (value) {
                                      print("value: $value");
                                      if (value == 0) {
                                        store.slept = true;
                                      } else {
                                        store.slept = false;
                                      }
                                    }),
                              ),
                            ],
                          ),
                          SizedBox(height: defaultPadding * 2),
                          if (store.slept)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Como?"),
                                SizedBox(height: defaultPadding),
                                Container(
                                  width: double.infinity,
                                  child: CupertinoSlidingSegmentedControl(
                                      groupValue: store.sleepWell ? 0 : 1,
                                      children: howTabs,
                                      backgroundColor: SleepColorAlpha,
                                      onValueChanged: (value) {
                                        if (value == 0) {
                                          store.sleepWell = true;
                                        } else {
                                          store.sleepWell = false;
                                        }
                                      }),
                                ),
                              ],
                            ),
                          SizedBox(height: defaultPadding * 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Quando começou?"),
                              Container(
                                  width: 110,
                                  height: 50,
                                  decoration: new BoxDecoration(
                                      borderRadius:
                                          new BorderRadius.circular(10),
                                      color: SleepColorAlpha),
                                  child: Padding(
                                      padding: const EdgeInsets.all(3),
                                      child: TextButton(
                                          child: Observer(builder: (context) {
                                            return Text(
                                                "${store.start.hour}:${store.start.minute}");
                                          }),
                                          style: ButtonStyle(
                                              overlayColor: MaterialStateColor
                                                  .resolveWith((states) =>
                                                      Colors.transparent),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.white)),
                                          onPressed: () {
                                            showModalBottomSheet(
                                                context: context,
                                                builder:
                                                    (BuildContext builder) {
                                                  return Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .copyWith()
                                                                  .size
                                                                  .height /
                                                              3,
                                                      child:
                                                          CupertinoDatePicker(
                                                        minuteInterval: 1,
                                                        initialDateTime:
                                                            store.start,
                                                        use24hFormat: true,
                                                        onDateTimeChanged:
                                                            (DateTime newDate) {
                                                          store.start = newDate;
                                                        },
                                                        mode:
                                                            CupertinoDatePickerMode
                                                                .time,
                                                      ));
                                                });
                                          })))
                            ],
                          ),
                          SizedBox(height: defaultPadding * 2),
                          if (store.slept)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Qual foi a duração"),
                                Container(
                                    width: 110,
                                    height: 50,
                                    decoration: new BoxDecoration(
                                        borderRadius:
                                            new BorderRadius.circular(10),
                                        color: SleepColorAlpha),
                                    child: Padding(
                                        padding: const EdgeInsets.all(3),
                                        child: TextButton(
                                            child: Observer(builder: (context) {
                                              return Text(
                                                  "${store.duration.hour}:${store.duration.minute}");
                                            }),
                                            style: ButtonStyle(
                                                overlayColor: MaterialStateColor
                                                    .resolveWith((states) =>
                                                        Colors.transparent),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.white)),
                                            onPressed: () {
                                              showModalBottomSheet(
                                                  context: context,
                                                  builder:
                                                      (BuildContext builder) {
                                                    return Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .copyWith()
                                                                .size
                                                                .height /
                                                            3,
                                                        child:
                                                            CupertinoDatePicker(
                                                          minuteInterval: 1,
                                                          initialDateTime:
                                                              store.duration,
                                                          use24hFormat: true,
                                                          onDateTimeChanged:
                                                              (DateTime
                                                                  newDate) {
                                                            store.duration =
                                                                newDate;
                                                          },
                                                          mode:
                                                              CupertinoDatePickerMode
                                                                  .time,
                                                        ));
                                                  });
                                            })))
                              ],
                            ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: CustomTextField(
                              SleepColorAlpha,
                              (String value) => store.note = value,
                              null,
                              text,
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              )
            ],
          )),
    );
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
              color: SleepColorAlpha,
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
                Observer(builder: (context) {
                  return Text(getMessage(store.slept, store.sleepWell,
                      store.start, store.duration));
                })
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

  final MainController mainController = Modular.get();

  Container topMenu() {
    return Container(
      width: MediaQuery.of(context).size.width,
      // padding: EdgeInsets.symmetric(horizontal: 22),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          width: 100,
          child: TextButton(
            onPressed: () {
              // print("Voltar para tela de atividades");
              mainController.pageListIndex = 0;
            },
            child: Row(
              children: [
                // Icon(
                //   Icons.arrow_back_ios,
                //   color: Colors.white,
                // ),
                Text(
                  "Cancelar",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 16),
                ),
              ],
            ),
            style: ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith(
                    (states) => Colors.transparent)),
          ),
        ),
        Row(children: [
          SvgPicture.asset(
            "assets/icons/icon_soneca.svg",
            height: 40,
            width: 40,
          ),
          SizedBox(width: defaultPadding),
          Text("Soneca", style: TextStyle(color: Colors.white, fontSize: 16))
        ]),
        Container(
          width: 100,
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () async {
              var futureSend = await store.sendSleepData(
                  context,
                  getMessage(store.slept, store.sleepWell, store.start,
                      store.duration));
              if (futureSend == 'emptystudents') {
                showDialog(
                    context: context,
                    builder: (context) {
                      return StudentListEmptyMobile();
                    });
              } else if (futureSend == 'emptyDuration') {
                showDialog(
                    context: context,
                    builder: (context) {
                      return SelectOption();
                    });
              }

              if (futureSend == 'send') {
                showDialog(
                    context: context,
                    builder: (context) {
                      Future.delayed(Duration(seconds: 3), () {
                        Navigator.pop(context);
                      }).then((value) => () {
                            Navigator.pop(context);
                          });
                      return ColorLoader();
                    });
              } else {}
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(
                  "assets/icons/send.svg",
                  height: 16,
                  width: 16,
                  color: Colors.white,
                ),
                SizedBox(width: 3),
                Text(
                  "Enviar",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 16),
                ),
              ],
            ),
            style: ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith(
                    (states) => Colors.transparent)),
          ),
        ),
      ]),
    );
  }

  String getMessage(_whatValue, _howValue, _start, _duration) {
    print(
        "slept: $_whatValue, sleepWell: $_howValue, start: $_start, duration: $_duration ");
    return (_whatValue
            ? _howValue
                ? "Dormiu bem ás "
                : "Dormiu mal ás "
            : "Não dormiu ás ") +
        "${_start.hour.toString().padLeft(2, "0")}:${_start.minute.toString().padLeft(2, "0")} " +
        (_whatValue
            ? (_duration.hour >= 1
                ? "por ${_duration.hour.toString().padLeft(2, "0")}:${_duration.minute.toString().padLeft(2, "0")} minutos"
                : "por ${_duration.minute} minutos")
            : "");
  }

  final Map<int, Widget> whatTabs = const <int, Widget>{
    0: Padding(padding: EdgeInsets.all(10), child: Text("Dormiu")),
    1: Padding(padding: EdgeInsets.all(10), child: Text("Não dormiu"))
  };

  final Map<int, Widget> howTabs = const <int, Widget>{
    0: Padding(padding: EdgeInsets.all(10), child: Text("Bem")),
    1: Padding(padding: EdgeInsets.all(10), child: Text("Mal"))
  };
}
