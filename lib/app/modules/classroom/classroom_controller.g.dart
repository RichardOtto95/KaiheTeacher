// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classroom_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ClassroomController on _ClassroomControllerBase, Store {
  final _$addStudentOverlayAtom =
      Atom(name: '_ClassroomControllerBase.addStudentOverlay');

  @override
  OverlayEntry? get addStudentOverlay {
    _$addStudentOverlayAtom.reportRead();
    return super.addStudentOverlay;
  }

  @override
  set addStudentOverlay(OverlayEntry? value) {
    _$addStudentOverlayAtom.reportWrite(value, super.addStudentOverlay, () {
      super.addStudentOverlay = value;
    });
  }

  final _$teacherNameAtom = Atom(name: '_ClassroomControllerBase.teacherName');

  @override
  String get teacherName {
    _$teacherNameAtom.reportRead();
    return super.teacherName;
  }

  @override
  set teacherName(String value) {
    _$teacherNameAtom.reportWrite(value, super.teacherName, () {
      super.teacherName = value;
    });
  }

  final _$teacherRegisterAtom =
      Atom(name: '_ClassroomControllerBase.teacherRegister');

  @override
  String get teacherRegister {
    _$teacherRegisterAtom.reportRead();
    return super.teacherRegister;
  }

  @override
  set teacherRegister(String value) {
    _$teacherRegisterAtom.reportWrite(value, super.teacherRegister, () {
      super.teacherRegister = value;
    });
  }

  final _$removingStudentsAtom =
      Atom(name: '_ClassroomControllerBase.removingStudents');

  @override
  bool get removingStudents {
    _$removingStudentsAtom.reportRead();
    return super.removingStudents;
  }

  @override
  set removingStudents(bool value) {
    _$removingStudentsAtom.reportWrite(value, super.removingStudents, () {
      super.removingStudents = value;
    });
  }

  final _$removeStudentsListAtom =
      Atom(name: '_ClassroomControllerBase.removeStudentsList');

  @override
  ObservableList<dynamic> get removeStudentsList {
    _$removeStudentsListAtom.reportRead();
    return super.removeStudentsList;
  }

  @override
  set removeStudentsList(ObservableList<dynamic> value) {
    _$removeStudentsListAtom.reportWrite(value, super.removeStudentsList, () {
      super.removeStudentsList = value;
    });
  }

  final _$addStudentAsyncAction =
      AsyncAction('_ClassroomControllerBase.addStudent');

  @override
  Future<bool> addStudent(
      dynamic context, String name, String matricula, Function? setState) {
    return _$addStudentAsyncAction
        .run(() => super.addStudent(context, name, matricula, setState));
  }

  final _$addTeacherAsyncAction =
      AsyncAction('_ClassroomControllerBase.addTeacher');

  @override
  Future<void> addTeacher(dynamic context) {
    return _$addTeacherAsyncAction.run(() => super.addTeacher(context));
  }

  final _$removeStudentsAsyncAction =
      AsyncAction('_ClassroomControllerBase.removeStudents');

  @override
  Future<dynamic> removeStudents(dynamic context) {
    return _$removeStudentsAsyncAction.run(() => super.removeStudents(context));
  }

  final _$setClassroomImageAsyncAction =
      AsyncAction('_ClassroomControllerBase.setClassroomImage');

  @override
  Future setClassroomImage(dynamic context) {
    return _$setClassroomImageAsyncAction
        .run(() => super.setClassroomImage(context));
  }

  @override
  String toString() {
    return '''
addStudentOverlay: ${addStudentOverlay},
teacherName: ${teacherName},
teacherRegister: ${teacherRegister},
removingStudents: ${removingStudents},
removeStudentsList: ${removeStudentsList}
    ''';
  }
}
