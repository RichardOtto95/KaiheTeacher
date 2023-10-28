import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:teacher_side/app/modules/home/home_store.dart';
import 'package:teacher_side/app/modules/main/main_controller.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
part 'homework_store.g.dart';

class HomeworkStore = _HomeworkStoreBase with _$HomeworkStore;

abstract class _HomeworkStoreBase with Store {
  final MainController mainController = Modular.get();
  final HomeStore homeStore = Modular.get();

  @observable
  String title = '';
  @observable
  String? note;
  @observable
  String? homeworkSelected;
  // List<String> homeworkSelectedList = [];
  @observable
  int homeworkPage = 0;
  @observable
  ObservableList<Uint8List> imagesList = ObservableList<Uint8List>();
  @observable
  ObservableList<String> imagesNameList = ObservableList<String>();

  @action
  Future<QuerySnapshot> getStudents() async {
    QuerySnapshot studentsQuery = await FirebaseFirestore.instance
        .collection("students")
        .where("class_id", isEqualTo: mainController.classId)
        .get();

    List<String> studentIds = [];
    studentsQuery.docs.forEach((studentDoc) {
      studentIds.add(studentDoc.id);
    });

    homeStore.selectedStudentsList = studentIds.asObservable();

    return studentsQuery;
  }

  @action
  void selectStudent(String studentId) {
    if (homeStore.selectedStudentsList.contains(studentId)) {
      homeStore.selectedStudentsList.remove(studentId);
    } else {
      homeStore.selectedStudentsList.add(studentId);
    }
  }

  Future<String> sendHomeworkData(context) async {
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

    if (title == "") {
      Fluttertoast.showToast(msg: "Digite um título para o seu dever de casa");
      overlayEntry.remove();
      return 'emptyTitle';
    } else if (note == "" || note == null && imagesList.isEmpty) {
      Fluttertoast.showToast(
          msg: "Digite uma anotação ou adicione imagens ao seu dever de casa");
      overlayEntry.remove();
      return 'emptyAnotationorImage';
    } else if (homeStore.selectedStudentsList.isEmpty) {
      Fluttertoast.showToast(msg: "Selecione ao menos um aluno");
      overlayEntry.remove();
      return 'emptyStudents';
    }

    String teacherId = FirebaseAuth.instance.currentUser!.uid;

    Map<String, dynamic> homeworkMap = {
      "created_at": FieldValue.serverTimestamp(),
      "class_id": mainController.classId,
      "id": null,
      "note": note,
      "teacher_id": teacherId,
      "title": title,
      "status": "TO_DO",
      "images": null,
      "checked": false,
      "updated_at": FieldValue.serverTimestamp(),
    };

    DocumentReference homeworkRef = await FirebaseFirestore.instance
      .collection("classes")
      .doc(mainController.classId)
      .collection("homeworks")
      .add(homeworkMap);

    await homeworkRef.update({
      'id': homeworkRef.id,
    });
    homeworkMap['id'] = homeworkRef.id;

    List newImagesList = [];
    for (var i = 0; i < imagesList.length; i++) {
      Uint8List image = imagesList[i];
      String fileName = imagesNameList[i];

      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('homeworks/${homeworkRef.id}/images/$fileName');

      UploadTask uploadTask = firebaseStorageRef.putData(image);

      TaskSnapshot taskSnapshot = await uploadTask;

      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      newImagesList.add(downloadURL);
    }

    await homeworkRef.update({"images": newImagesList});
    homeworkMap['images'] = newImagesList;

    Map<String, dynamic> activitieMap = {
      "activity": "HOMEWORK",
      "class_id": mainController.classId,
      "created_at": FieldValue.serverTimestamp(),
      "id": null,
      "student_id": null,
      "teacher_id": teacherId,
      "homework_id": homeworkRef.id,
      "status": "TO_DO",
      "title": title,
      "note": note,
      "images": newImagesList,
      "updated_at": FieldValue.serverTimestamp(),
    };

    homeStore.selectedStudentsList.forEach((studentId) async {
      DocumentReference actRef = await FirebaseFirestore.instance
          .collection("classes")
          .doc(mainController.classId)
          .collection("activities")
          .add(activitieMap);

      await actRef.update({"id": actRef.id, "student_id": studentId});

      activitieMap["id"] = actRef.id;

      await FirebaseFirestore.instance
        .collection("students")
        .doc(studentId)
        .collection("homeworks")
        .doc(homeworkRef.id)
        .set(homeworkMap);
    });

    overlayEntry.remove();
    cleanVars();
    homeStore.allAreSelected = false;
    mainController.pageListIndex = 0;
    return 'send';
  }

  Future<bool> checkHomework(context) async {
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
        
    if (homeworkSelected == null) {
      overlayEntry.remove();
      Fluttertoast.showToast(msg: "Selecione um dever de casa");
      return false;
    }

    await FirebaseFirestore.instance
      .collection("classes")
      .doc(mainController.classId)
      .collection("homeworks")
      .doc(homeworkSelected)
      .update({
        "checked": true,
        "updated_at": FieldValue.serverTimestamp(),
      });

    QuerySnapshot homeworkStudentsQuery = await FirebaseFirestore.instance
        .collection("classes")
        .doc(mainController.classId)
        .collection("activities")
        .where("homework_id", isEqualTo: homeworkSelected)
        .where("status", isNotEqualTo: "DONE")
        .get();

    print('homeworkStudentsQuery: ${homeworkStudentsQuery.docs.length}');


    for (var homeworkActivitie in homeworkStudentsQuery.docs) {
      print('for inicio');

      await homeworkActivitie.reference.update({
        "updated_at": FieldValue.serverTimestamp(),
      });

      print('for meio ${homeworkActivitie['student_id']} - $homeworkSelected');

      await FirebaseFirestore.instance.collection('students').doc(homeworkActivitie['student_id']).collection('homeworks').doc(homeworkSelected).update({
        "checked": true,
        "updated_at": FieldValue.serverTimestamp(),
      });
      print('for fim');

    }

    print('FIm');
    overlayEntry.remove();
    cleanVars();
    mainController.pageListIndex = 0;
    return true;
  }

  void cleanVars() {
    title = '';
    note = null;
    homeworkPage = 0;
    imagesList.clear();
    homeStore.selectedStudentsList.clear();
    homeworkSelected = null;
  }

  @action
  pickImage() async {
    bool permission = kIsWeb ? true : await Permission.storage.request().isGranted;
    if (permission) {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        Uint8List _uint8List = await pickedFile.readAsBytes();
        imagesNameList.add(pickedFile.name);
        imagesList.add(_uint8List);
      }
    }
  }
}
