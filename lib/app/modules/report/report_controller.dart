import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:teacher_side/app/modules/home/home_store.dart';
import 'package:teacher_side/app/modules/main/main_controller.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
part 'report_controller.g.dart';

@Injectable()
class ReportController = _ReportControllerBase with _$ReportController;

abstract class _ReportControllerBase with Store {
  final HomeStore homeStore = Modular.get();
  final MainController mainController = Modular.get();

  @observable
  TextEditingController textEditingControllerTitle = TextEditingController();
  @observable
  TextEditingController textEditingControllerNote = TextEditingController();
  @observable
  ObservableList<Uint8List> imagesList = ObservableList<Uint8List>();
  @observable
  List<String> fileNameList = [];

  @action
  void clear() {
    textEditingControllerNote.clear();
    textEditingControllerTitle.clear();
    imagesList.clear();
    homeStore.selectedStudentsList.clear();
    homeStore.allAreSelected = false;
    mainController.pageListIndex = 0;
    homeStore.allAreSelected = false;
  }

  @action
  pickImage() async {
    bool permission = kIsWeb ? true : await Permission.storage.request().isGranted;

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
  Future<String> toSend(context) async {
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
    bool validNote = textEditingControllerNote.text.isNotEmpty;
    bool validTitle = textEditingControllerTitle.text.isNotEmpty;
    // bool validImages = kIsWeb ? webImageList.isNotEmpty : imagesList.isNotEmpty;
    bool validImages = imagesList.isNotEmpty;
    bool validStudents = homeStore.selectedStudentsList.isNotEmpty;
    if(!validStudents){
      return 'emptyStudents';
    }
    if(textEditingControllerTitle.text == ''){
      return 'emptyTitle';
    }
    if (validNote && validTitle && validImages && validStudents) {
      FirebaseAuth _auth = FirebaseAuth.instance;
      User _user = _auth.currentUser!;
      Map<String, dynamic> report = {
        'images': [],
        'title': textEditingControllerTitle.text,
        'note': textEditingControllerNote.text,
        'student_id': null,
        'teacher_id': _user.uid,
        'id': null,
        'status': 'ACTIVE',
        'created_at': FieldValue.serverTimestamp(),
        "class_id": mainController.classId,
      };

      for (var studentId in homeStore.selectedStudentsList) {
        DocumentReference activityref = await FirebaseFirestore.instance
            .collection('classes')
            .doc(mainController.classId)
            .collection('activities')
            .add(report);

        List newImagesList = [];

        for (var i = 0; i < imagesList.length; i++) {            
          Uint8List image = imagesList[i];
          String fileName = fileNameList[i];

          Reference firebaseStorageRef = FirebaseStorage.instance
              .ref()
              .child('reports/${activityref.id}/images/$fileName');

          UploadTask uploadTask = firebaseStorageRef.putData(image);

          TaskSnapshot taskSnapshot = await uploadTask;

          String downloadURL = await taskSnapshot.ref.getDownloadURL();
          newImagesList.add(downloadURL);
        }    
   
        report['id'] = activityref.id;
        report['images'] = newImagesList;
        report['student_id'] = studentId;
        print('report: $report');

        await activityref.update({
          'id': activityref.id,
          'student_id': studentId,
          'images': newImagesList,
          'activity': 'REPORT',
        });

        await FirebaseFirestore.instance
            .collection('students')
            .doc(studentId)
            .collection('reports')
            .doc(activityref.id)
            .set(report);
      }
      textEditingControllerNote.clear();
      textEditingControllerTitle.clear();
      imagesList.clear();
      homeStore.selectedStudentsList.clear();
      homeStore.allAreSelected = false;
      mainController.pageListIndex = 0;
      homeStore.allAreSelected = false;
      overlayEntry.remove();
      return 'send';

    } else {
      
      Fluttertoast.showToast(
        timeInSecForIosWeb: 5,
        msg: "Certifique-se de que: Selecionou algum estudante, escreveu um título e observação e se subiu alguma imagem",
      );
      overlayEntry.remove();
      return 'erro';
    }
  }
}
