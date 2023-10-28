// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ReportController on _ReportControllerBase, Store {
  final _$textEditingControllerTitleAtom =
      Atom(name: '_ReportControllerBase.textEditingControllerTitle');

  @override
  TextEditingController get textEditingControllerTitle {
    _$textEditingControllerTitleAtom.reportRead();
    return super.textEditingControllerTitle;
  }

  @override
  set textEditingControllerTitle(TextEditingController value) {
    _$textEditingControllerTitleAtom
        .reportWrite(value, super.textEditingControllerTitle, () {
      super.textEditingControllerTitle = value;
    });
  }

  final _$textEditingControllerNoteAtom =
      Atom(name: '_ReportControllerBase.textEditingControllerNote');

  @override
  TextEditingController get textEditingControllerNote {
    _$textEditingControllerNoteAtom.reportRead();
    return super.textEditingControllerNote;
  }

  @override
  set textEditingControllerNote(TextEditingController value) {
    _$textEditingControllerNoteAtom
        .reportWrite(value, super.textEditingControllerNote, () {
      super.textEditingControllerNote = value;
    });
  }

  final _$imagesListAtom = Atom(name: '_ReportControllerBase.imagesList');

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

  final _$fileNameListAtom = Atom(name: '_ReportControllerBase.fileNameList');

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

  final _$pickImageAsyncAction = AsyncAction('_ReportControllerBase.pickImage');

  @override
  Future pickImage() {
    return _$pickImageAsyncAction.run(() => super.pickImage());
  }

  final _$toSendAsyncAction = AsyncAction('_ReportControllerBase.toSend');

  @override
  Future<String> toSend(dynamic context) {
    return _$toSendAsyncAction.run(() => super.toSend(context));
  }

  final _$_ReportControllerBaseActionController =
      ActionController(name: '_ReportControllerBase');

  @override
  void clear() {
    final _$actionInfo = _$_ReportControllerBaseActionController.startAction(
        name: '_ReportControllerBase.clear');
    try {
      return super.clear();
    } finally {
      _$_ReportControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
textEditingControllerTitle: ${textEditingControllerTitle},
textEditingControllerNote: ${textEditingControllerNote},
imagesList: ${imagesList},
fileNameList: ${fileNameList}
    ''';
  }
}
