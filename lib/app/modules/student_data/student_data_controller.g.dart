// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_data_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$StudentDataController on _StudentDataControllerBase, Store {
  final _$activitiesListAtom =
      Atom(name: '_StudentDataControllerBase.activitiesList');

  @override
  List<DocumentSnapshot<Object?>> get activitiesList {
    _$activitiesListAtom.reportRead();
    return super.activitiesList;
  }

  @override
  set activitiesList(List<DocumentSnapshot<Object?>> value) {
    _$activitiesListAtom.reportWrite(value, super.activitiesList, () {
      super.activitiesList = value;
    });
  }

  final _$selectedDateAtom =
      Atom(name: '_StudentDataControllerBase.selectedDate');

  @override
  DateTime get selectedDate {
    _$selectedDateAtom.reportRead();
    return super.selectedDate;
  }

  @override
  set selectedDate(DateTime value) {
    _$selectedDateAtom.reportWrite(value, super.selectedDate, () {
      super.selectedDate = value;
    });
  }

  final _$reportNoteAtom = Atom(name: '_StudentDataControllerBase.reportNote');

  @override
  String get reportNote {
    _$reportNoteAtom.reportRead();
    return super.reportNote;
  }

  @override
  set reportNote(String value) {
    _$reportNoteAtom.reportWrite(value, super.reportNote, () {
      super.reportNote = value;
    });
  }

  final _$editReportsAtom =
      Atom(name: '_StudentDataControllerBase.editReports');

  @override
  bool get editReports {
    _$editReportsAtom.reportRead();
    return super.editReports;
  }

  @override
  set editReports(bool value) {
    _$editReportsAtom.reportWrite(value, super.editReports, () {
      super.editReports = value;
    });
  }

  final _$removeReportAsyncAction =
      AsyncAction('_StudentDataControllerBase.removeReport');

  @override
  Future<void> removeReport(
      String reportId, String studentId, BuildContext context) {
    return _$removeReportAsyncAction
        .run(() => super.removeReport(reportId, studentId, context));
  }

  final _$_StudentDataControllerBaseActionController =
      ActionController(name: '_StudentDataControllerBase');

  @override
  void mountList(QuerySnapshot<Object?>? activities) {
    final _$actionInfo = _$_StudentDataControllerBaseActionController
        .startAction(name: '_StudentDataControllerBase.mountList');
    try {
      return super.mountList(activities);
    } finally {
      _$_StudentDataControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
activitiesList: ${activitiesList},
selectedDate: ${selectedDate},
reportNote: ${reportNote},
editReports: ${editReports}
    ''';
  }
}
