import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobx/mobx.dart';
import 'package:teacher_side/app/modules/main/main_controller.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final MainController mainController = Modular.get();
  @observable
  ObservableList selectedStudentsList = <String>[].asObservable();
  @observable
  bool allAreSelected = false;
  @observable
  bool broughtBottle = true;
  @observable
  double amtWater = 0;
  @observable
  int whatValue = 0;
  @observable
  QuerySnapshot? classesQuery;
  @observable
  ObservableMap foodStudentsMap = {}.asObservable();
  @observable
  ObservableMap studentAttendenceMap = {}.asObservable();
  @observable
  List<String> studentAttendenceAltered = [];

  @action
  Future<void> selectAll() async {
    if (!allAreSelected) {
      allAreSelected = true;
      QuerySnapshot studentsQuery = await FirebaseFirestore.instance
          .collection('classes')
          .doc(mainController.classId)
          .collection("students")
          .get();

      studentsQuery.docs.forEach((DocumentSnapshot studentDoc) {
        if (!selectedStudentsList.contains(studentDoc.id)) {
          selectedStudentsList.add(studentDoc.id);
        }
      });
    } else {
      allAreSelected = false;

      selectedStudentsList.clear();
    }
  }

  @action
  Future<List<DocumentSnapshot>> getStudents(String? classId) async {
    print('getStudents $classId');
    FirebaseAuth _auth = FirebaseAuth.instance;
    User? _user = _auth.currentUser;
    if(classId == null){
      DocumentSnapshot teacherDoc = await FirebaseFirestore.instance
          .collection('teachers')
          .doc(_user!.uid)
          .get();

      QuerySnapshot _classesQuery = await teacherDoc.reference
          .collection('classes')
          .orderBy('created_at', descending: true)
          .get();

      if(_classesQuery.docs.isNotEmpty){
        mainController.classId = _classesQuery.docs.first.id;
        QuerySnapshot classStudents = await FirebaseFirestore.instance
            .collection('classes')
            .doc(mainController.classId)
            .collection("students")
            .get();

        List<DocumentSnapshot> stdsDocs = [];
        // print("classStudents.docs: ${classStudents.docs}");
        for (int i = 0; i < classStudents.docs.length; i++) {
          stdsDocs.add(await FirebaseFirestore.instance
              .collection("students")
              .doc(classStudents.docs[i].id)
              .get());
        }
        stdsDocs.sort((a, b) => a['username'].compareTo(b['username']));
        return stdsDocs;
      }
      return [];
    } else {
      QuerySnapshot classStudents = await FirebaseFirestore.instance
          .collection('classes')
          .doc(classId)
          .collection("students")
          .get();

      List<DocumentSnapshot> stdsDocs = [];
      // print("classStudents.docs: ${classStudents.docs}");
      for (int i = 0; i < classStudents.docs.length; i++) {
        stdsDocs.add(await FirebaseFirestore.instance
            .collection("students")
            .doc(classStudents.docs[i].id)
            .get());
      }
      stdsDocs.sort((a, b) => a['username'].compareTo(b['username']));
      return stdsDocs;
    }
  }

  // @action
  // Future<List<DocumentSnapshot>> getClasseStudents() async {
  //   QuerySnapshot classStudents = await FirebaseFirestore.instance
  //       .collection('classes')
  //       .doc(mainController.classId)
  //       .collection("students")
  //       .get();

  //   List<DocumentSnapshot> stdsDocs = [];

  //   Map<String, String> studentsFoodData = {};

  //   classStudents.docs.forEach((studentDoc) async {
  //     studentsFoodData[studentDoc.id] = "ALL";
  //     stdsDocs.add(await FirebaseFirestore.instance
  //         .collection("students")
  //         .doc(studentDoc.id)
  //         .get());
  //   });

  //   foodStudentsMap = studentsFoodData.asObservable();

  //   return stdsDocs;
  // }

  @action
  setStudentFoodStatus(String? _id) {
    if (!foodStudentsMap.containsKey(_id)) {
      foodStudentsMap[_id] = "ALL";
      return;
    }

    String studentStatus = foodStudentsMap[_id];

    switch (studentStatus) {
      case "ALL":
        foodStudentsMap[_id] = "PART";
        break;
      case "PART":
        foodStudentsMap[_id] = "NOTHING";
        break;
      case "NOTHING":
        foodStudentsMap.remove(_id);
        break;
      default:
        return;
    }
    return;
  }

  @action
  Color getFoodColor(String? foodStatus) {
    switch (foodStatus) {
      case "ALL":
        return Colors.green;
      case "PART":
        return Colors.yellow;
      case "NOTHING":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @action
  Future<bool> sendFoodData(String foodWater, String? mealOfTheDay,
      String _text, context, String _title) async {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black45,
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),
      ),
    );
    Overlay.of(context)!.insert(overlayEntry);

    String teacherId = FirebaseAuth.instance.currentUser!.uid;
    Map<String, dynamic> map = {};
    if (foodWater == "FOOD") {
      if (foodStudentsMap.isEmpty) {
        Fluttertoast.showToast(msg: "Selecione ao menos um aluno");
        overlayEntry.remove();
        return false;
      }
      foodStudentsMap.forEach((key, value) async {
        map = {
          "activity": "FOOD",
          "created_at": FieldValue.serverTimestamp(),
          "id": null,
          "class_id": mainController.classId,
          "meal_of_the_day": mealOfTheDay,
          "note": _text,
          "quantity": value,
          "status": "ACTIVE",
          "student_id": key,
          "teacher_id": teacherId,
          "type": "FOOD",
          "title": _title,
        };
        // print("map: $map");
        await FirebaseFirestore.instance
            .collection("classes")
            .doc(mainController.classId)
            .collection("activities")
            .add(map)
            .then((activity) => activity.update({"id": activity.id}));
      });
    } else {
      if (selectedStudentsList.isEmpty) {
        Fluttertoast.showToast(msg: "Selecione ao menos um aluno");
        overlayEntry.remove();
        return false;
      }
      selectedStudentsList.forEach((_studentId) async {
        map = {
          "activity": "FOOD",
          "created_at": FieldValue.serverTimestamp(),
          "id": null,
          "brought_bottle": broughtBottle,
          "amt_water": amtWater,
          "status": "ACTIVE",
          "student_id": _studentId,
          "teacher_id": teacherId,
          "type": "WATER",
          "title": "$amtWater L de água",
        };
        // print("map: $map");
        DocumentReference actRef = await FirebaseFirestore.instance
            .collection("classes")
            .doc(mainController.classId)
            .collection("activities")
            .add(map);

        await actRef.update({"id": actRef.id});

        map["id"] = actRef.id;

        await FirebaseFirestore.instance
            .collection("students")
            .doc(_studentId)
            .collection("food")
            .doc(actRef.id)
            .set(map);
      });
    }
    amtWater = 0;
    overlayEntry.remove();
    mainController.pageListIndex = 0;
    foodStudentsMap.clear();
    broughtBottle = true;
    allAreSelected = false;
    return true;
  }

  Future<void> getStudentStatusColor(String studentId) async {
    // print('getStudentStatusColor: $studentId');

    DateTime nowDate = DateTime.now();

    Timestamp startTime =
        Timestamp.fromDate(DateTime(nowDate.year, nowDate.month, nowDate.day));

    // print('startTime: ${DateTime(nowDate.year, nowDate.month, nowDate.day)} - $startTime');

    // Timestamp endTime = Timestamp.fromDate(
    //     DateTime(nowDate.year, nowDate.month, nowDate.day, 23, 59, 59));

    // print('endTime: ${DateTime(nowDate.year, nowDate.month, nowDate.day, 23, 59, 59)} - $endTime');

    DocumentSnapshot studentDoc = await FirebaseFirestore.instance
        .collection('students')
        .doc(studentId)
        .get();

    QuerySnapshot attendences = await studentDoc.reference
        .collection('attendences')
        .where('status', isEqualTo: 'VISIBLE')
        .where('created_at', isGreaterThanOrEqualTo: startTime)
        // .where('created_at', isLessThanOrEqualTo: endTime)
        .orderBy('created_at', descending: true)
        .get();

    print('attendences length ${attendences.docs.length}');
    int length = attendences.docs.length;

    if (length != 0) {
      DocumentSnapshot attendenceDoc = attendences.docs.first;
      studentAttendenceMap[studentId] = attendenceDoc['attendence'];
    } else {
      if (!studentAttendenceAltered.contains(studentId)) {
        studentAttendenceAltered.add(studentId);
      }
    }
  }

  @action
  String dateFormatting(Timestamp date, [bool withHour = false]) {
    List monthList = [
      '',
      'Janeiro',
      'Feverreiro',
      'Março',
      'Abril',
      'Maio',
      'Junho',

      'Julho',
      'Agosto',
      'Setembro',
      'Outubro',
      'Novembro',
      'Dezembro',
    ];
    String day = date.toDate().day.toString().padLeft(2, '0');
    int month = date.toDate().month;
    String monthName = monthList[month];
    String year = date.toDate().year.toString().padLeft(2, '0');
    String dateFormatted = '$day de $monthName de $year';
    if (withHour) {
      String hourFormatted = date.toDate().hour.toString().padLeft(2, '0') +
          ':' +
          date.toDate().minute.toString().padLeft(2, '0');
      return dateFormatted + ' às $hourFormatted';
    } else {
      return dateFormatted;
    }
  }
}
