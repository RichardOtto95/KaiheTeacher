// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on HomeStoreBase, Store {
  final _$selectedStudentsListAtom =
      Atom(name: 'HomeStoreBase.selectedStudentsList');

  @override
  ObservableList<dynamic> get selectedStudentsList {
    _$selectedStudentsListAtom.reportRead();
    return super.selectedStudentsList;
  }

  @override
  set selectedStudentsList(ObservableList<dynamic> value) {
    _$selectedStudentsListAtom.reportWrite(value, super.selectedStudentsList,
        () {
      super.selectedStudentsList = value;
    });
  }

  final _$allAreSelectedAtom = Atom(name: 'HomeStoreBase.allAreSelected');

  @override
  bool get allAreSelected {
    _$allAreSelectedAtom.reportRead();
    return super.allAreSelected;
  }

  @override
  set allAreSelected(bool value) {
    _$allAreSelectedAtom.reportWrite(value, super.allAreSelected, () {
      super.allAreSelected = value;
    });
  }

  final _$broughtBottleAtom = Atom(name: 'HomeStoreBase.broughtBottle');

  @override
  bool get broughtBottle {
    _$broughtBottleAtom.reportRead();
    return super.broughtBottle;
  }

  @override
  set broughtBottle(bool value) {
    _$broughtBottleAtom.reportWrite(value, super.broughtBottle, () {
      super.broughtBottle = value;
    });
  }

  final _$amtWaterAtom = Atom(name: 'HomeStoreBase.amtWater');

  @override
  double get amtWater {
    _$amtWaterAtom.reportRead();
    return super.amtWater;
  }

  @override
  set amtWater(double value) {
    _$amtWaterAtom.reportWrite(value, super.amtWater, () {
      super.amtWater = value;
    });
  }

  final _$whatValueAtom = Atom(name: 'HomeStoreBase.whatValue');

  @override
  int get whatValue {
    _$whatValueAtom.reportRead();
    return super.whatValue;
  }

  @override
  set whatValue(int value) {
    _$whatValueAtom.reportWrite(value, super.whatValue, () {
      super.whatValue = value;
    });
  }

  final _$classesQueryAtom = Atom(name: 'HomeStoreBase.classesQuery');

  @override
  QuerySnapshot<Object?>? get classesQuery {
    _$classesQueryAtom.reportRead();
    return super.classesQuery;
  }

  @override
  set classesQuery(QuerySnapshot<Object?>? value) {
    _$classesQueryAtom.reportWrite(value, super.classesQuery, () {
      super.classesQuery = value;
    });
  }

  final _$foodStudentsMapAtom = Atom(name: 'HomeStoreBase.foodStudentsMap');

  @override
  ObservableMap<dynamic, dynamic> get foodStudentsMap {
    _$foodStudentsMapAtom.reportRead();
    return super.foodStudentsMap;
  }

  @override
  set foodStudentsMap(ObservableMap<dynamic, dynamic> value) {
    _$foodStudentsMapAtom.reportWrite(value, super.foodStudentsMap, () {
      super.foodStudentsMap = value;
    });
  }

  final _$studentAttendenceMapAtom =
      Atom(name: 'HomeStoreBase.studentAttendenceMap');

  @override
  ObservableMap<dynamic, dynamic> get studentAttendenceMap {
    _$studentAttendenceMapAtom.reportRead();
    return super.studentAttendenceMap;
  }

  @override
  set studentAttendenceMap(ObservableMap<dynamic, dynamic> value) {
    _$studentAttendenceMapAtom.reportWrite(value, super.studentAttendenceMap,
        () {
      super.studentAttendenceMap = value;
    });
  }

  final _$studentAttendenceAlteredAtom =
      Atom(name: 'HomeStoreBase.studentAttendenceAltered');

  @override
  List<String> get studentAttendenceAltered {
    _$studentAttendenceAlteredAtom.reportRead();
    return super.studentAttendenceAltered;
  }

  @override
  set studentAttendenceAltered(List<String> value) {
    _$studentAttendenceAlteredAtom
        .reportWrite(value, super.studentAttendenceAltered, () {
      super.studentAttendenceAltered = value;
    });
  }

  final _$selectAllAsyncAction = AsyncAction('HomeStoreBase.selectAll');

  @override
  Future<void> selectAll() {
    return _$selectAllAsyncAction.run(() => super.selectAll());
  }

  final _$getStudentsAsyncAction = AsyncAction('HomeStoreBase.getStudents');

  @override
  Future<List<DocumentSnapshot<Object?>>> getStudents(String? classId) {
    return _$getStudentsAsyncAction.run(() => super.getStudents(classId));
  }

  final _$sendFoodDataAsyncAction = AsyncAction('HomeStoreBase.sendFoodData');

  @override
  Future<bool> sendFoodData(String foodWater, String? mealOfTheDay,
      String _text, dynamic context, String _title) {
    return _$sendFoodDataAsyncAction.run(() =>
        super.sendFoodData(foodWater, mealOfTheDay, _text, context, _title));
  }

  final _$HomeStoreBaseActionController =
      ActionController(name: 'HomeStoreBase');

  @override
  dynamic setStudentFoodStatus(String? _id) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.setStudentFoodStatus');
    try {
      return super.setStudentFoodStatus(_id);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Color getFoodColor(String? foodStatus) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.getFoodColor');
    try {
      return super.getFoodColor(foodStatus);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String dateFormatting(Timestamp date, [bool withHour = false]) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.dateFormatting');
    try {
      return super.dateFormatting(date, withHour);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedStudentsList: ${selectedStudentsList},
allAreSelected: ${allAreSelected},
broughtBottle: ${broughtBottle},
amtWater: ${amtWater},
whatValue: ${whatValue},
classesQuery: ${classesQuery},
foodStudentsMap: ${foodStudentsMap},
studentAttendenceMap: ${studentAttendenceMap},
studentAttendenceAltered: ${studentAttendenceAltered}
    ''';
  }
}
