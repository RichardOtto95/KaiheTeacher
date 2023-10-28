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
import 'package:teacher_side/shared/utilities.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

part 'moment_store.g.dart';

class MomentStore = _MomentStoreBase with _$MomentStore;

abstract class _MomentStoreBase with Store {
  final MainController mainController = Modular.get();
  final HomeStore homeStore = Modular.get();

  @observable
  int? momentPage = 0;
  @observable
  String? title;
  @observable
  String? description;
  @observable
  ObservableList<Uint8List> imagesList = ObservableList<Uint8List>();
  @observable
  ObservableList medals = [].asObservable();
  @observable
  List<String> fileNameList = [];

  @action
  pickImage() async {
    bool permission = kIsWeb ? true : await Permission.storage.request().isGranted;
    if (permission) {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        Uint8List _uint8List = await pickedFile.readAsBytes();
        imagesList.add(_uint8List);
        fileNameList.add(pickedFile.name);
      }
    }   
  }

  @action
  void selectStudent(String studentId) {
    if (homeStore.selectedStudentsList.contains(studentId)) {
      homeStore.selectedStudentsList.remove(studentId);
    } else {
      homeStore.selectedStudentsList.add(studentId);
    }
  }

  Future<String> sendMomentData(context) async {
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

    if (title == "" || title == null) {
      Fluttertoast.showToast(msg: "Escreva um título para este momento");
      overlayEntry.remove();
      return 'emptyTitle';
    } 
     else if (homeStore.selectedStudentsList.isEmpty) {
      Fluttertoast.showToast(msg: "Selecione ao menos um aluno");
      overlayEntry.remove();
      return 'emptyStudents';
    }

    String teacherId = FirebaseAuth.instance.currentUser!.uid;

    List urlImages = [];

    for (var i = 0; i < imagesList.length; i++) {
      Uint8List image = imagesList[i];
      String fileName = fileNameList[i];

      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('moments/${getRandomString(20)}/images/$fileName');

      UploadTask uploadTask = firebaseStorageRef.putData(image);

      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      urlImages.add(downloadURL);
    }

    homeStore.selectedStudentsList.forEach((studentId) async {
      Map<String, dynamic> _data = {
        "activity": "MOMENT",
        "created_at": FieldValue.serverTimestamp(),
        "class_id": mainController.classId,
        "id": null,
        "student_id": studentId,
        "teacher_id": teacherId,
        "title": title,
        "description": description,
        "medals": medals,
        "images": urlImages,
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
          .collection("moments")
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
    title = null;
    description = null;
    medals = [].asObservable();
    imagesList.clear();
    homeStore.selectedStudentsList = <String>[].asObservable();
  }
}
