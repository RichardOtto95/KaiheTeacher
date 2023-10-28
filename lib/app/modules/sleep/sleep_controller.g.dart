// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sleep_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SleepController on _SleepControllerBase, Store {
  final _$sleepPageAtom = Atom(name: '_SleepControllerBase.sleepPage');

  @override
  int? get sleepPage {
    _$sleepPageAtom.reportRead();
    return super.sleepPage;
  }

  @override
  set sleepPage(int? value) {
    _$sleepPageAtom.reportWrite(value, super.sleepPage, () {
      super.sleepPage = value;
    });
  }

  final _$sleptAtom = Atom(name: '_SleepControllerBase.slept');

  @override
  bool get slept {
    _$sleptAtom.reportRead();
    return super.slept;
  }

  @override
  set slept(bool value) {
    _$sleptAtom.reportWrite(value, super.slept, () {
      super.slept = value;
    });
  }

  final _$sleepWellAtom = Atom(name: '_SleepControllerBase.sleepWell');

  @override
  bool get sleepWell {
    _$sleepWellAtom.reportRead();
    return super.sleepWell;
  }

  @override
  set sleepWell(bool value) {
    _$sleepWellAtom.reportWrite(value, super.sleepWell, () {
      super.sleepWell = value;
    });
  }

  final _$noteAtom = Atom(name: '_SleepControllerBase.note');

  @override
  String get note {
    _$noteAtom.reportRead();
    return super.note;
  }

  @override
  set note(String value) {
    _$noteAtom.reportWrite(value, super.note, () {
      super.note = value;
    });
  }

  final _$startAtom = Atom(name: '_SleepControllerBase.start');

  @override
  DateTime get start {
    _$startAtom.reportRead();
    return super.start;
  }

  @override
  set start(DateTime value) {
    _$startAtom.reportWrite(value, super.start, () {
      super.start = value;
    });
  }

  final _$durationAtom = Atom(name: '_SleepControllerBase.duration');

  @override
  DateTime get duration {
    _$durationAtom.reportRead();
    return super.duration;
  }

  @override
  set duration(DateTime value) {
    _$durationAtom.reportWrite(value, super.duration, () {
      super.duration = value;
    });
  }

  final _$_SleepControllerBaseActionController =
      ActionController(name: '_SleepControllerBase');

  @override
  void selectStudent(String studentId) {
    final _$actionInfo = _$_SleepControllerBaseActionController.startAction(
        name: '_SleepControllerBase.selectStudent');
    try {
      return super.selectStudent(studentId);
    } finally {
      _$_SleepControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void cleanVars() {
    final _$actionInfo = _$_SleepControllerBaseActionController.startAction(
        name: '_SleepControllerBase.cleanVars');
    try {
      return super.cleanVars();
    } finally {
      _$_SleepControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
sleepPage: ${sleepPage},
slept: ${slept},
sleepWell: ${sleepWell},
note: ${note},
start: ${start},
duration: ${duration}
    ''';
  }
}
