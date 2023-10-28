import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teacher_side/app/Animations/Loader.dart';
import 'package:teacher_side/app/Model/constants.dart';
import 'package:teacher_side/app/modules/attendence/attendence_store.dart';
import 'package:flutter/material.dart';
import 'package:teacher_side/app/modules/main/main_controller.dart';
import 'package:teacher_side/shared/components/responsive.dart';

class AttendencePage extends StatefulWidget {
  final String title;
  const AttendencePage({Key? key, this.title = 'AttendencePage'})
      : super(key: key);
  @override
  AttendencePageState createState() => AttendencePageState();
}

class AttendencePageState extends State<AttendencePage> {
  final AttendenceStore store = Modular.get();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: Responsive.isMobile(context)
      //     ? AppBar(
      //         title: topMenu(),
      //         elevation: 0,
      //         backgroundColor: AttendanceColor,
      //       )
      //     : null,
      body: Container(
          width: MediaQuery.of(context).size.width,
          decoration: !Responsive.isMobile(context)
              ? BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/pagina_chamada.png")))
              : null,
          child: Column(
            children: [
              // Responsive.isMobile(context) ?                
              // topMenu() : Container(),
              Padding(
                  padding: const EdgeInsets.only(left :defaultPadding, right:defaultPadding, top:defaultPadding * 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (!Responsive.isMobile(context)) topMenuDesktop(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Quem está presente no dia de hoje ?"),
                              SizedBox(height: defaultPadding),
                              Text(
                                "Todos estudantes já estão selecionados",
                                style: TextStyle(color: TextGreyColor),
                              ),
                            ],
                          ),
                          Image.asset(
                            "assets/images/IconPresente.png",
                            scale: 0.7,
                          ),
                        ],
                      ),
                      SizedBox(height: defaultPadding),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Quem faltou hoje ?"),
                              SizedBox(height: defaultPadding),
                              Text(
                                "Click uma vez no estudante",
                                style: TextStyle(color: TextGreyColor),
                              ),
                            ],
                          ),
                          Image.asset(
                            "assets/images/IconFaltou.png",
                            scale: 0.7,
                          ),
                        ],
                      ),
                      SizedBox(height: defaultPadding),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Quem chegou atrasado hoje ?"),
                              SizedBox(height: defaultPadding),
                              Text(
                                "Click duas vezes no estudante",
                                style: TextStyle(color: TextGreyColor),
                              ),
                            ],
                          ),
                          Image.asset(
                            "assets/images/IconAtrasado.png",
                            scale: 0.7,
                          ),
                        ],
                      ),
                      SizedBox(height: defaultPadding),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Quem saiu mais cedo hoje?"),
                              SizedBox(height: defaultPadding),
                              Text(
                                "Click três vezes no estudante",
                                style: TextStyle(color: TextGreyColor),
                              ),
                            ],
                          ),
                          Image.asset(
                            "assets/images/IconSaiuMaisCedo.png",
                            scale: 0.7,
                          ),
                        ],
                      ),
                      SizedBox(height: defaultPadding),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Quem é estudante Virtual ?"),
                              SizedBox(height: defaultPadding),
                              Text(
                                "Click quatro vezes no estudante",
                                style: TextStyle(color: TextGreyColor),
                              ),
                            ],
                          ),
                          Image.asset(
                            "assets/images/IconVirtual.png",
                            scale: 0.7,
                          ),
                        ],
                      ),
                    ],
                  ))
            ],
          )),
    );
  }

  final MainController mainController = Modular.get();

    Container topMenu() {
    return !kIsWeb ?
    Container(
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 1))
          ],
          color: AttendanceColor,
          borderRadius: new BorderRadius.only(
              bottomLeft: Radius.circular(17.0),
              bottomRight: Radius.circular(17.0))),
      width: MediaQuery.of(context).size.width,
      // padding: EdgeInsets.symmetric(horizontal: 22),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 100,
              height: 40,
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
                "assets/icons/Icon_chamada.svg",
                height: 40,
                width: 40,
                color: Colors.white,
              ),
              SizedBox(width: defaultPadding),
              Text("Chamada",
                  style: TextStyle(color: Colors.white, fontSize: 16))
            ]),
            Container(
              width: 100,
              height: 40,
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () async{
                  // print("Apagar os dados");
                  await store.sendAttendence(context).then((value) => {
                    if(value){
                      showDialog(context: context, builder: (context){
                        Future.delayed(Duration(seconds: 3), (){
                          Navigator.pop(context);    
                        }).then((value) => (){
                          Navigator.pop(context);
                        }); 
                        return  ColorLoader();
                      })
                    
                    }
                  });                
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
    ): Container();
  }

  Container topMenuDesktop() {
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
            "assets/icons/Icon_chamada.svg",
            height: 40,
            width: 40,
            color: Colors.white,
          ),
          SizedBox(width: defaultPadding),
          Text("Chamada", style: TextStyle(color: Colors.white, fontSize: 16))
        ]),
        Container(
          width: 100,
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () async{
              // print("Apagar os dados");
             await store.sendAttendence(context).then((value) => {
                if(value){
                      showDialog(context: context, builder: (context){
                   Future.delayed(Duration(seconds: 3), (){
                Navigator.pop(context);    
              }).then((value) => (){
                Navigator.pop(context);
              }); 
                return  ColorLoader();
               })
              
                }
              });
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
}
