import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teacher_side/app/Model/constants.dart';
import 'package:teacher_side/app/core/models/student_model.dart';
import 'package:teacher_side/app/modules/home/home_store.dart';
import 'package:teacher_side/shared/components/responsive.dart';

import 'parent_cell.dart';

class StudentProfille extends StatefulWidget {
  final StudentModel studentModel;
  StudentProfille({
    Key? key,
    required this.studentModel,
  }) : super(key: key);

  @override
  _StudentProfilleState createState() => _StudentProfilleState();
}

class _StudentProfilleState extends State<StudentProfille> {
  // final MainController mainController = Modular.get();
  final HomeStore homeStore = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 900,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
            0, defaultPadding, defaultPadding, defaultPadding),
        child: Responsive.isMobile(context)
            ? Column(
                children: [
                  _profile(context),
                  SizedBox(width: defaultPadding * 2),
                  _guardianCard()
                ],
              )
            : Row(
                children: [
                  _profile(context),
                  SizedBox(width: defaultPadding * 2),
                  _guardianCard()
                ],
              ),
      ),
    );
  }

  Widget _profile(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Responsive.isMobile(context)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: width / 2.6),
                    child: _profileCard(),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        defaultPadding, defaultPadding, 0, defaultPadding),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7.0),
                      child: 
                       widget.studentModel.avatar != null ?
                        CachedNetworkImage(
                          imageUrl: widget.studentModel.avatar!,
                          progressIndicatorBuilder: (context, url,
                                  downloadProgress) =>
                              Center(
                                child: CircularProgressIndicator(
                                  valueColor:
                                      new AlwaysStoppedAnimation<Color>(AppColor),
                                  value: downloadProgress.progress,
                                  strokeWidth: 4,
                                ),
                              ),
                          height: Responsive.isMobile(context) ? 170 : 210,
                          width: Responsive.isMobile(context) ? 170 : 200,
                          fit: BoxFit.cover,
                        ) : Image.asset(
                          "assets/images/person.jpeg",
                          height: Responsive.isMobile(context) ? 170 : 210,
                          width: Responsive.isMobile(context) ? 170 : 200,
                          fit: BoxFit.cover,
                        ),
                    ),
                  ),
                ],
              ),
            ],
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(defaultPadding * 2, defaultPadding,
                    defaultPadding, defaultPadding),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7.0),
                  child: 
                   widget.studentModel.avatar != null ?
                      CachedNetworkImage(
                        imageUrl: widget.studentModel.avatar!,
                        progressIndicatorBuilder: (context, url,
                                downloadProgress) =>
                            Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    new AlwaysStoppedAnimation<Color>(AppColor),
                                value: downloadProgress.progress,
                                strokeWidth: 4,
                              ),
                            ),
                        height: Responsive.isMobile(context) ? 170 : 210,
                        width: Responsive.isMobile(context) ? 170 : 200,
                        fit: BoxFit.cover,
                      ) : Image.asset(
                        "assets/images/person.jpeg",
                        height: Responsive.isMobile(context) ? 170 : 210,
                        width: Responsive.isMobile(context) ? 170 : 200,
                        fit: BoxFit.cover,
                      ),
                ),
              ),
              SizedBox(height: 29),
              _profileCard()
            ],
          );
  }

  Widget _guardianCard() {
    return Expanded(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Pessoas autorizadas a buscar na escola",
          style: TextStyle(
              color: TextGreyColor, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(height: defaultPadding),
        Expanded(
          child: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection('students')
                  .doc(widget.studentModel.id)
                  .collection('parents')
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return Align(
                    alignment: Alignment.topCenter,
                    child: LinearProgressIndicator(),
                  );
                }
                QuerySnapshot<Object?>? parents = snapshot.data;
                return ListView.builder(
                    itemCount: parents!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot parentDoc =
                          parents.docs[index];
                      return ParentCell(
                        studentName: widget.studentModel.username,
                        parentId: parentDoc.id,
                        press: () {
                          print("Clicou");
                        },
                      );
                    });
              }),
        ),
      ]),
    );
  }

  Widget _profileCard() {
    var _textSize = Responsive.isMobile(context) ? 12.0 : 16.0;
    var _distance = Responsive.isMobile(context) ? 8.0 : 0.0;
    return Padding(
      padding: const EdgeInsets.only(top: defaultPadding),
      child: Container(
          width: Responsive.isMobile(context) ? 180 : 258,
          height: Responsive.isMobile(context) ? 150 : 204,
          decoration: BoxDecoration(
            color: ProfileCardColor,
            borderRadius: new BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          ),
          child: Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: Center(
              child: Column(
                children: [
                  if (!Responsive.isMobile(context))
                    Text(
                      "Informações do estudante",
                      style: TextStyle(
                        color: TextGreyColor,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  SizedBox(
                    height:
                        Responsive.isMobile(context) ? 10 : defaultPadding * 2,
                  ),
                  Text("Data de Aniversário",
                      style: TextStyle(
                          color: TextGreyColor,
                          fontWeight: FontWeight.bold,
                          fontSize: _textSize)),
                  SizedBox(height: _distance),
                  Text(
                    // "03 de Julho de 2020",
                    homeStore.dateFormatting(widget.studentModel.birthday),
                    style: TextStyle(color: TextGreyColor, fontSize: _textSize),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: Responsive.isMobile(context)
                        ? defaultPadding
                        : defaultPadding + 10,
                  ),
                  Text(
                    "Última visualização",
                    style: TextStyle(
                        color: TextGreyColor,
                        fontWeight: FontWeight.bold,
                        fontSize: _textSize),
                  ),
                  SizedBox(height: _distance),
                  Text(
                    // "03 de Julho de 2020 às 20:00",
                    homeStore.dateFormatting(
                        widget.studentModel.lastView, true),
                    style: TextStyle(color: TextGreyColor, fontSize: _textSize),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          )),
    );
  }
}
