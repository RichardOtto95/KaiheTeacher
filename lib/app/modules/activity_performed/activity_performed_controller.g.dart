// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_performed_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ActivityPerformedController on _ActivityPerformedControllerBase, Store {
  final _$hasMoreAtom = Atom(name: '_ActivityPerformedControllerBase.hasMore');

  @override
  bool get hasMore {
    _$hasMoreAtom.reportRead();
    return super.hasMore;
  }

  @override
  set hasMore(bool value) {
    _$hasMoreAtom.reportWrite(value, super.hasMore, () {
      super.hasMore = value;
    });
  }

  final _$filterTextAtom =
      Atom(name: '_ActivityPerformedControllerBase.filterText');

  @override
  String get filterText {
    _$filterTextAtom.reportRead();
    return super.filterText;
  }

  @override
  set filterText(String value) {
    _$filterTextAtom.reportWrite(value, super.filterText, () {
      super.filterText = value;
    });
  }

  final _$filterActivitiesAtom =
      Atom(name: '_ActivityPerformedControllerBase.filterActivities');

  @override
  ObservableList<dynamic> get filterActivities {
    _$filterActivitiesAtom.reportRead();
    return super.filterActivities;
  }

  @override
  set filterActivities(ObservableList<dynamic> value) {
    _$filterActivitiesAtom.reportWrite(value, super.filterActivities, () {
      super.filterActivities = value;
    });
  }

  final _$startDateAtom =
      Atom(name: '_ActivityPerformedControllerBase.startDate');

  @override
  Timestamp get startDate {
    _$startDateAtom.reportRead();
    return super.startDate;
  }

  @override
  set startDate(Timestamp value) {
    _$startDateAtom.reportWrite(value, super.startDate, () {
      super.startDate = value;
    });
  }

  final _$endDateAtom = Atom(name: '_ActivityPerformedControllerBase.endDate');

  @override
  Timestamp get endDate {
    _$endDateAtom.reportRead();
    return super.endDate;
  }

  @override
  set endDate(Timestamp value) {
    _$endDateAtom.reportWrite(value, super.endDate, () {
      super.endDate = value;
    });
  }

  final _$limitAtom = Atom(name: '_ActivityPerformedControllerBase.limit');

  @override
  int get limit {
    _$limitAtom.reportRead();
    return super.limit;
  }

  @override
  set limit(int value) {
    _$limitAtom.reportWrite(value, super.limit, () {
      super.limit = value;
    });
  }

  final _$getActivitiesAsyncAction =
      AsyncAction('_ActivityPerformedControllerBase.getActivities');

  @override
  Future<List<dynamic>> getActivities([String? classId]) {
    return _$getActivitiesAsyncAction.run(() => super.getActivities(classId));
  }

  final _$_ActivityPerformedControllerBaseActionController =
      ActionController(name: '_ActivityPerformedControllerBase');

  @override
  void alteredFilter(String activity) {
    final _$actionInfo = _$_ActivityPerformedControllerBaseActionController
        .startAction(name: '_ActivityPerformedControllerBase.alteredFilter');
    try {
      return super.alteredFilter(activity);
    } finally {
      _$_ActivityPerformedControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String getTitle(String activity) {
    final _$actionInfo = _$_ActivityPerformedControllerBaseActionController
        .startAction(name: '_ActivityPerformedControllerBase.getTitle');
    try {
      return super.getTitle(activity);
    } finally {
      _$_ActivityPerformedControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String getHour(Timestamp createdAt) {
    final _$actionInfo = _$_ActivityPerformedControllerBaseActionController
        .startAction(name: '_ActivityPerformedControllerBase.getHour');
    try {
      return super.getHour(createdAt);
    } finally {
      _$_ActivityPerformedControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  Color getColor(String activity) {
    final _$actionInfo = _$_ActivityPerformedControllerBaseActionController
        .startAction(name: '_ActivityPerformedControllerBase.getColor');
    try {
      return super.getColor(activity);
    } finally {
      _$_ActivityPerformedControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String getImage(String activity) {
    final _$actionInfo = _$_ActivityPerformedControllerBaseActionController
        .startAction(name: '_ActivityPerformedControllerBase.getImage');
    try {
      return super.getImage(activity);
    } finally {
      _$_ActivityPerformedControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String? getDate(
      Timestamp createdAt, bool isFirst, Timestamp? previousCreatedAt) {
    final _$actionInfo = _$_ActivityPerformedControllerBaseActionController
        .startAction(name: '_ActivityPerformedControllerBase.getDate');
    try {
      return super.getDate(createdAt, isFirst, previousCreatedAt);
    } finally {
      _$_ActivityPerformedControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
hasMore: ${hasMore},
filterText: ${filterText},
filterActivities: ${filterActivities},
startDate: ${startDate},
endDate: ${endDate},
limit: ${limit}
    ''';
  }
}
