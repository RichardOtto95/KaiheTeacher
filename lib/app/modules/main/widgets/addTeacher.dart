import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mobx/mobx.dart';
import 'package:teacher_side/app/Model/constants.dart';
import 'package:teacher_side/app/modules/main/main_controller.dart';
import 'package:teacher_side/shared/components/responsive.dart';

class AddTeacherPage extends StatefulWidget {
  AddTeacherPage({Key? key}) : super(key: key);

  @override
  _AddTeacherState createState() => _AddTeacherState();
}

class _AddTeacherState extends State<AddTeacherPage> {
  final MainController mainController = Modular.get();
  var maskFormatter = new MaskTextInputFormatter(
      mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ObservableMap teacherMap = ObservableMap();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Row(
        children: [
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
          "Adicionar novo professor",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        TextButton(
          onPressed: () {
            if(formKey.currentState!.validate()){
              mainController.cloudFunctionExample(teacherMap);
            }
          },
          child: Text(
            "Adicionar",
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
                    key: formKey,
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
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                      hintText:
                                          mainController.teacherModel!.username,
                                      border: InputBorder.none,
                                      prefixText: " "),
                                  onChanged: (String value) {
                                    teacherMap['username'] = value;
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
                                    teacherMap['email'] = value;
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
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                      hintText: '(XX) XXXXX-XXXX',
                                      border: InputBorder.none,
                                      prefixText: " "),
                                  validator: (String? value) {
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
                                    teacherMap['phone'] =
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
                                dateFormatting(teacherMap['birthday']),
                              ),
                              onPressed: () {
                                selectDate(context);
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Expanded(
                //     child: Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Text("Mensagem de Boas Vindas",
                //         style: TextStyle(fontWeight: FontWeight.bold)),
                //     Text(
                //         "Descreva aqui uma pequena mensagem de boas vindas para a família."),
                //     SizedBox(height: defaultPadding),
                //     Expanded(
                //         child: TextFormField(
                //       initialValue: mainController.teacherModel!.textMessage,
                //       keyboardType: TextInputType.multiline,
                //       maxLines: null,
                //       enabled: mainController.enableFields,
                //       decoration: InputDecoration(
                //           border: InputBorder.none,
                //           prefixText: " ",
                //           hintText:
                //               "EX.\nOlá País/ Responsáveis, Sejam Bem vindos ao ano Letivo de 2022 na turma Infantil 1C. Será um ano de Muito aprendizado.\n\nQualquer coisa estou sempre a Disposição.\n\nAbraços\nProf. Alexandra "),
                //       onChanged: (String value) {
                //         store.teacherMap['text_message'] = value;
                //       },
                //     )),
                //   ],
                // ))
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
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(7.0),
                        child: getAvatar(teacherMap['avatar']),
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
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(7.0),
                        child: getAvatar(teacherMap['avatar']),
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

    selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDatePickerMode: DatePickerMode.year,
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
      context: context,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: BathroomColor,
            colorScheme: ColorScheme.light(primary: const Color(0xFF41c3b3)),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      }, 
      initialDate: DateTime.now(),
    );
    if (picked != null) {
      teacherMap['birthday'] = Timestamp.fromDate(picked);
    }
  }
}
