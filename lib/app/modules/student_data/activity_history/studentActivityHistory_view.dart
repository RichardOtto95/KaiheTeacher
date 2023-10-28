import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teacher_side/app/Model/constants.dart';
import 'package:teacher_side/app/modules/home/home_store.dart';
import 'package:teacher_side/app/core/models/student_model.dart';
import 'package:teacher_side/app/modules/main/main_controller.dart';
import 'package:teacher_side/app/modules/student_data/message/activity_card.dart';
import 'package:teacher_side/shared/Date/date_picker_widget.dart';
import 'package:teacher_side/shared/components/responsive.dart';
import '../student_data_controller.dart';
import 'activity_card.dart';

class StudentActivityHistory extends StatefulWidget {
  final StudentModel studentModel;

  const StudentActivityHistory({
    Key? key,
    required this.studentModel,
  }) : super(key: key);
  @override
  _StudentActivityHistoryState createState() => _StudentActivityHistoryState();
}

class _StudentActivityHistoryState extends State<StudentActivityHistory> {
  final HomeStore homeStore = Modular.get();
  DateTime _selectedValue = DateTime.now();
  DatePickerController _controller = DatePickerController();
  final StudentDataController studentController = Modular.get();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _setCalendar();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Center(
              child: Text(
                "${_getMonth(_selectedValue.month)}, ${_selectedValue.year}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Responsive.isMobile(context) ? 19 : 28),
              ),
            ),
            SizedBox(height: defaultPadding),
            DatePicker(
              DateTime.now().subtract(Duration(days: 30)),
              height: 80,
              width: Responsive.isMobile(context) ? 65 : 100,
              controller: _controller,
              initialSelectedDate: DateTime.now(),
              locale: "pt-BR",
              onDateChange: (date) {
                setState(() {
                  _selectedValue = date;
                  studentController.selectedDate = date;
                  print("Data selecionada $date");
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Row(
                children: [Text("Atividades do dia")],
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  //RECARREGAR OS DADOS DO MESMO DIA
                  print("Alo");
                  _setCalendar();
                },
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: getData(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    return GridView.builder(
                        gridDelegate:
                            new SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    Responsive.isMobile(context) ? 1 : 2,
                                childAspectRatio:
                                    Responsive.isMobile(context) ? 2.7 : 3.8),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          print("data: ${snapshot.data}");
                          return ActivityCard(
                            hour:
                                "${snapshot.data![index]["created_at"].toDate().hour}:${snapshot.data![index]["created_at"].toDate().minute.toString().padLeft(2, "0")}",
                            activityMap: snapshot.data![index],
                            isActive: Responsive.isMobile(context)
                                ? false
                                : index == 0,
                            press: () {
                              //ABRIR A SHEET COM MAIS INFORMAÇÕES
                              print("Clicou na atividade!");
                            },
                          );
                        });
                  },
                ),
              ),
            ),
            SizedBox(height: defaultPadding)
          ],
        ),
      ),
    );
  }

  final MainController mainController = Modular.get();

  Future<List<Map<String, dynamic>>> getData() async {
    print("getData###############");

    QuerySnapshot<Map<String, dynamic>> query = await FirebaseFirestore.instance
        .collection("classes")
        .doc(mainController.classId)
        .collection("activities")
        .where("student_id", isEqualTo: widget.studentModel.id)
        .orderBy("created_at", descending: true)
        .get();

    print("query: ${query.docs.length}");

    List<Map<String, dynamic>> activities = [];

    query.docs.forEach((activitie) {
      String activitieDate =
          activitie["created_at"].toDate().toString().substring(0, 11);
      if (activitieDate == _selectedValue.toString().substring(0, 11)) {
        activities.add(activitie.data());
      }
    });

    return activities;
  }

  _getMonth(int month) {
    switch (month) {
      case 1:
        return "Janeiro";
      case 2:
        return "Fevereiro";
      case 3:
        return "Março";
      case 4:
        return "Abril";
      case 5:
        return "Maio";
      case 6:
        return "Junho";
      case 7:
        return "Julho";
      case 8:
        return "Agosto";
      case 9:
        return "Setembro";
      case 10:
        return "Outubro";
      case 11:
        return "Novembro";
      case 12:
        return "Dezembro";
      default:
        return "Invalido";
    }
  }

  _setCalendar() {
    setState(() {
      _controller.jumpToSelection(context);
    });
  }
}
