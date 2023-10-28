import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teacher_side/app/Animations/Loader.dart';
import 'package:teacher_side/app/Model/constants.dart';
import 'package:teacher_side/app/core/empty_states/emptyTitle.dart';
import 'package:teacher_side/app/core/empty_states/studentListEmptyMobile.dart';
import 'package:teacher_side/app/modules/home/home_store.dart';
import 'package:teacher_side/app/modules/main/main_controller.dart';
import 'package:teacher_side/app/modules/report/report_controller.dart';
import 'package:teacher_side/shared/components/custom_textField.dart';
import 'package:teacher_side/shared/components/responsive.dart';
import 'package:teacher_side/shared/components/title_widget.dart';
import 'widgets/image_widget.dart';

class ReportPage extends StatefulWidget {
  ReportPage({Key? key}) : super(key: key);

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage>
    with AutomaticKeepAliveClientMixin {
  final ReportController controller = Modular.get();
  final HomeStore homeStore = Modular.get();
  final MainController mainController = Modular.get();

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
              backgroundColor: ReportColor,
            )
          : null,
      body: Padding(
        padding: EdgeInsets.only(
            top: Responsive.isMobile(context) ? defaultPadding : 20),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(
              Responsive.isMobile(context)
                  ? defaultPadding
                  : defaultPadding * 3.5,
              0,
              Responsive.isMobile(context)
                  ? defaultPadding
                  : defaultPadding * 5,
              0),
          decoration: !Responsive.isMobile(context)
              ? BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/pagina_report.png")))
              : null,
          child: Column(
            children: [
              !Responsive.isMobile(context) ? topWeb() : Container(),
              titleWidget(
                ReportColorAlpha,
                controller.textEditingControllerTitle,
              ),
              SizedBox(height: defaultPadding),
              ImageWidget(ReportColorAlpha),
              CustomTextField(
                ReportColorAlpha,
                (String value) {},
                controller.textEditingControllerNote,
                'Anotações:',
              ),
              SizedBox(
                height: defaultPadding * (Responsive.isMobile(context) ? 0 : 3),
              )
            ],
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
    ]);
  }

  Container topMenu() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          width: 100,
          child: TextButton(
            onPressed: () {
              controller.clear();
            },
            child: Row(
              children: [
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
            "assets/icons/Icon_registro.svg",
            height: 40,
            width: 40,
          ),
          SizedBox(width: defaultPadding),
          Text("Registro", style: TextStyle(color: Colors.white, fontSize: 16))
        ]),
        Container(
          width: 100,
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              controller.toSend(context).then((value) {
                if(value == 'emptyStudents'){
                  showDialog(context: context, builder: (context){
                    return StudentListEmptyMobile();
                  });
                }
                 else if(value == 'emptyTitle'){
                      showDialog(context: context, builder: (context){
                      return EmptyTitle();
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
