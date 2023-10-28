import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:teacher_side/app/modules/home/home_store.dart';
import 'package:teacher_side/app/modules/main/main_controller.dart';
part 'attendence_store.g.dart';

class AttendenceStore = _AttendenceStoreBase with _$AttendenceStore;

abstract class _AttendenceStoreBase with Store {
  final HomeStore homeStore = Modular.get();
  final MainController mainController = Modular.get();

  @action
  Future<bool> sendAttendence(context) async {

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
    print(
        "homeStore.studentAttendenceAltered: ${homeStore.studentAttendenceAltered}");
    for (String studentId in homeStore.studentAttendenceAltered) {
      String attendence = homeStore.studentAttendenceMap[studentId] != null
          ? homeStore.studentAttendenceMap[studentId]
          : "PRESENT";

      var attendenceObj = {
        "student_id": studentId,
        "teacher_id": FirebaseAuth.instance.currentUser!.uid,
        "activity": "ATTENDANCE",
        "attendence": attendence,
        "created_at": FieldValue.serverTimestamp(),
        "status": "VISIBLE",
        "title": getTitle(attendence),
        "id": null,
      };
      

      DocumentReference attendenceRef = await FirebaseFirestore.instance
          .collection('classes')
          .doc(mainController.classId)
          .collection('activities')
          .add(attendenceObj);

      await attendenceRef.update({"id": attendenceRef.id});

      attendenceObj["id"] = attendenceRef.id;

      await FirebaseFirestore.instance
          .collection('students')
          .doc(studentId)
          .collection('attendences')
          .doc(attendenceRef.id)
          .set(attendenceObj);
    }

    homeStore.studentAttendenceMap.clear();
    homeStore.studentAttendenceAltered.clear();
    mainController.pageListIndex = 0;
    homeStore.allAreSelected = false;
    overlayEntry.remove();
    return true;
  }

  @action
  Color getColor(String? attendence) {
    print('getColor: $attendence');
    switch (attendence) {
      case "PRESENT":
        return Colors.green;

      case "ABSENT":
        return Colors.red;

      case "LATE":
        return Colors.orange;

      case "EARLY":
        return Colors.blue;

      case "VIRTUAL":
        return Colors.purple;

      case null:
        return Colors.green;

      default:
        return Colors.grey;
    }
  }

  @action
  Future<void> studentAttendenceAltered(String studentId) async {
    print(
        "homeStore.studentAttendenceAltered: ${homeStore.studentAttendenceAltered}");
    if (!homeStore.studentAttendenceAltered.contains(studentId)) {
      homeStore.studentAttendenceAltered.add(studentId);
    }

    switch (homeStore.studentAttendenceMap[studentId]) {
      case null:
        homeStore.studentAttendenceMap[studentId] = 'ABSENT';
        break;

      case 'PRESENT':
        homeStore.studentAttendenceMap[studentId] = 'ABSENT';
        break;

      case 'ABSENT':
        homeStore.studentAttendenceMap[studentId] = 'LATE';
        break;

      case 'LATE':
        homeStore.studentAttendenceMap[studentId] = 'EARLY';
        break;

      case 'EARLY':
        homeStore.studentAttendenceMap[studentId] = 'VIRTUAL';
        break;

      case 'VIRTUAL':
        homeStore.studentAttendenceMap[studentId] = 'PRESENT';
        break;

      default:
    }
  }

  String getTitle(String attendence) {
    switch (attendence) {
      case 'PRESENT':
        return 'Aluno presente';

      case 'ABSENT':
        return 'Aluno faltou';

      case 'LATE':
        return 'Aluno atrasou';

      case 'EARLY':
        return 'Aluno saiu mais cedo';

      case 'VIRTUAL':
        return 'Aluno presente remotamente';

      default:
        return '';
    }
  }
}
