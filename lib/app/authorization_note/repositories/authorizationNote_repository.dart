import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/date_time_patterns.dart';
import 'package:teacher_side/app/authorization_note/models/AuthorizationNote_model.dart';
import 'package:teacher_side/app/authorization_note/models/student_authorize_model.dart';

class AuthoriazationNoteRepository{
  

  Future<List<AuthorizationNoteModel>> getAuthorizationNotes(String classId) async{
    List<AuthorizationNoteModel> notesReturn = [];
    var AuthorizationFromFb = await FirebaseFirestore.instance.collection('classes').doc(classId).collection('activities').where('activity',isEqualTo: 'NOTE').where('need_auth', isEqualTo: true).get();
    for(var authorization in AuthorizationFromFb.docs){
      DateTime dt = (authorization['created_at'] as Timestamp).toDate();

      var authorizationAdd = AuthorizationNoteModel(authorization.id,authorization['title'], authorization['note'], dt);
      notesReturn.add(authorizationAdd);
    }
    return notesReturn;
  }


  Future<List<StudentAuthorizeaModel>> getStudentsAuthorize(String classId, String noteId) async{
   List<StudentAuthorizeaModel> studentsReturn = [];
   var studentsFromClass = await FirebaseFirestore.instance.collection('classes').doc(classId).collection('students').get().catchError((erro){
     throw Exception();
   });
   for(var student in studentsFromClass.docs){
     var noteStudent = await FirebaseFirestore.instance.collection('students').doc(student['id']).collection('notes').doc(noteId).get().catchError((erro){
     throw Exception();
   });
     if(noteStudent.exists){
       if(noteStudent['isAuthorized'] == true){
         var studentUsername = await FirebaseFirestore.instance.collection('students').doc(student['id']).get().catchError((erro){
     throw Exception();
   });
        print('chama ' + student['id']);
        var studentAdd = StudentAuthorizeaModel(studentUsername['username']);
        print('roia : ' + studentUsername['username'].toString());
        studentsReturn.add(studentAdd);
       }
     }
     }
   
   return studentsReturn;

  }
}