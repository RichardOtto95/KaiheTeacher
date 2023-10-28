import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
part 'account_menu_controller.g.dart';

@Injectable()
class AccountMenuController = _AccountMenuControllerBase
    with _$AccountMenuController;

abstract class _AccountMenuControllerBase with Store {'
  var db = FirebaseAuth.instance;'

  @observable
  ObservableMap<String, dynamic> teacherMap =
      Map<String, dynamic>().asObservable();

  @observable
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @action
  pickImage() async {
    // print('pickImage');
    bool permission =
        kIsWeb ? true : await Permission.storage.request().isGranted;
    if (permission) {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        FirebaseAuth _auth = FirebaseAuth.instance;
        User _user = _auth.currentUser!;
        Uint8List _uint8List = await pickedFile.readAsBytes();

        Reference firebaseStorageRef = FirebaseStorage.instance
            .ref()
            .child('teachers/${_user.uid}/avatar/${pickedFile.name}');

        UploadTask uploadTask = firebaseStorageRef.putData(_uint8List);

        TaskSnapshot taskSnapshot = await uploadTask;

        taskSnapshot.ref.getDownloadURL().then((downloadURL) async {
          teacherMap['avatar'] = downloadURL;
        });
      }
    }
  }

  @action
  saveEdit() {
    bool isNotEmptyPhone = true;
    bool isNotEmptyUsername = true;

    if (teacherMap['username'] != null) {
      isNotEmptyUsername = teacherMap['username'].toString().isNotEmpty;
    }

    if (teacherMap['phone'] != null) {
      isNotEmptyPhone = teacherMap['phone'].toString().isNotEmpty &&
          teacherMap['phone'].toString().length == 11;
    }

    if (isNotEmptyUsername && isNotEmptyPhone) {
      FirebaseAuth _auth = FirebaseAuth.instance;
      User _user = _auth.currentUser!;

      FirebaseFirestore.instance
          .collection('teachers')
          .doc(_user.uid)
          .update(teacherMap);
    }

    teacherMap.clear();
  }
}
