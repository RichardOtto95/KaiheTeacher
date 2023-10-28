import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teacher_side/app/core/models/teacher_model.dart';
import 'package:teacher_side/app/core/root/root_controller.dart';
import 'package:teacher_side/app/modules/home/home_store.dart';
import 'package:flutter/foundation.dart';
part 'main_controller.g.dart';

@Injectable()
class MainController = _MainControllerBase with _$MainController;

abstract class _MainControllerBase with Store {
  final RootController rootController = Modular.get();

  @observable
  String? classId;
  @observable
  TeacherModel? teacherModel;
  @observable
  bool enableFields = false;
  @observable
  int pageIndex = 0;
  @observable
  int pageListIndex = 0;
  @observable
  int currentPage = 0;
  @observable
  bool chatPage = false;
  @observable
  PageController pageController = PageController();

  @action
  Future<void>sendNotification() async{
    if(!kIsWeb){
      FirebaseFunctions functions = FirebaseFunctions.instance;
      // functions.useFunctionsEmulator('localhost', 5001);
      HttpsCallable callable = functions.httpsCallable('sendNotification');
      User _user = FirebaseAuth.instance.currentUser!;
      String? tokenString = await FirebaseMessaging.instance.getToken();
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('teachers').doc(_user.uid).get();

      if(tokenString != null){
        await userDoc.reference.update({
          "token_id": FieldValue.arrayUnion([tokenString]),
        });

        await Future.delayed(Duration(seconds: 5));

        try {
          var response = await callable.call({
            "title": userDoc['username'] + " você já fez a chamada hoje?",
            "text": "Não se esqueça de realizar a chamada de seus alunos",
            "userId": _user.uid,        
            "userCollection": "teachers",
          });

          print('response: ${response.data}');
        } on FirebaseFunctionsException catch (e) {
          print('ERROR:');
          print(e);
        }
      }
    }
  }

  @action
  Future<QuerySnapshot<Object?>> getClasses() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    User? _user = _auth.currentUser;
    DocumentSnapshot teacherDoc = await FirebaseFirestore.instance
        .collection('teachers')
        .doc(_user!.uid)
        .get();

    QuerySnapshot _classesQuery = await teacherDoc.reference
        .collection('classes')
        .orderBy('created_at', descending: true)
        .get();

    return _classesQuery;
  }

  @action
  Future<void> signOut() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    rootController.selectedTrunk = 1;
    await _auth.signOut();
  }


  @action
  void pageChange(int _pageIndex) {
    print('pageChange: ${Modular.to.path}*');
    if(Modular.to.path == "/student-data-view"){
      Modular.to.pop();
    }
    if (pageIndex != _pageIndex) {
      final HomeStore homeStore = Modular.get();

      homeStore.selectedStudentsList.clear();
      homeStore.allAreSelected = false;
      enableFields = false;
      pageIndex = _pageIndex;
      // setStateMain!();
    }
  }

  // @action
  // Future<QuerySnapshot> getTeachers() async{
  //   DocumentSnapshot classDoc = await FirebaseFirestore.instance.collection("classes").doc(classId).get();
  //   QuerySnapshot classTeachers = await classDoc.reference.collection("teachers").get();
  //   List teachersId = [];

  //   for (var i = 0; i < classTeachers.docs.length; i++) {
  //     DocumentSnapshot teacherDoc = classTeachers.docs[i];
  //     teachersId.add(teacherDoc.id);      
  //   }

  //   QuerySnapshot teachers = await FirebaseFirestore.instance.collection('teachers').where("id", whereIn: teachersId).get();

  //   return teachers;  
  // }

  @action
  Future<void> cloudFunctionExample(Map teacherMap) async{
    // Descomente a linha abaixo para usar o emulador local
    // FirebaseFunctions.instance.useFunctionsEmulator("localhost", 5001);
    print('teacherMap: $teacherMap');
    Timestamp birthday = teacherMap['birthday'];
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable("registrateUser");
    try {
      HttpsCallableResult result = await callable.call({
        "email": teacherMap['email'],
        "phone": teacherMap['phone'],
        "seconds": birthday.seconds,
        "nanoseconds": birthday.nanoseconds,
        "milliseconds": birthday.millisecondsSinceEpoch,
        "type": "TEACHER",
        "username": teacherMap['username'],
      });
      print(result.data);
    } catch (e) {
      print("Error on function:");
      print(e);
    }
  }

  
  @action
  Future<void> getTeacherFunctionExample(String teacherId) async {
    print('teacherId: $teacherId');
    FirebaseFunctions functions = FirebaseFunctions.instanceFor(region: "us-central1");
    HttpsCallable callable =  functions.httpsCallable("getTeacher");
    try {
      HttpsCallableResult result = await callable.call({
        'teacherId': teacherId
      });
      // final results = await callable.call(<dynamic, String>{ 'teacherId': '88vYNWKtfpeau69MrqRynFaG85h2', }); 
    
      print('resp ${result.data}');
    } on FirebaseFunctionsException catch (e) {
    // } catch (ee) {
  
      print("Error on function:${e}");
      print("e: ${e.stackTrace}");
      print("e.code: ${e.code}");
      print(e.details);
      print(e.message);
      print(e.plugin);

    }
  }
}
