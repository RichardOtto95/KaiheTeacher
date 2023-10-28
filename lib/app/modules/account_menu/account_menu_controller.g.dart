// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_menu_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AccountMenuController on _AccountMenuControllerBase, Store {
  final _$teacherMapAtom = Atom(name: '_AccountMenuControllerBase.teacherMap');

  @override
  ObservableMap<String, dynamic> get teacherMap {
    _$teacherMapAtom.reportRead();
    return super.teacherMap;
  }

  @override
  set teacherMap(ObservableMap<String, dynamic> value) {
    _$teacherMapAtom.reportWrite(value, super.teacherMap, () {
      super.teacherMap = value;
    });
  }

  final _$formKeyAtom = Atom(name: '_AccountMenuControllerBase.formKey');

  @override
  GlobalKey<FormState> get formKey {
    _$formKeyAtom.reportRead();
    return super.formKey;
  }

  @override
  set formKey(GlobalKey<FormState> value) {
    _$formKeyAtom.reportWrite(value, super.formKey, () {
      super.formKey = value;
    });
  }

  final _$pickImageAsyncAction =
      AsyncAction('_AccountMenuControllerBase.pickImage');

  @override
  Future pickImage() {
    return _$pickImageAsyncAction.run(() => super.pickImage());
  }

  final _$_AccountMenuControllerBaseActionController =
      ActionController(name: '_AccountMenuControllerBase');

  @override
  dynamic saveEdit() {
    final _$actionInfo = _$_AccountMenuControllerBaseActionController
        .startAction(name: '_AccountMenuControllerBase.saveEdit');
    try {
      return super.saveEdit();
    } finally {
      _$_AccountMenuControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
teacherMap: ${teacherMap},
formKey: ${formKey}
    ''';
  }
}
