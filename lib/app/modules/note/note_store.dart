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
part 'note_store.g.dart';

class NoteStore = _NoteStoreBase with _$NoteStore;

abstract class _NoteStoreBase with Store {
  final MainController mainController = Modular.get();
  final HomeStore homeStore = Modular.get();

  @observable
  bool authorizationNote = false;
  @observable
  int? notePage;
  @observable
  String title = '';
  @observable
  String? type;
  @observable
  String? note;
  @observable
  bool requestAuthorization = true;
  @observable
  bool requestPresence = true;
  @observable
  ObservableList<Uint8List> imagesList = ObservableList<Uint8List>();
  @observable
  List<String> fileNameList = [];

  @action
  changeAuthorizationNote() {
    if (authorizationNote == false) {
      authorizationNote = true;
    } else {
      authorizationNote = false;
    }
  }

  @action
  pickImage() async {
    bool permission =
        kIsWeb ? true : await Permission.storage.request().isGranted;

    if (permission) {
      final XFile? pickedFile =
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

  Future<String> sendNoteData(context) async {
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
      Fluttertoast.showToast(msg: "Escreva um título");
      overlayEntry.remove();
      return 'emptyTitle';
    } else if (homeStore.selectedStudentsList.isEmpty) {
      Fluttertoast.showToast(msg: "Selecione ao menos um aluno");
      overlayEntry.remove();
      return 'emptyStudents';
    }

    String teacherId = FirebaseAuth.instance.currentUser!.uid;

    homeStore.selectedStudentsList.forEach((studentId) async {
      Map<String, dynamic> _data = {
        "activity": "NOTE",
        "created_at": FieldValue.serverTimestamp(),
        "id": null,
        "class_id": mainController.classId,
        "student_id": studentId,
        "teacher_id": teacherId,
        "note": note,
        "title": title,
        "type": type,
        "request_authorization": requestAuthorization,
        "request_presence": requestPresence,
        "need_auth": authorizationNote,
        'isAuthorized': false
      };

      DocumentReference actRef = await FirebaseFirestore.instance
          .collection("classes")
          .doc(mainController.classId)
          .collection("activities")
          .add(_data);

      List newImagesList = [];
      for (var i = 0; i < imagesList.length; i++) {
        Uint8List image = imagesList[i];
        String fileName = fileNameList[i];

        Reference firebaseStorageRef = FirebaseStorage.instance
            .ref()
            .child('homeworks/${actRef.id}/images/$fileName');

        UploadTask uploadTask = firebaseStorageRef.putData(image);

        TaskSnapshot taskSnapshot = await uploadTask;

        String downloadURL = await taskSnapshot.ref.getDownloadURL();
        newImagesList.add(downloadURL);
      }

      await actRef.update({"id": actRef.id, "images": newImagesList});
      _data["id"] = actRef.id;
      _data["images"] = newImagesList;

      await FirebaseFirestore.instance
          .collection("students")
          .doc(studentId)
          .collection("notes")
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
    notePage = null;
    title = '';
    type = null;
    note = null;
    requestAuthorization = true;
    requestPresence = true;
    homeStore.selectedStudentsList = <String>[].asObservable();
  }
}
