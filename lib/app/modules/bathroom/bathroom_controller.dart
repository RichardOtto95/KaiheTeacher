import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teacher_side/app/modules/home/home_store.dart';
import 'package:teacher_side/app/modules/main/main_controller.dart';
part 'bathroom_controller.g.dart';

@Injectable()
class BathroomController = _BathroomControllerBase with _$BathroomController;

abstract class _BathroomControllerBase with Store {
  final MainController mainController = Modular.get();
  final HomeStore homeStore = Modular.get();

  @observable
  int bathroomPage = 0;
  @observable
  String what = "EVACUATED";
  @observable
  String how = "CONSISTENT";
  @observable
  String where = "DIAPER";
  @observable
  String note = '';
  @observable
  String option = "TEETH";
  @observable
  bool sanitized = true;

  Future<QuerySnapshot> getStudents() async {
    QuerySnapshot studentsQuery = await FirebaseFirestore.instance
        .collection('students')
        .where('class_id', isEqualTo: mainController.classId)
        .get();

    return studentsQuery;
  }

  Future<bool> sendBathroomData(context, title) async {
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

    if (homeStore.selectedStudentsList.isEmpty) {
      overlayEntry.remove();
      return false;
    }


    String teacherId = FirebaseAuth.instance.currentUser!.uid;
    homeStore.selectedStudentsList.forEach((studentId) async {
      Map<String, dynamic> _data = {
        "activity": "BATHROOM",
        "created_at": FieldValue.serverTimestamp(),
        "id": null,
        "class_id": mainController.classId,
        "note": note,
        "student_id": studentId,
        "teacher_id": teacherId,
        "what": what,
        "title": title,
      };

      if (what == "EVACUATED") {
        _data["how"] = how;
        _data["where"] = where;
      } else if (what == "URINATED") {
        _data["where"] = where;
      } else if (what == "HYGIENE") {
        _data["option"] = option;
        _data["sanitized"] = sanitized;
      }

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
          .collection("bathroom")
          .doc(actRef.id)
          .set(_data);
    });

    overlayEntry.remove();
    cleanVars();
    mainController.pageListIndex = 0;
    homeStore.allAreSelected = false;
    return true;
  }

  @action
  void cleanVars() {
    what = "EVACUATED";
    how = "CONSISTENT";
    where = "DIAPER";
    option = "TEETH";
    bathroomPage = 0;
    note = "";
    sanitized = true;
    homeStore.selectedStudentsList = [].asObservable();
  }

  
  
}
