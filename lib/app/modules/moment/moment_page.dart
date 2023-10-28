import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teacher_side/app/Animations/Loader.dart';
import 'package:teacher_side/app/Model/constants.dart';
import 'package:teacher_side/app/core/empty_states/emptyTitle.dart';
import 'package:teacher_side/app/core/empty_states/selectOption.dart';
import 'package:teacher_side/app/core/empty_states/studentListEmptyMobile.dart';
import 'package:teacher_side/app/modules/main/main_controller.dart';
import 'package:teacher_side/shared/components/custom_textField.dart';
import 'package:teacher_side/shared/components/responsive.dart';
import 'package:teacher_side/shared/components/title_widget.dart';

import 'moment_store.dart';
import 'widgets/moment_image_widget.dart';

class MomentPage extends StatefulWidget {
  @override
  _MomentPageState createState() => _MomentPageState();
}

class _MomentPageState extends State<MomentPage>
    with AutomaticKeepAliveClientMixin {
  final MomentStore store = Modular.get();
  var message = "";
  var title = "";
  var activityType = "";

  late TextEditingController textEditing;

  @override
  void initState() {
    textEditing = TextEditingController();
    super.initState();
  }

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
              backgroundColor: MomentColor,
            )
          : null,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Padding(
          padding: EdgeInsets.only(top: Responsive.isMobile(context) ? 20 : 20),
          child: Container(
            width: double.infinity,
            decoration: !Responsive.isMobile(context)
                ? BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/pagina_momentos.png")))
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
                  !Responsive.isMobile(context) ? topWeb() : Container(),
                  titleWidget(
                    MomentColorAlpha,
                    textEditing,
                    onChanged: (txt) => store.title = txt,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      momentButton("assets/images/BomComportamento.png",
                          "Bom\ncomportamento", "GOOD_BEHAVIOR"),
                      momentButton("assets/images/SeDivertindo.png",
                          "Participação", "PARTICIPATION"),
                      momentButton("assets/images/SeDivertindo.png",
                          "Se divertindo", "HAVING_FUN"),
                    ],
                  ),
                  SizedBox(height: defaultPadding),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      momentButton("assets/images/TrabalhoEmEquipe.png",
                          "Trabalho em\nequipe", "TEAM_WORK"),
                      momentButton("assets/images/BomTrabalho.png",
                          "Bom Trabalho", "GOOD_JOB"),
                      momentButton("assets/images/AjudandoOsAmigos.png",
                          "Ajudando os\namigos", "HELPING_FRIENDS"),
                    ],
                  ),
                  SizedBox(height: defaultPadding),
                  MomentImageWidget(MomentColorAlpha),
                  CustomTextField(
                    MomentColorAlpha,
                    (txt) => store.description = txt,
                    null,
                    this.message,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox momentButton(String image, String text, String data) {
    return SizedBox(
      width: 110,
      child: TextButton(
        style: ButtonStyle(
          overlayColor:
              MaterialStateColor.resolveWith((states) => Colors.transparent),
        ),
        onPressed: () {
          if (store.medals.contains(data)) {
            store.medals.remove(data);
          } else {
            store.medals.add(data);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Observer(
              builder: (context) {
                return Container(
                  decoration: BoxDecoration(
                    color: store.medals.contains(data)
                        ? MomentColorAlpha
                        : Colors.transparent,
                    borderRadius: new BorderRadius.circular(7.0),
                  ),
                  child: SizedBox(
                    height: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(image),
                    ),
                  ),
                );
              },
            ),
            Container(
              alignment: Alignment.center,
              height: 32,
              child: Center(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column topWeb() {
    return Column(children: [
      SizedBox(height: defaultPadding * 5),
      topMenu(),
      SizedBox(height: defaultPadding * 1.5),
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
            "assets/icons/Icon_momentos.svg",
            height: 40,
            width: 40,
          ),
          SizedBox(width: defaultPadding),
          Text("Momentos", style: TextStyle(color: Colors.white, fontSize: 16))
        ]),
        Container(
          width: 100,
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => store.sendMomentData(context).then((value) {

              if (value == 'emptyStudents'){
                showDialog(context: context, builder: (context){
                  return StudentListEmptyMobile();
                });
              }
               else if(value == 'emptyTitle'){
                      showDialog(context: context, builder: (context){
                      return EmptyTitle();
                    });
                  }
                  else if(value == 'emptyTicket'){
                      showDialog(context: context, builder: (context){
                      return SelectOption();
                    });
                  }
              else if(value == 'send'){
                    showDialog(context: context, builder: (context){
                   Future.delayed(Duration(seconds: 3), (){
                Navigator.pop(context);    
              }).then((value) => (){
                Navigator.pop(context);
              }); 
                return  ColorLoader();
               });
              
              }
            }),
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
}
