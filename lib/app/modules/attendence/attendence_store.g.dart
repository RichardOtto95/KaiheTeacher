// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendence_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AttendenceStore on _AttendenceStoreBase, Store {
  final _$sendAttendenceAsyncAction =
      AsyncAction('_AttendenceStoreBase.sendAttendence');

  @override
  Future<bool> sendAttendence(dynamic context) {
    return _$sendAttendenceAsyncAction.run(() => super.sendAttendence(context));
  }

  final _$studentAttendenceAlteredAsyncAction =
      AsyncAction('_AttendenceStoreBase.studentAttendenceAltered');

  @override
  Future<void> studentAttendenceAltered(String studentId) {
    return _$studentAttendenceAlteredAsyncAction
        .run(() => super.studentAttendenceAltered(studentId));
  }

  final _$_AttendenceStoreBaseActionController =
      ActionController(name: '_AttendenceStoreBase');

  @override
  Color getColor(String? attendence) {
    final _$actionInfo = _$_AttendenceStoreBaseActionController.startAction(
        name: '_AttendenceStoreBase.getColor');
    try {
      return super.getColor(attendence);
    } finally {
      _$_AttendenceStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
