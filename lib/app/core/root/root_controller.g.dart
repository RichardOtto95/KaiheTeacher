// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'root_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RootController on _RootControllerBase, Store {
  final _$selectedTrunkAtom = Atom(name: '_RootControllerBase.selectedTrunk');

  @override
  int get selectedTrunk {
    _$selectedTrunkAtom.reportRead();
    return super.selectedTrunk;
  }

  @override
  set selectedTrunk(int value) {
    _$selectedTrunkAtom.reportWrite(value, super.selectedTrunk, () {
      super.selectedTrunk = value;
    });
  }

  @override
  String toString() {
    return '''
selectedTrunk: ${selectedTrunk}
    ''';
  }
}
