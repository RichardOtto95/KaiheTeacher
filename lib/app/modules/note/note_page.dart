import 'package:flutter/cupertino.dart';
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
import 'note_store.dart';
import 'widgets/note_image_widget.dart';

class NotePage extends StatefulWidget {
  NotePage({Key? key}) : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage>
    with AutomaticKeepAliveClientMixin {
  final MainController mainController = Modular.get();
  final NoteStore store = Modular.get();
  var activityType = "";
  var message = "";
  var title = "";

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
          appBar: Responsive.isMobile(context)
              ? AppBar(
                  title: topMenu(),
                  elevation: 0,
                  backgroundColor: NoteColor,
                )
              : null,
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Padding(
                padding: EdgeInsets.only(
                    top: Responsive.isMobile(context) ? 15 : 5),
                child: Container(
                    width: double.infinity,
                    decoration: !Responsive.isMobile(context)
                        ? BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    "assets/images/pagina_bilhete.png")))
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
                          if (Responsive.isDesktop(context))
                            SizedBox(height: defaultPadding * 5),
                          if (!Responsive.isMobile(context)) topWeb(),
                          titleWidget(NoteColorAlpha, null,
                              onChanged: (txt) => store.title = txt),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                momentButton("assets/images/SeMachucou.png",
                                    "Se machucou", "HURT"),
                                momentButton(
                                    "assets/images/NaoCompriu.png",
                                    "Não compriu\no combinado",
                                    "NOT_COMPLY_AGREED"),
                                momentButton("assets/images/SeDesentendeu.png",
                                    "Se desentendeu\ncom o colega", "FELL_OUT"),
                              ]),
                          SizedBox(height: defaultPadding),
                         

                          Padding(
                            padding: const EdgeInsets.only(left:20.0, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                                     
                                
                                Text('Solicitar autorização no bilhete'),
                                 Observer(builder: (context){
                                  return  CupertinoSwitch(thumbColor:Colors.white,activeColor: Colors.pink[400],value: store.authorizationNote, onChanged: (value){
                                    store.changeAuthorizationNote();

                
                                  });

                                }),         
                               
                              ],
                            ),
                          ),
                          NoteImageWidget(NoteColorAlpha),
                          SizedBox(height: defaultPadding),
                          CustomTextField(
                            NoteColorAlpha,
                            (txt) => store.note = txt,
                            null,
                            this.message,
                          ),
                          SizedBox(
                              height: defaultPadding *
                                  (Responsive.isMobile(context) ? 1 : 3))
                        ])))),
          )),
    );
  }

  SizedBox momentButton(String image, String text, String data) {
    return SizedBox(
      width: 110,
      child: TextButton(
          onPressed: () {
            store.type = data;
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Observer(builder: (context) {
                return Container(
                  decoration: BoxDecoration(
                    color: store.type == data
                        ? NoteColorAlpha
                        : Colors.transparent,
                    borderRadius: new BorderRadius.circular(7.0),
                  ),
                  child: SizedBox(
                    height: 90,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(image),
                    ),
                  ),
                );
              }),
              Container(
                alignment: Alignment.center,
                height: 32,
                child: Center(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          style: ButtonStyle(
            overlayColor:
                MaterialStateColor.resolveWith((states) => Colors.transparent),
          )),
    );
  }

  Column topWeb() {
    return Column(children: [
      // SizedBox(height: defaultPadding * 5),
      topMenu(),
      SizedBox(height: defaultPadding * 1.5),
    ]);
  }

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
            "assets/icons/Icon_bilhete.svg",
            height: 40,
            width: 40,
            // color: Colors.white,
          ),
          SizedBox(width: defaultPadding),
          Text("Bilhete", style: TextStyle(color: Colors.white, fontSize: 16))
        ]),
        Container(
          width: 100,
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => store.sendNoteData(context).then((value) => {
              if(value == 'emptyStudents'){
                showDialog(context: context, builder: (context){
                  return StudentListEmptyMobile();
                })
              }
               else if(value == 'emptyTitle'){
                      showDialog(context: context, builder: (context){
                      return EmptyTitle();
                    })
                  }
                  else if(value == 'emptyTicket'){
                      showDialog(context: context, builder: (context){
                      return SelectOption();
                    })
                  }
              else if(value == 'send'){
                    showDialog(context: context, builder: (context){
                   Future.delayed(Duration(seconds: 3), (){
                Navigator.pop(context);    
              }).then((value) => (){
                Navigator.pop(context);
              }); 
                return  ColorLoader();
               })
              
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
