import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teacher_side/app/modules/home/home_store.dart';
import 'package:teacher_side/app/modules/main/main_controller.dart';

part 'sleep_controller.g.dart';

@Injectable()
class SleepController = _SleepControllerBase with _$SleepController;

abstract class _SleepControllerBase with Store {
  final MainController mainController = Modular.get();
  final HomeStore homeStore = Modular.get();

  @observable
  int? sleepPage = 0;
  @observable
  bool slept = true;
  @observable
  bool sleepWell = true;
  @observable
  String note = "";
  @observable
  DateTime start = DateTime.now().subtract(Duration(minutes: 30));
  @observable
  DateTime duration = DateTime(0);

  @action
  void selectStudent(String studentId) {
    // print("studentId: $studentId");
    if (homeStore.selectedStudentsList.contains(studentId)) {
      homeStore.selectedStudentsList.remove(studentId);
    } else {
      homeStore.selectedStudentsList.add(studentId);
    }
  }

  Future<String> sendSleepData(context, title) async {
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

    if (duration == DateTime(0) && slept) {
      Fluttertoast.showToast(msg: "Selecione uma duração");
      overlayEntry.remove();
      return 'emptyDuration';
    } else if (homeStore.selectedStudentsList.isEmpty) {
      Fluttertoast.showToast(msg: "Selecione ao menos um aluno");
      overlayEntry.remove();
      return 'emptystudents';
    }

    String teacherId = FirebaseAuth.instance.currentUser!.uid;

    print("duration: $duration");

    int dur = duration.hour * 60 + duration.minute;

    homeStore.selectedStudentsList.forEach((studentId) async {
      Map<String, dynamic> _data = {
        "activity": "SLEEP",
        "created_at": FieldValue.serverTimestamp(),
        "class_id": mainController.classId,
        "id": null,
        "student_id": studentId,
        "teacher_id": teacherId,
        "slept": slept,
        "sleep_well": slept ? sleepWell : null,
        "start": Timestamp.fromDate(start),
        "duration": dur,
        "note": note,
        "status": "VISIBLE",
        "title": title,
      };
      // print("data: $_data");
      DocumentReference actRef = await FirebaseFirestore.instance
          .collection("classes")
          .doc(mainController.classId)
          .collection("activities")
          .add(_data);

      await actRef.update({"id": actRef.id});

      _data["id"] = actRef.id;

      await FirebaseFirestore.instance
          .collection("students")
          .doc(studentId)
          .collection("sleeps")
          .doc(actRef.id)
          .set(_data);
    });

    overlayEntry.remove();
    cleanVars();

    mainController.pageListIndex = 0;
    homeStore.allAreSelected = false;
    return 'send';
  }

  @action
  void cleanVars() {
    sleepPage = 0;
    slept = true;
    sleepWell = true;
    note = "";
    start = DateTime.now().subtract(Duration(minutes: 30));
    duration = DateTime.now();
    homeStore.selectedStudentsList = <String>[].asObservable();
  }
}
