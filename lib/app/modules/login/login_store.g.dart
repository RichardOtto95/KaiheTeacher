// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginStore on _LoginStoreBase, Store {
  final _$emailAtom = Atom(name: '_LoginStoreBase.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$passwordAtom = Atom(name: '_LoginStoreBase.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$resultNewPasswordStringAtom =
      Atom(name: '_LoginStoreBase.resultNewPasswordString');

  @override
  String get resultNewPasswordString {
    _$resultNewPasswordStringAtom.reportRead();
    return super.resultNewPasswordString;
  }

  @override
  set resultNewPasswordString(String value) {
    _$resultNewPasswordStringAtom
        .reportWrite(value, super.resultNewPasswordString, () {
      super.resultNewPasswordString = value;
    });
  }

  final _$signInAsyncAction = AsyncAction('_LoginStoreBase.signIn');

  @override
  Future<String?> signIn() {
    return _$signInAsyncAction.run(() => super.signIn());
  }

  final _$sendEmailNewPassWordAsyncAction =
      AsyncAction('_LoginStoreBase.sendEmailNewPassWord');

  @override
  Future sendEmailNewPassWord(BuildContext context) {
    return _$sendEmailNewPassWordAsyncAction
        .run(() => super.sendEmailNewPassWord(context));
  }

  @override
  String toString() {
    return '''
email: ${email},
password: ${password},
resultNewPasswordString: ${resultNewPasswordString}
    ''';
  }
}
