import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show consolidateHttpClientResponseBytes;
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:teacher_side/app/modules/main/main_controller.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import "package:universal_html/html.dart" as html;
part 'messages_store.g.dart';

class MessagesStore = _MessagesStoreBase with _$MessagesStore;

abstract class _MessagesStoreBase with Store {
  final MainController mainController = Modular.get();

  @observable
  ObservableMap divisorsMap = {}.asObservable();
  @observable
  TextEditingController textEditingController = TextEditingController();
  @observable
  Uint8List? image;
  @observable
  List searchList = [];
  @observable
  String searchTxt = "";
  @observable
  String fileName = '';
  @observable
  Uint8List? fileWeb;
  @observable
  String fileExtension = '';

  @action
  uploadFile({bool camera = false}) async {
    print('pickImage: $kIsWeb - $camera');
    bool permission = kIsWeb ? false : await Permission.storage.request().isGranted;

    if (permission) {
      XFile? pickedFile;
      final picker = ImagePicker();
      if (camera) {
        pickedFile = await picker.pickImage(
          source: ImageSource.camera,
          preferredCameraDevice: CameraDevice.rear,
        );
      } else {
        pickedFile = await picker.pickImage(source: ImageSource.gallery);
      }
        
      if (pickedFile != null) {
        image = await pickedFile.readAsBytes();
        fileExtension = pickedFile.mimeType!;
        print('pickedFile.mimeTypepickedFile.mimeType ${pickedFile.mimeType}');
      }
    } else if(kIsWeb){
      if(camera){
        final picker = ImagePicker();
        XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          image = await pickedFile.readAsBytes();
          print('pickedFile.mimeTypepickedFile.mimeType ${pickedFile.mimeType}');
          fileExtension = pickedFile.mimeType!;
        }
      } else {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          allowMultiple: false,
        );

        if (result != null) {
          PlatformFile plataformFile = result.files.single;
          print('element: ${plataformFile.name} - ${plataformFile.extension}');
          fileExtension = plataformFile.extension!;
          
          switch (plataformFile.extension) {
            case "png":
              image = plataformFile.bytes!;              
              break;

            case "jpg":
              image = plataformFile.bytes!;              
              break;

            case "pdf":
              fileWeb = plataformFile.bytes!; 
              fileName = plataformFile.name;
              break;
              
            default:
              Fluttertoast.showToast(msg: "Extensão de arquivo ainda não tratada");              
              break;
          }          
        } 
      }
    }
  }

  @action
  Future sendFile(String chatId, context) async {
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
    DocumentSnapshot chatDoc = await FirebaseFirestore.instance
        .collection('classes')
        .doc(mainController.classId)
        .collection('chats')
        .doc(chatId)
        .get();

    DocumentReference messageRef = await FirebaseFirestore.instance
        .collection('classes')
        .doc(mainController.classId)
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add({
      'author_id': FirebaseAuth.instance.currentUser!.uid,
      'created_at': FieldValue.serverTimestamp(),
      // 'file': null,
      'file_extension': fileExtension,
      'file_data': null,
      'file_name': fileName,
      // 'file_type': "jpeg",
      'status': 'VISIBLE',
      'text': null,
      'chat_id': chatId,
      "id": "",
    });

    try {        
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child(
          'classes/${mainController.classId}/chats/$chatId/${messageRef.id}');

      UploadTask uploadTask = firebaseStorageRef.putData(image!);

      TaskSnapshot taskSnapshot = await uploadTask;

      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      await messageRef.update({'id': messageRef.id, "file_data": downloadUrl});

      await chatDoc.reference
          .update({"updated_at": FieldValue.serverTimestamp()});

      image = null;
      fileExtension = '';
      fileName = '';
      fileWeb = null;
      overlayEntry.remove();
      
    } catch (e) {
      print('catch');
      image = null;
      fileWeb = null;
      fileExtension = '';
      fileName = '';
      messageRef.delete();
      overlayEntry.remove();      
      print('error');
      print(e);
    }
  }

    @action
  downloadFiles(String url, String fileName, BuildContext context) async {
    print('downloadFiles: $kIsWeb');
    if(!kIsWeb){
      HttpClient httpClient = new HttpClient();

      // print('downloadFiles: $url - $fileName');
      Directory? appDir = await getExternalStorageDirectory();
      // print('appDir $appDir');

      
      String localPath = '${appDir!.path}/$fileName';

      try {
        var request = await httpClient.getUrl(Uri.parse(url));
        var response = await request.close();

        if (response.statusCode == 200) {
          Uint8List bytes = await consolidateHttpClientResponseBytes(response);
          File file = File(localPath);
          file.writeAsBytes(bytes);
        } else {
          localPath = 'Error code: ' + response.statusCode.toString();
          print(localPath);
        }
      } catch (ex) {
        localPath = 'Can not fetch url';
        print(localPath);
      }
    } else {
      // html.window.open(url, 'PlaceholderName');
    }
  }

  @action
  filterMessages(String value) async {
    print('filterMessages - $value');
    if (value.isNotEmpty) {
      QuerySnapshot chatsQuery = await FirebaseFirestore.instance
          .collection('classes')
          .doc(mainController.classId)
          .collection("chats")
          .where("teacher_id",
              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where("status", isEqualTo: "ACTIVE")
          .orderBy('updated_at', descending: true)
          .get();

      List newList = [];
      for (DocumentSnapshot chatDoc in chatsQuery.docs) {
        QuerySnapshot messagesQuery =
            await chatDoc.reference.collection('messages').get();

        for (DocumentSnapshot messageDoc in messagesQuery.docs) {
          String text = messageDoc['text'].toString().toLowerCase();
          print('for text: $text');
          if (text.contains(value.toLowerCase())) {
            newList.add(messageDoc);
          }
        }
      }
      print('fim searchList ${newList.length}');
      searchList = newList;
    } else {
      print("Value is empty? ${value.isEmpty}");
      searchList.clear();
    }
  }

  @action
  Future<void> sendTextMessage(String chatId) async {
    DocumentReference messageRef = await FirebaseFirestore.instance
        .collection('classes')
        .doc(mainController.classId)
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add({
      'author_id': FirebaseAuth.instance.currentUser!.uid,
      'created_at': FieldValue.serverTimestamp(),
      // 'file': null,
      // 'file_type': null,
      'status': 'VISIBLE',
      'text': textEditingController.text,
      'chat_id': chatId,
      "id": "",
      'file_extension': null,
      'file_data': null,
      'file_name': null,
    });

    textEditingController.clear();

    await messageRef.update({'id': messageRef.id});
  }

  @action
  void getDivisor(String id, Timestamp updatedAt) {
    List daysList = [
      '',
      'Segunda-feira',
      'Terça-feira',
      'Quarta-feira',
      'Quinta-feira',
      'Sexta-feira',
      'Sábado-feira',
      'Domingo-feira',
    ];
    List monthsList = [
      '',
      'janeiro',
      'feverreiro',
      'março',
      'abril',
      'maio',
      'junho',
      'julho',
      'agosto',
      'setembro',
      'outubro',
      'novembro',
      'dezembro',
    ];
    DateTime date = updatedAt.toDate();
    String weekDay = daysList[date.weekday] + ', ';
    String monthDay = date.day.toString().padLeft(2, '0') + ' de ';
    String month = monthsList[date.month] + ' de ';
    String year = date.year.toString();
    String dateFormatted = weekDay + monthDay + month + year;

    if (!divisorsMap.containsValue(dateFormatted)) {
      divisorsMap.putIfAbsent(id, () => dateFormatted);
    }
  }

  @action
  String getHour(Timestamp? timestamp) {
    if (timestamp != null) {
      DateTime date = timestamp.toDate();
      String hour = date.hour.toString().padLeft(2, '0');
      String minute = date.minute.toString().padLeft(2, '0');

      return hour + ':' + minute;
    } else {
      return 'Nova';
    }
  }

  @action
  Future<DocumentSnapshot> getStudent(DocumentSnapshot parentDoc) async{
    QuerySnapshot students = await parentDoc.reference.collection('students').get();
    DocumentSnapshot studentDoc = await FirebaseFirestore.instance.collection('students').doc(students.docs[0].id).get();
    return studentDoc;
  }
}
