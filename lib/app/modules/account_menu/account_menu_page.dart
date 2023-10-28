import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:teacher_side/app/Model/constants.dart';
import 'package:teacher_side/app/modules/main/main_controller.dart';
import 'package:teacher_side/shared/components/responsive.dart';
import 'account_menu_controller.dart';

class AccountMenuPage extends StatefulWidget {
  AccountMenuPage({Key? key}) : super(key: key);

  @override
  _AccountMenuState createState() => _AccountMenuState();
}

class _AccountMenuState extends State<AccountMenuPage> {
  final AccountMenuController store = Modular.get();
  final MainController mainController = Modular.get();
  var maskFormatter = new MaskTextInputFormatter(
      mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    store.saveEdit();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        // print('saveEdit ${_formKey.currentState!.validate()}');

        return false;
      },
      child: Row(
        children: [
          // if (Responsive.isDesktop(context))
          //   Expanded(
          //     flex: _size.width > 1340 ? 2 : 3,
          //     child: SideMenu(),
          //   ),
          Expanded(
            flex: 9,
            child: Column(
              children: [
                if (Responsive.isDesktop(context))
                  Expanded(flex: 1, child: _desktopMenu()),
                Expanded(
                  flex: 9,
                  child: Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0,
                                defaultPadding, defaultPadding, defaultPadding),
                            child: Responsive.isMobile(context)
                                ? Column(
                                    children: [
                                      _profile(context),
                                      SizedBox(width: defaultPadding * 2),
                                      _teacherCard()
                                    ],
                                  )
                                : Row(
                                    children: [
                                      _profile(context),
                                      SizedBox(width: defaultPadding * 2),
                                      _teacherCard()
                                    ],
                                  ),
                          ))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _desktopMenu() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: defaultPadding),
        Text(
          "Minha conta",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              mainController.enableFields = true;
            });
          },
          child: Text(
            "Editar",
          ),
          style: ButtonStyle(
            overlayColor:
                MaterialStateColor.resolveWith((states) => Colors.transparent),
          ),
        )
      ],
    );
  }

  Widget _teacherCard() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Observer(
          builder: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Informações",
                  style: TextStyle(
                      color: TextGreyColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                SizedBox(height: defaultPadding),
                Expanded(
                  child: Form(
                    key: store.formKey,
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Nome"),
                            SizedBox(width: defaultPadding),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: new BorderRadius.circular(7.0),
                                ),
                                child: TextFormField(
                                  initialValue:
                                      mainController.teacherModel!.username,
                                  enabled: mainController.enableFields,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                      hintText:
                                          mainController.teacherModel!.username,
                                      border: InputBorder.none,
                                      prefixText: " "),
                                  onChanged: (String value) {
                                    store.teacherMap['username'] = value;
                                  },
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Campo obrigatório';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Email"),
                            SizedBox(width: defaultPadding),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: new BorderRadius.circular(7.0),
                                ),
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  initialValue: mainController.enableFields
                                      ? null
                                      : mainController.teacherModel!.email,
                                  enabled: false,
                                  // enabled: mainController.enableFields,
                                  decoration: InputDecoration(
                                      hintText:
                                          mainController.teacherModel!.email,
                                      border: InputBorder.none,
                                      prefixText: " "),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Campo obrigatório';
                                    }
                                    bool emailValid = RegExp(
                                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                        .hasMatch(value);

                                    if (!emailValid) {
                                      return 'Digite um e-mail válido';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (String value) {
                                    store.teacherMap['email'] = value;
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Telefone"),
                            SizedBox(width: defaultPadding),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: new BorderRadius.circular(7.0),
                                ),
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  inputFormatters: [maskFormatter],
                                  initialValue: mainController
                                              .teacherModel!.phone !=
                                          null
                                      ? maskFormatter.maskText(
                                          mainController.teacherModel!.phone!)
                                      : null,
                                  keyboardType: TextInputType.phone,
                                  enabled: mainController.enableFields,
                                  decoration: InputDecoration(
                                      hintText: mainController
                                                  .teacherModel!.phone ==
                                              null
                                          ? '(XX) XXXXX-XXXX'
                                          : maskFormatter.maskText(
                                              mainController.teacherModel!.phone
                                                  .toString()),
                                      border: InputBorder.none,
                                      prefixText: " "),
                                  validator: (String? value) {
                                    // print(
                                    //     'vaaaaaalue phone $value - ${value!.length}');
                                    if (value == null || value.isEmpty) {
                                      return 'Campo obrigatório';
                                    } else {
                                      if (value.length < 15) {
                                        return 'Número incompleto';
                                      }

                                      return null;
                                    }
                                  },
                                  onChanged: (String value) {
                                    // print('phoneeeeeeeeeeeeeeee $value');
                                    store.teacherMap['phone'] =
                                        maskFormatter.unmaskText(value);
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text("Aniversário"),
                            MaterialButton(
                              elevation: 0,
                              child: Text(
                                dateFormatting(
                                    store.teacherMap['birthday'] == null
                                        ? mainController.teacherModel!.birthday
                                        : store.teacherMap['birthday']),
                              ),
                              onPressed: () {
                                if (mainController.enableFields) {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext builder) {
                                      return Container(
                                        height: MediaQuery.of(context)
                                                .copyWith()
                                                .size
                                                .height /
                                            3,
                                        child: CupertinoDatePicker(
                                          initialDateTime: mainController
                                                      .teacherModel!.birthday ==
                                                  null
                                              ? DateTime.now()
                                              : mainController
                                                  .teacherModel!.birthday!
                                                  .toDate(),
                                          onDateTimeChanged:
                                              (DateTime newdate) {
                                            setState(() {
                                              // print(
                                              //     'daaaaaaaaaaaaaaaaate $newdate');
                                              store.teacherMap['birthday'] =
                                                  Timestamp.fromDate(newdate);
                                            });
                                          },
                                          use24hFormat: true,
                                          maximumDate: new DateTime.now(),
                                          minimumYear: 1980,
                                          minuteInterval: 1,
                                          mode: CupertinoDatePickerMode.date,
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Mensagem de Boas Vindas",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                        "Descreva aqui uma pequena mensagem de boas vindas para a família."),
                    SizedBox(height: defaultPadding),
                    Expanded(
                        child: TextFormField(
                      initialValue: mainController.teacherModel!.textMessage,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      enabled: mainController.enableFields,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixText: " ",
                          hintText:
                              "EX.\nOlá País/ Responsáveis, Sejam Bem vindos ao ano Letivo de 2022 na turma Infantil 1C. Será um ano de Muito aprendizado.\n\nQualquer coisa estou sempre a Disposição.\n\nAbraços\nProf. Alexandra "),
                      onChanged: (String value) {
                        store.teacherMap['text_message'] = value;
                      },
                    )),
                  ],
                ))
              ],
            );
          },
        ),
      ),
    );
  }

  String dateFormatting(Timestamp? date) {
    if (date == null) {
      return 'xx/xx/xx';
    } else {
      String day = date.toDate().day.toString().padLeft(2, '0');
      String month = date.toDate().month.toString().padLeft(2, '0');
      String year = date.toDate().year.toString();

      return '$day/$month/$year';
    }
  }

  Widget _profile(BuildContext context) {
    return Observer(
      builder: (context) {
        return Responsive.isMobile(context)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        defaultPadding, defaultPadding, 0, defaultPadding),
                    child: InkWell(
                      onTap: () {
                        if (mainController.enableFields) {
                          store.pickImage();
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(7.0),
                        child: getAvatar(store.teacherMap['avatar']),
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(defaultPadding * 2,
                        defaultPadding, defaultPadding, defaultPadding),
                    child: InkWell(
                      onTap: () {
                        if (mainController.enableFields) {
                          store.pickImage();
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(7.0),
                        child: getAvatar(store.teacherMap['avatar']),
                      ),
                    ),
                  ),
                ],
              );
      },
    );
  }

  Widget getAvatar(String? avatar) {    
    if (avatar != null) {
      return CachedNetworkImage(
          imageUrl: avatar,
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(AppColor),
                  value: downloadProgress.progress,
                  strokeWidth: 4,
                ),
              ),
          height: Responsive.isMobile(context) ? 170 : 210,
          width: Responsive.isMobile(context) ? 170 : 200,
          fit: BoxFit.cover);
    }

    if (mainController.teacherModel!.avatar != null) {
      return CachedNetworkImage(
          imageUrl: mainController.teacherModel!.avatar!,
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(AppColor),
                  value: downloadProgress.progress,
                  strokeWidth: 4,
                ),
              ),
          height: Responsive.isMobile(context) ? 170 : 210,
          width: Responsive.isMobile(context) ? 170 : 200,
          fit: BoxFit.cover);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(7.0),
      child: Image.asset(
        "assets/images/person.jpeg",
        height: Responsive.isMobile(context) ? 150 : 210,
        width: Responsive.isMobile(context) ? 150 : 200,
        fit: BoxFit.cover,
      ),
    );
  }
}
