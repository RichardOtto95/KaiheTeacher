import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:teacher_side/app/modules/main/main_controller.dart';
part 'classroom_controller.g.dart';

@Injectable()
class ClassroomController = _ClassroomControllerBase with _$ClassroomController;

abstract class _ClassroomControllerBase with Store {
  final MainController mainController = Modular.get();

  @observable
  OverlayEntry? addStudentOverlay;
  @observable
  String teacherName = '';
  @observable
  String teacherRegister = '';
  @observable
  bool removingStudents = false;
  @observable
  ObservableList removeStudentsList = <String>[].asObservable();

  @action
  Future<bool> addStudent(context, String name, String matricula, Function? setState) async {
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
    final clsRef = FirebaseFirestore.instance
        .collection("classes")
        .doc(mainController.classId);

    final matStud = await FirebaseFirestore.instance
        .collection("students")
        .where("register", isEqualTo: matricula)
        .get();
    late DocumentReference stdRef;
    if (matStud.docs.length == 0) {
      stdRef = await FirebaseFirestore.instance.collection("students").add({
        "allergy": "",
        "authorized_take_hospital": "",
        "avatar": null,
        "birthday": FieldValue.serverTimestamp(),
        "blood_type": "",
        "created_at": FieldValue.serverTimestamp(),
        "id": "",
        "doctors_prescription": [],
        "last_view": FieldValue.serverTimestamp(),
        "prescription_drug": "",
        "register": matricula,
        "hospital": "",
        "username": name,
      });

      await stdRef.update({"id": stdRef.id});
    } else {
      final clsStdDoc = await clsRef
          .collection("students")
          .doc(matStud.docs.first.reference.id)
          .get();

      if (clsStdDoc.exists) {
        Fluttertoast.showToast(msg: "Aluno já adicionado à classe");
        overlayEntry.remove();
        return false;
      }

      stdRef = matStud.docs.first.reference;
    }

    final addColRef = stdRef.collection("classes").doc(mainController.classId);

    await addColRef.set({
      "created_at": FieldValue.serverTimestamp(),
      "id": mainController.classId,
    });

    final addStdRef = clsRef.collection("students").doc(stdRef.id);

    await addStdRef.set({
      "created_at": FieldValue.serverTimestamp(),
      "id": stdRef.id,
    });
    overlayEntry.remove();
    if(setState != null){
      setState();
    }
    return true;
  }

  @action
  Future<void> addTeacher(context) async {
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
    QuerySnapshot teachers = await FirebaseFirestore.instance
        .collection('teachers')
        .where('register', isEqualTo: teacherRegister)
        .get();

    if (teachers.docs.isNotEmpty) {
      DocumentSnapshot teacherDoc = teachers.docs.first;

      DocumentSnapshot classDoc = await FirebaseFirestore.instance
          .collection('classes')
          .doc(mainController.classId)
          .get();

      if (classDoc.exists == false) {
        DocumentSnapshot classTeacher = await classDoc.reference.collection('teachers').doc(teacherDoc.id).get();

        if(classTeacher.exists){
          overlayEntry.remove();

          Fluttertoast.showToast(
              msg: 'O professor com esse registro já se encontra nesta turma',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          await teacherDoc.reference
              .collection('classes')
              .doc(mainController.classId)
              .set({
            'created_at': FieldValue.serverTimestamp(),
            'id': mainController.classId,
          });

          await classDoc.reference.collection("teachers").doc(teacherDoc.id).set({
            'added_at': FieldValue.serverTimestamp(),
            'id': teacherDoc.id,
          });

          final claTeaRef = FirebaseFirestore.instance
              .collection("classes")
              .doc(mainController.classId)
              .collection("teachers")
              .doc(teacherDoc.id);

          await claTeaRef.set({
            "created_at": FieldValue.serverTimestamp(),
            "id": teacherDoc.id,
            "status": "ACTIVE",
          });
          addStudentOverlay!.remove();
          overlayEntry.remove();
        }
      }
    } else {
      overlayEntry.remove();
      Fluttertoast.showToast(
          msg: 'Nenhum professor com esse registro foi encontrado',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @action
  Future removeStudents(context) async {
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

    final clsRef = FirebaseFirestore.instance
        .collection("classes")
        .doc(mainController.classId);

    removeStudentsList.forEach((studentId) async {
      await FirebaseFirestore.instance
          .collection("students")
          .doc(studentId)
          .collection("classes")
          .doc(mainController.classId)
          .delete();
      await clsRef.collection("students").doc(studentId).delete();
    });

    removingStudents = false;
    removeStudentsList.clear();
    overlayEntry.remove();
  }

  @action
  setClassroomImage(context) async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
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
        File _imageFile = File(pickedFile.path);
        Reference firebaseStorageRef = FirebaseStorage.instance
            .ref()
            .child('classroom/${mainController.classId}/${_imageFile.path[0]}');
        UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadURL = await taskSnapshot.ref.getDownloadURL();
        await FirebaseFirestore.instance
            .collection("classes")
            .doc(mainController.classId)
            .update({"avatar": downloadURL});
        overlayEntry.remove();
      }
    }
  }
}
