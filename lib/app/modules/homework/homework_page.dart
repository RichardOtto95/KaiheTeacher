import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teacher_side/app/Animations/Loader.dart';
import 'package:teacher_side/app/Model/constants.dart';
import 'package:teacher_side/app/core/empty_states/emptyTitle.dart';
import 'package:teacher_side/app/core/empty_states/studentListEmptyMobile.dart';
import 'package:teacher_side/app/modules/homework/homework_store.dart';
import 'package:teacher_side/app/modules/homework/widgets/homework_image_widget.dart';
import 'package:teacher_side/app/modules/main/main_controller.dart';
import 'package:teacher_side/shared/components/custom_textField.dart';
import 'package:teacher_side/shared/components/responsive.dart';
import 'package:teacher_side/shared/components/title_widget.dart';

class HomeworkPage extends StatefulWidget {
  HomeworkPage({Key? key}) : super(key: key);

  @override
  _HomeworkPageState createState() => _HomeworkPageState();
}

class _HomeworkPageState extends State<HomeworkPage>
    with AutomaticKeepAliveClientMixin {
  final HomeworkStore store = Modular.get();
  int homeWork = 0;
  String title = "";
  String message = "";
  final _formKey = GlobalKey<FormState>();

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
              backgroundColor: HomeWorkColor,
            )
          : null,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(
                top: Responsive.isMobile(context) ? defaultPadding : 80),
            child: Container(
              decoration: !Responsive.isMobile(context)
                  ? BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(
                              "assets/images/pagina_deverDeCasa.png")))
                  : null,
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
              child: ListView(
                children: [
                  !Responsive.isMobile(context) ? topWeb() : Container(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Container(
                      width: double.infinity,
                      child: CupertinoSlidingSegmentedControl(
                          groupValue: this.homeWork,
                          children: homeWorkTabs,
                          backgroundColor: HomeWorkColorAlpha,
                          onValueChanged: (value) {
                            setState(() {
                              this.homeWork = value as int;
                            });
                          }),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.50,
                    child:
                        this.homeWork == 0 ? newHomeWork() : didntDoHomeWork(),
                  ),
                  SizedBox(height: 10)
                ],
              ),
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
            "assets/icons/Icon_deverdecasa.svg",
            height: 40,
            width: 40,
          ),
          SizedBox(width: defaultPadding),
          Text("Dever de casa",
              style: TextStyle(color: Colors.white, fontSize: 16))
        ]),
        Container(
          width: 100,
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => homeWork == 0
                ? store.sendHomeworkData(context).then((value) {
                    if (value == 'emptyStudents') {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return StudentListEmptyMobile();
                          });
                    } else if (value == 'emptyTitle') {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return EmptyTitle();
                          });
                    } else if (value == 'send') {
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
                    }
                  })
                : store.checkHomework(context),
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

  Widget newHomeWork() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          defaultPadding, 0, defaultPadding, defaultPadding),
      child: Column(
        children: <Widget>[
          SizedBox(height: defaultPadding),
          titleWidget(HomeWorkColorAlpha, null, onChanged: (txt) {
            this.store.title = txt;
          }),
          SizedBox(height: defaultPadding),
          HomeworkImageWidget(HomeWorkColorAlpha),
          CustomTextField(
            HomeWorkColorAlpha,
            (txt) => this.store.note = txt,
            null,
            this.message,
          ),
        ],
      ),
    );
  }

  Widget didntDoHomeWork() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("classes")
          .doc(store.mainController.classId)
          .collection("homeworks")
          .where("teacher_id",
              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where("status", isEqualTo: "TO_DO")
          .orderBy("updated_at", descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
        }
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        print("snapshot.data!.docs.length: ${snapshot.data!.docs.length}");
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, i) {
            final doc = snapshot.data!.docs[i];
            return homeWorkCell(
              doc.id,
              doc["title"],
              doc["created_at"]
                  .toDate()
                  .toString()
                  .substring(0, 11)
                  .replaceAll("-", "/"),
              () {
                if (store.homeworkSelected == doc.id) {
                  store.homeworkSelected = null;
                } else {
                  store.homeworkSelected = doc.id;
                }
              },
            );
          },
        );
      },
    );
  }

  Widget homeWorkCell(
      String id, String titulo, String data, void Function() onTap) {
    return Padding(
        padding: EdgeInsets.fromLTRB(
            defaultPadding, defaultPadding, defaultPadding, 0),
        child: InkWell(
          onTap: onTap,
          child: Observer(builder: (context) {
            return Container(
                height: 60,
                decoration: BoxDecoration(
                  color: HomeWorkColorAlpha,
                  borderRadius: new BorderRadius.circular(7.0),
                  border: id == store.homeworkSelected
                      ? Border.all(
                          width: 5,
                          color: HomeWorkColor,
                        )
                      : null,
                ),
                child: Row(children: [
                  SizedBox(width: defaultPadding),
                  Text(
                    titulo,
                    // overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Text(data),
                  SizedBox(width: defaultPadding),
                ]));
          }),
        ));
  }

  CupertinoSlidingSegmentedControl<int> segmentedControl(
      int variable, Map<int, Widget> tabs) {
    return CupertinoSlidingSegmentedControl(
        groupValue: variable,
        children: tabs,
        backgroundColor: HomeWorkColorAlpha,
        onValueChanged: (value) {
          setState(() {
            variable = value as int;
          });
        });
  }

  final Map<int, Widget> homeWorkTabs = <int, Widget>{
    0: Padding(padding: EdgeInsets.all(10), child: Text("Novo dever de casa")),
    1: Padding(
      padding: EdgeInsets.all(10),
      child: Text("Não fez o dever de casa"),
    )
  };
}
