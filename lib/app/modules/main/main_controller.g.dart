// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MainController on _MainControllerBase, Store {
  final _$classIdAtom = Atom(name: '_MainControllerBase.classId');

  @override
  String? get classId {
    _$classIdAtom.reportRead();
    return super.classId;
  }

  @override
  set classId(String? value) {
    _$classIdAtom.reportWrite(value, super.classId, () {
      super.classId = value;
    });
  }

  final _$teacherModelAtom = Atom(name: '_MainControllerBase.teacherModel');

  @override
  TeacherModel? get teacherModel {
    _$teacherModelAtom.reportRead();
    return super.teacherModel;
  }

  @override
  set teacherModel(TeacherModel? value) {
    _$teacherModelAtom.reportWrite(value, super.teacherModel, () {
      super.teacherModel = value;
    });
  }

  final _$enableFieldsAtom = Atom(name: '_MainControllerBase.enableFields');

  @override
  bool get enableFields {
    _$enableFieldsAtom.reportRead();
    return super.enableFields;
  }

  @override
  set enableFields(bool value) {
    _$enableFieldsAtom.reportWrite(value, super.enableFields, () {
      super.enableFields = value;
    });
  }

  final _$pageIndexAtom = Atom(name: '_MainControllerBase.pageIndex');

  @override
  int get pageIndex {
    _$pageIndexAtom.reportRead();
    return super.pageIndex;
  }

  @override
  set pageIndex(int value) {
    _$pageIndexAtom.reportWrite(value, super.pageIndex, () {
      super.pageIndex = value;
    });
  }

  final _$pageListIndexAtom = Atom(name: '_MainControllerBase.pageListIndex');

  @override
  int get pageListIndex {
    _$pageListIndexAtom.reportRead();
    return super.pageListIndex;
  }

  @override
  set pageListIndex(int value) {
    _$pageListIndexAtom.reportWrite(value, super.pageListIndex, () {
      super.pageListIndex = value;
    });
  }

  final _$currentPageAtom = Atom(name: '_MainControllerBase.currentPage');

  @override
  int get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(int value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  final _$chatPageAtom = Atom(name: '_MainControllerBase.chatPage');

  @override
  bool get chatPage {
    _$chatPageAtom.reportRead();
    return super.chatPage;
  }

  @override
  set chatPage(bool value) {
    _$chatPageAtom.reportWrite(value, super.chatPage, () {
      super.chatPage = value;
    });
  }

  final _$pageControllerAtom = Atom(name: '_MainControllerBase.pageController');

  @override
  PageController get pageController {
    _$pageControllerAtom.reportRead();
    return super.pageController;
  }

  @override
  set pageController(PageController value) {
    _$pageControllerAtom.reportWrite(value, super.pageController, () {
      super.pageController = value;
    });
  }

  final _$sendNotificationAsyncAction =
      AsyncAction('_MainControllerBase.sendNotification');

  @override
  Future<void> sendNotification() {
    return _$sendNotificationAsyncAction.run(() => super.sendNotification());
  }

  final _$getClassesAsyncAction = AsyncAction('_MainControllerBase.getClasses');

  @override
  Future<QuerySnapshot<Object?>> getClasses() {
    return _$getClassesAsyncAction.run(() => super.getClasses());
  }

  final _$signOutAsyncAction = AsyncAction('_MainControllerBase.signOut');

  @override
  Future<void> signOut() {
    return _$signOutAsyncAction.run(() => super.signOut());
  }

  final _$cloudFunctionExampleAsyncAction =
      AsyncAction('_MainControllerBase.cloudFunctionExample');

  @override
  Future<void> cloudFunctionExample(Map<dynamic, dynamic> teacherMap) {
    return _$cloudFunctionExampleAsyncAction
        .run(() => super.cloudFunctionExample(teacherMap));
  }

  final _$getTeacherFunctionExampleAsyncAction =
      AsyncAction('_MainControllerBase.getTeacherFunctionExample');

  @override
  Future<void> getTeacherFunctionExample(String teacherId) {
    return _$getTeacherFunctionExampleAsyncAction
        .run(() => super.getTeacherFunctionExample(teacherId));
  }

  final _$_MainControllerBaseActionController =
      ActionController(name: '_MainControllerBase');

  @override
  void pageChange(int _pageIndex) {
    final _$actionInfo = _$_MainControllerBaseActionController.startAction(
        name: '_MainControllerBase.pageChange');
    try {
      return super.pageChange(_pageIndex);
    } finally {
      _$_MainControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
classId: ${classId},
teacherModel: ${teacherModel},
enableFields: ${enableFields},
pageIndex: ${pageIndex},
pageListIndex: ${pageListIndex},
currentPage: ${currentPage},
chatPage: ${chatPage},
pageController: ${pageController}
    ''';
  }
}
