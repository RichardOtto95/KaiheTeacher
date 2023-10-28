// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homework_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeworkStore on _HomeworkStoreBase, Store {
  final _$titleAtom = Atom(name: '_HomeworkStoreBase.title');

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

  final _$noteAtom = Atom(name: '_HomeworkStoreBase.note');

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

  final _$homeworkSelectedAtom =
      Atom(name: '_HomeworkStoreBase.homeworkSelected');

  @override
  String? get homeworkSelected {
    _$homeworkSelectedAtom.reportRead();
    return super.homeworkSelected;
  }

  @override
  set homeworkSelected(String? value) {
    _$homeworkSelectedAtom.reportWrite(value, super.homeworkSelected, () {
      super.homeworkSelected = value;
    });
  }

  final _$homeworkPageAtom = Atom(name: '_HomeworkStoreBase.homeworkPage');

  @override
  int get homeworkPage {
    _$homeworkPageAtom.reportRead();
    return super.homeworkPage;
  }

  @override
  set homeworkPage(int value) {
    _$homeworkPageAtom.reportWrite(value, super.homeworkPage, () {
      super.homeworkPage = value;
    });
  }

  final _$imagesListAtom = Atom(name: '_HomeworkStoreBase.imagesList');

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

  final _$imagesNameListAtom = Atom(name: '_HomeworkStoreBase.imagesNameList');

  @override
  ObservableList<String> get imagesNameList {
    _$imagesNameListAtom.reportRead();
    return super.imagesNameList;
  }

  @override
  set imagesNameList(ObservableList<String> value) {
    _$imagesNameListAtom.reportWrite(value, super.imagesNameList, () {
      super.imagesNameList = value;
    });
  }

  final _$getStudentsAsyncAction =
      AsyncAction('_HomeworkStoreBase.getStudents');

  @override
  Future<QuerySnapshot<Object?>> getStudents() {
    return _$getStudentsAsyncAction.run(() => super.getStudents());
  }

  final _$pickImageAsyncAction = AsyncAction('_HomeworkStoreBase.pickImage');

  @override
  Future pickImage() {
    return _$pickImageAsyncAction.run(() => super.pickImage());
  }

  final _$_HomeworkStoreBaseActionController =
      ActionController(name: '_HomeworkStoreBase');

  @override
  void selectStudent(String studentId) {
    final _$actionInfo = _$_HomeworkStoreBaseActionController.startAction(
        name: '_HomeworkStoreBase.selectStudent');
    try {
      return super.selectStudent(studentId);
    } finally {
      _$_HomeworkStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
title: ${title},
note: ${note},
homeworkSelected: ${homeworkSelected},
homeworkPage: ${homeworkPage},
imagesList: ${imagesList},
imagesNameList: ${imagesNameList}
    ''';
  }
}
