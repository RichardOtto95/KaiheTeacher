// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NoteStore on _NoteStoreBase, Store {
  final _$authorizationNoteAtom =
      Atom(name: '_NoteStoreBase.authorizationNote');

  @override
  bool get authorizationNote {
    _$authorizationNoteAtom.reportRead();
    return super.authorizationNote;
  }

  @override
  set authorizationNote(bool value) {
    _$authorizationNoteAtom.reportWrite(value, super.authorizationNote, () {
      super.authorizationNote = value;
    });
  }

  final _$notePageAtom = Atom(name: '_NoteStoreBase.notePage');

  @override
  int? get notePage {
    _$notePageAtom.reportRead();
    return super.notePage;
  }

  @override
  set notePage(int? value) {
    _$notePageAtom.reportWrite(value, super.notePage, () {
      super.notePage = value;
    });
  }

  final _$titleAtom = Atom(name: '_NoteStoreBase.title');

  @override
  String get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  final _$typeAtom = Atom(name: '_NoteStoreBase.type');

  @override
  String? get type {
    _$typeAtom.reportRead();
    return super.type;
  }

  @override
  set type(String? value) {
    _$typeAtom.reportWrite(value, super.type, () {
      super.type = value;
    });
  }

  final _$noteAtom = Atom(name: '_NoteStoreBase.note');

  @override
  String? get note {
    _$noteAtom.reportRead();
    return super.note;
  }

  @override
  set note(String? value) {
    _$noteAtom.reportWrite(value, super.note, () {
      super.note = value;
    });
  }

  final _$requestAuthorizationAtom =
      Atom(name: '_NoteStoreBase.requestAuthorization');

  @override
  bool get requestAuthorization {
    _$requestAuthorizationAtom.reportRead();
    return super.requestAuthorization;
  }

  @override
  set requestAuthorization(bool value) {
    _$requestAuthorizationAtom.reportWrite(value, super.requestAuthorization,
        () {
      super.requestAuthorization = value;
    });
  }

  final _$requestPresenceAtom = Atom(name: '_NoteStoreBase.requestPresence');

  @override
  bool get requestPresence {
    _$requestPresenceAtom.reportRead();
    return super.requestPresence;
  }

  @override
  set requestPresence(bool value) {
    _$requestPresenceAtom.reportWrite(value, super.requestPresence, () {
      super.requestPresence = value;
    });
  }

  final _$imagesListAtom = Atom(name: '_NoteStoreBase.imagesList');

  @override
  ObservableList<Uint8List> get imagesList {
    _$imagesListAtom.reportRead();
    return super.imagesList;
  }

  @override
  set imagesList(ObservableList<Uint8List> value) {
    _$imagesListAtom.reportWrite(value, super.imagesList, () {
      super.imagesList = value;
    });
  }

  final _$fileNameListAtom = Atom(name: '_NoteStoreBase.fileNameList');

  @override
  List<String> get fileNameList {
    _$fileNameListAtom.reportRead();
    return super.fileNameList;
  }

  @override
  set fileNameList(List<String> value) {
    _$fileNameListAtom.reportWrite(value, super.fileNameList, () {
      super.fileNameList = value;
    });
  }

  final _$pickImageAsyncAction = AsyncAction('_NoteStoreBase.pickImage');

  @override
  Future pickImage() {
    return _$pickImageAsyncAction.run(() => super.pickImage());
  }

  final _$_NoteStoreBaseActionController =
      ActionController(name: '_NoteStoreBase');

  @override
  dynamic changeAuthorizationNote() {
    final _$actionInfo = _$_NoteStoreBaseActionController.startAction(
        name: '_NoteStoreBase.changeAuthorizationNote');
    try {
      return super.changeAuthorizationNote();
    } finally {
      _$_NoteStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectStudent(String studentId) {
    final _$actionInfo = _$_NoteStoreBaseActionController.startAction(
        name: '_NoteStoreBase.selectStudent');
    try {
      return super.selectStudent(studentId);
    } finally {
      _$_NoteStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void cleanVars() {
    final _$actionInfo = _$_NoteStoreBaseActionController.startAction(
        name: '_NoteStoreBase.cleanVars');
    try {
      return super.cleanVars();
    } finally {
      _$_NoteStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
authorizationNote: ${authorizationNote},
notePage: ${notePage},
title: ${title},
type: ${type},
note: ${note},
requestAuthorization: ${requestAuthorization},
requestPresence: ${requestPresence},
imagesList: ${imagesList},
fileNameList: ${fileNameList}
    ''';
  }
}
