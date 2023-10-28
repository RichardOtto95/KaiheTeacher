import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'student_data_controller.g.dart';

@Injectable()
class StudentDataController = _StudentDataControllerBase
    with _$StudentDataController;

abstract class _StudentDataControllerBase with Store {
  @observable
  List<DocumentSnapshot> activitiesList = [];
  @observable
  DateTime selectedDate = DateTime.now();
  @observable
  String reportNote = '';
  @observable
  bool editReports = false;

  @action
  Future<void> removeReport(String reportId, String studentId, BuildContext context) async{
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black45,
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
    Overlay.of(context)!.insert(overlayEntry);
    DocumentSnapshot reportDoc = await FirebaseFirestore.instance
      .collection('students')
      .doc(studentId)
      .collection('reports')
      .doc(reportId)
      .get();

    await reportDoc.reference.update({
      "status": "DELETED",
      "deleted_by": FirebaseAuth.instance.currentUser!.uid,
    });
    try {
      await FirebaseFirestore.instance.collection('classes').doc(reportDoc['class_id']).collection('activities').doc(reportId).update({
        "status": "DELETED",
        "deleted_by": FirebaseAuth.instance.currentUser!.uid,
      });      
    } catch (e) {
    }

    overlayEntry.remove();
  }

  @action
  void mountList(QuerySnapshot<Object?>? activities) {
    List<DocumentSnapshot> newList = [];
    print('activities : ${activities!.docs.length}');
    activities.docs.forEach((activityDoc) {
      DateTime createdAt = activityDoc['created_at'].toDate();

      if (createdAt.year == selectedDate.year &&
          createdAt.month == selectedDate.month &&
          createdAt.day == selectedDate.day) {
        print('add : ${activityDoc.id}');

        newList.add(activityDoc);
      }
    });

    print('newList: ${newList.length}');

    activitiesList = newList;
  }
}
