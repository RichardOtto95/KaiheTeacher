// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MessagesStore on _MessagesStoreBase, Store {
  final _$divisorsMapAtom = Atom(name: '_MessagesStoreBase.divisorsMap');

  @override
  ObservableMap<dynamic, dynamic> get divisorsMap {
    _$divisorsMapAtom.reportRead();
    return super.divisorsMap;
  }

  @override
  set divisorsMap(ObservableMap<dynamic, dynamic> value) {
    _$divisorsMapAtom.reportWrite(value, super.divisorsMap, () {
      super.divisorsMap = value;
    });
  }

  final _$textEditingControllerAtom =
      Atom(name: '_MessagesStoreBase.textEditingController');

  @override
  TextEditingController get textEditingController {
    _$textEditingControllerAtom.reportRead();
    return super.textEditingController;
  }

  @override
  set textEditingController(TextEditingController value) {
    _$textEditingControllerAtom.reportWrite(value, super.textEditingController,
        () {
      super.textEditingController = value;
    });
  }

  final _$imageAtom = Atom(name: '_MessagesStoreBase.image');

  @override
  Uint8List? get image {
    _$imageAtom.reportRead();
    return super.image;
  }

  @override
  set image(Uint8List? value) {
    _$imageAtom.reportWrite(value, super.image, () {
      super.image = value;
    });
  }

  final _$searchListAtom = Atom(name: '_MessagesStoreBase.searchList');

  @override
  List<dynamic> get searchList {
    _$searchListAtom.reportRead();
    return super.searchList;
  }

  @override
  set searchList(List<dynamic> value) {
    _$searchListAtom.reportWrite(value, super.searchList, () {
      super.searchList = value;
    });
  }

  final _$searchTxtAtom = Atom(name: '_MessagesStoreBase.searchTxt');

  @override
  String get searchTxt {
    _$searchTxtAtom.reportRead();
    return super.searchTxt;
  }

  @override
  set searchTxt(String value) {
    _$searchTxtAtom.reportWrite(value, super.searchTxt, () {
      super.searchTxt = value;
    });
  }

  final _$fileNameAtom = Atom(name: '_MessagesStoreBase.fileName');

  @override
  String get fileName {
    _$fileNameAtom.reportRead();
    return super.fileName;
  }

  @override
  set fileName(String value) {
    _$fileNameAtom.reportWrite(value, super.fileName, () {
      super.fileName = value;
    });
  }

  final _$fileWebAtom = Atom(name: '_MessagesStoreBase.fileWeb');

  @override
  Uint8List? get fileWeb {
    _$fileWebAtom.reportRead();
    return super.fileWeb;
  }

  @override
  set fileWeb(Uint8List? value) {
    _$fileWebAtom.reportWrite(value, super.fileWeb, () {
      super.fileWeb = value;
    });
  }

  final _$fileExtensionAtom = Atom(name: '_MessagesStoreBase.fileExtension');

  @override
  String get fileExtension {
    _$fileExtensionAtom.reportRead();
    return super.fileExtension;
  }

  @override
  set fileExtension(String value) {
    _$fileExtensionAtom.reportWrite(value, super.fileExtension, () {
      super.fileExtension = value;
    });
  }

  final _$uploadFileAsyncAction = AsyncAction('_MessagesStoreBase.uploadFile');

  @override
  Future uploadFile({bool camera = false}) {
    return _$uploadFileAsyncAction.run(() => super.uploadFile(camera: camera));
  }

  final _$sendFileAsyncAction = AsyncAction('_MessagesStoreBase.sendFile');

  @override
  Future<dynamic> sendFile(String chatId, dynamic context) {
    return _$sendFileAsyncAction.run(() => super.sendFile(chatId, context));
  }

  final _$downloadFilesAsyncAction =
      AsyncAction('_MessagesStoreBase.downloadFiles');

  @override
  Future downloadFiles(String url, String fileName, BuildContext context) {
    return _$downloadFilesAsyncAction
        .run(() => super.downloadFiles(url, fileName, context));
  }

  final _$filterMessagesAsyncAction =
      AsyncAction('_MessagesStoreBase.filterMessages');

  @override
  Future filterMessages(String value) {
    return _$filterMessagesAsyncAction.run(() => super.filterMessages(value));
  }

  final _$sendTextMessageAsyncAction =
      AsyncAction('_MessagesStoreBase.sendTextMessage');

  @override
  Future<void> sendTextMessage(String chatId) {
    return _$sendTextMessageAsyncAction
        .run(() => super.sendTextMessage(chatId));
  }

  final _$getStudentAsyncAction = AsyncAction('_MessagesStoreBase.getStudent');

  @override
  Future<DocumentSnapshot<Object?>> getStudent(
      DocumentSnapshot<Object?> parentDoc) {
    return _$getStudentAsyncAction.run(() => super.getStudent(parentDoc));
  }

  final _$_MessagesStoreBaseActionController =
      ActionController(name: '_MessagesStoreBase');

  @override
  void getDivisor(String id, Timestamp updatedAt) {
    final _$actionInfo = _$_MessagesStoreBaseActionController.startAction(
        name: '_MessagesStoreBase.getDivisor');
    try {
      return super.getDivisor(id, updatedAt);
    } finally {
      _$_MessagesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String getHour(Timestamp? timestamp) {
    final _$actionInfo = _$_MessagesStoreBaseActionController.startAction(
        name: '_MessagesStoreBase.getHour');
    try {
      return super.getHour(timestamp);
    } finally {
      _$_MessagesStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
divisorsMap: ${divisorsMap},
textEditingController: ${textEditingController},
image: ${image},
searchList: ${searchList},
searchTxt: ${searchTxt},
fileName: ${fileName},
fileWeb: ${fileWeb},
fileExtension: ${fileExtension}
    ''';
  }
}
