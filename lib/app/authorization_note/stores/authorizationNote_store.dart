import 'package:mobx/mobx.dart';
import 'package:teacher_side/app/authorization_note/models/AuthorizationNote_model.dart';
import 'package:teacher_side/app/authorization_note/repositories/authorizationNote_repository.dart';
import 'package:teacher_side/app/authorization_note/models/student_authorize_model.dart';

part 'authorizationNote_store.g.dart';

class AuthorizationNoteStore = _AuthorizationNoteStoreBase with _$AuthorizationNoteStore;
abstract class _AuthorizationNoteStoreBase with Store {
  var authorizationNoteRepository = AuthoriazationNoteRepository();

  @observable
  ObservableFuture<List<AuthorizationNoteModel>>? notesAuthorization;

   @observable
  ObservableFuture<List<StudentAuthorizeaModel>>? StudentsAuthorize;
 
  @observable
  AuthorizationNoteModel? authorizaionNoteForPage;

  
  @action 
  changeAuthorizaionNote(AuthorizationNoteModel noteAdd){
    authorizaionNoteForPage = noteAdd;
  }
  @action
  void getNotes(String classId) {
    try{
    notesAuthorization = ObservableFuture(authorizationNoteRepository.getAuthorizationNotes(classId));
    }catch(erro){
      throw Exception();

    }
  } 
  
  @observable
  String noteId = '';

  @action 
  changeNoteId(String noteIdadd){
    noteId = noteIdadd;
  }

  @action
  void getStudentsAuthorie(String classId, String noteId) {
    try{
    StudentsAuthorize = ObservableFuture(authorizationNoteRepository.getStudentsAuthorize(classId,noteId));
    }catch(erro){
      throw Exception();
    }

  } 
}