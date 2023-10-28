// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bathroom_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BathroomController on _BathroomControllerBase, Store {
  final _$bathroomPageAtom = Atom(name: '_BathroomControllerBase.bathroomPage');

  @override
  int get bathroomPage {
    _$bathroomPageAtom.reportRead();
    return super.bathroomPage;
  }

  @override
  set bathroomPage(int value) {
    _$bathroomPageAtom.reportWrite(value, super.bathroomPage, () {
      super.bathroomPage = value;
    });
  }

  final _$whatAtom = Atom(name: '_BathroomControllerBase.what');

  @override
  String get what {
    _$whatAtom.reportRead();
    return super.what;
  }

  @override
  set what(String value) {
    _$whatAtom.reportWrite(value, super.what, () {
      super.what = value;
    });
  }

  final _$howAtom = Atom(name: '_BathroomControllerBase.how');

  @override
  String get how {
    _$howAtom.reportRead();
    return super.how;
  }

  @override
  set how(String value) {
    _$howAtom.reportWrite(value, super.how, () {
      super.how = value;
    });
  }

  final _$whereAtom = Atom(name: '_BathroomControllerBase.where');

  @override
  String get where {
    _$whereAtom.reportRead();
    return super.where;
  }

  @override
  set where(String value) {
    _$whereAtom.reportWrite(value, super.where, () {
      super.where = value;
    });
  }

  final _$noteAtom = Atom(name: '_BathroomControllerBase.note');

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

  final _$optionAtom = Atom(name: '_BathroomControllerBase.option');

  @override
  String get option {
    _$optionAtom.reportRead();
    return super.option;
  }

  @override
  set option(String value) {
    _$optionAtom.reportWrite(value, super.option, () {
      super.option = value;
    });
  }

  final _$sanitizedAtom = Atom(name: '_BathroomControllerBase.sanitized');

  @override
  bool get sanitized {
    _$sanitizedAtom.reportRead();
    return super.sanitized;
  }

  @override
  set sanitized(bool value) {
    _$sanitizedAtom.reportWrite(value, super.sanitized, () {
      super.sanitized = value;
    });
  }

  final _$_BathroomControllerBaseActionController =
      ActionController(name: '_BathroomControllerBase');

  @override
  void cleanVars() {
    final _$actionInfo = _$_BathroomControllerBaseActionController.startAction(
        name: '_BathroomControllerBase.cleanVars');
    try {
      return super.cleanVars();
    } finally {
      _$_BathroomControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
bathroomPage: ${bathroomPage},
what: ${what},
how: ${how},
where: ${where},
note: ${note},
option: ${option},
sanitized: ${sanitized}
    ''';
  }
}
