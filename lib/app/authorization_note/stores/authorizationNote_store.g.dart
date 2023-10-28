// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authorizationNote_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthorizationNoteStore on _AuthorizationNoteStoreBase, Store {
  final _$notesAuthorizationAtom =
      Atom(name: '_AuthorizationNoteStoreBase.notesAuthorization');

  @override
  ObservableFuture<List<AuthorizationNoteModel>>? get notesAuthorization {
    _$notesAuthorizationAtom.reportRead();
    return super.notesAuthorization;
  }

  @override
  set notesAuthorization(
      ObservableFuture<List<AuthorizationNoteModel>>? value) {
    _$notesAuthorizationAtom.reportWrite(value, super.notesAuthorization, () {
      super.notesAuthorization = value;
    });
  }

  final _$StudentsAuthorizeAtom =
      Atom(name: '_AuthorizationNoteStoreBase.StudentsAuthorize');

  @override
  ObservableFuture<List<StudentAuthorizeaModel>>? get StudentsAuthorize {
    _$StudentsAuthorizeAtom.reportRead();
    return super.StudentsAuthorize;
  }

  @override
  set StudentsAuthorize(ObservableFuture<List<StudentAuthorizeaModel>>? value) {
    _$StudentsAuthorizeAtom.reportWrite(value, super.StudentsAuthorize, () {
      super.StudentsAuthorize = value;
    });
  }

  final _$authorizaionNoteForPageAtom =
      Atom(name: '_AuthorizationNoteStoreBase.authorizaionNoteForPage');

  @override
  AuthorizationNoteModel? get authorizaionNoteForPage {
    _$authorizaionNoteForPageAtom.reportRead();
    return super.authorizaionNoteForPage;
  }

  @override
  set authorizaionNoteForPage(AuthorizationNoteModel? value) {
    _$authorizaionNoteForPageAtom
        .reportWrite(value, super.authorizaionNoteForPage, () {
      super.authorizaionNoteForPage = value;
    });
  }

  final _$noteIdAtom = Atom(name: '_AuthorizationNoteStoreBase.noteId');

  @override
  String get noteId {
    _$noteIdAtom.reportRead();
    return super.noteId;
  }

  @override
  set noteId(String value) {
    _$noteIdAtom.reportWrite(value, super.noteId, () {
      super.noteId = value;
    });
  }

  final _$_AuthorizationNoteStoreBaseActionController =
      ActionController(name: '_AuthorizationNoteStoreBase');

  @override
  dynamic changeAuthorizaionNote(AuthorizationNoteModel noteAdd) {
    final _$actionInfo =
        _$_AuthorizationNoteStoreBaseActionController.startAction(
            name: '_AuthorizationNoteStoreBase.changeAuthorizaionNote');
    try {
      return super.changeAuthorizaionNote(noteAdd);
    } finally {
      _$_AuthorizationNoteStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getNotes(String classId) {
    final _$actionInfo = _$_AuthorizationNoteStoreBaseActionController
        .startAction(name: '_AuthorizationNoteStoreBase.getNotes');
    try {
      return super.getNotes(classId);
    } finally {
      _$_AuthorizationNoteStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeNoteId(String noteIdadd) {
    final _$actionInfo = _$_AuthorizationNoteStoreBaseActionController
        .startAction(name: '_AuthorizationNoteStoreBase.changeNoteId');
    try {
      return super.changeNoteId(noteIdadd);
    } finally {
      _$_AuthorizationNoteStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getStudentsAuthorie(String classId, String noteId) {
    final _$actionInfo = _$_AuthorizationNoteStoreBaseActionController
        .startAction(name: '_AuthorizationNoteStoreBase.getStudentsAuthorie');
    try {
      return super.getStudentsAuthorie(classId, noteId);
    } finally {
      _$_AuthorizationNoteStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
notesAuthorization: ${notesAuthorization},
StudentsAuthorize: ${StudentsAuthorize},
authorizaionNoteForPage: ${authorizaionNoteForPage},
noteId: ${noteId}
    ''';
  }
}
