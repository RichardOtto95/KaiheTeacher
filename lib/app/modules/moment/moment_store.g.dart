// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moment_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MomentStore on _MomentStoreBase, Store {
  final _$momentPageAtom = Atom(name: '_MomentStoreBase.momentPage');

  @override
  int? get momentPage {
    _$momentPageAtom.reportRead();
    return super.momentPage;
  }

  @override
  set momentPage(int? value) {
    _$momentPageAtom.reportWrite(value, super.momentPage, () {
      super.momentPage = value;
    });
  }

  final _$titleAtom = Atom(name: '_MomentStoreBase.title');

  @override
  String? get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String? value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  final _$descriptionAtom = Atom(name: '_MomentStoreBase.description');

  @override
  String? get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String? value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  final _$imagesListAtom = Atom(name: '_MomentStoreBase.imagesList');

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

  final _$medalsAtom = Atom(name: '_MomentStoreBase.medals');

  @override
  ObservableList<dynamic> get medals {
    _$medalsAtom.reportRead();
    return super.medals;
  }

  @override
  set medals(ObservableList<dynamic> value) {
    _$medalsAtom.reportWrite(value, super.medals, () {
      super.medals = value;
    });
  }

  final _$fileNameListAtom = Atom(name: '_MomentStoreBase.fileNameList');

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

  final _$pickImageAsyncAction = AsyncAction('_MomentStoreBase.pickImage');

  @override
  Future pickImage() {
    return _$pickImageAsyncAction.run(() => super.pickImage());
  }

  final _$_MomentStoreBaseActionController =
      ActionController(name: '_MomentStoreBase');

  @override
  void selectStudent(String studentId) {
    final _$actionInfo = _$_MomentStoreBaseActionController.startAction(
        name: '_MomentStoreBase.selectStudent');
    try {
      return super.selectStudent(studentId);
    } finally {
      _$_MomentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void cleanVars() {
    final _$actionInfo = _$_MomentStoreBaseActionController.startAction(
        name: '_MomentStoreBase.cleanVars');
    try {
      return super.cleanVars();
    } finally {
      _$_MomentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
momentPage: ${momentPage},
title: ${title},
description: ${description},
imagesList: ${imagesList},
medals: ${medals},
fileNameList: ${fileNameList}
    ''';
  }
}
