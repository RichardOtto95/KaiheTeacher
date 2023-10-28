import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teacher_side/app/Model/constants.dart';
import 'package:teacher_side/app/modules/main/main_controller.dart';

part 'activity_performed_controller.g.dart';

@Injectable()
class ActivityPerformedController = _ActivityPerformedControllerBase
    with _$ActivityPerformedController;

abstract class _ActivityPerformedControllerBase with Store {
  final MainController mainController = Modular.get();
  @observable
  bool hasMore = true;
  @observable
  String filterText = '';
  @observable
  ObservableList filterActivities = [].asObservable();
  @observable
  Timestamp startDate = Timestamp.fromDate(
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 2));
  @observable
  Timestamp endDate = Timestamp.fromDate(DateTime(DateTime.now().year,
      DateTime.now().month, DateTime.now().day, 23, 59, 59));
  @observable 
  int limit = 20;

  List allActivities = [
    "REPORT",
    "BATHROOM",
    "AUTHORIZATION",
    "FOOD",
    "MOMENT",
    "ATTENDANCE",
    "SLEEP",
    "NOTE",
    "HOMEWORK",
  ];

  @action
  Future<List> getActivities([String? classId]) async {
    print('getActivities: ${mainController.classId}');
    print('getActivities: $classId');
    print('getActivities: $allActivities');
    print('filterActivities.isEmpty: ${filterActivities.isEmpty}');

    if (filterText.isNotEmpty) {
      QuerySnapshot activities = await FirebaseFirestore.instance
        .collection('classes')
        .doc(mainController.classId)
        .collection('activities')
        .where('activity',
            whereIn:
                filterActivities.isEmpty ? allActivities : filterActivities)
        .where('created_at', isGreaterThanOrEqualTo: startDate)
        .where('created_at', isLessThanOrEqualTo: endDate)
        .orderBy('created_at', descending: true)
        .get();

      print('activities1: ${activities.docs.length}');  
      List newList = [];

      activities.docs.forEach((item) {
        String title = item['title'].toString().toLowerCase();
        print('title: $title');
        print('filterText.toLowerCase(): ${filterText.toLowerCase()}');
        print('forEach: ${title.contains(filterText.toLowerCase())}');
        if (title.contains(filterText.toLowerCase())) {
          if(newList.length < limit){
            newList.add(item);
          }
        }
      });

      print('newList: $newList');

      hasMore = newList.length == limit;

      return newList;
    } else {
      QuerySnapshot activities = await FirebaseFirestore.instance
        .collection('classes')
        .doc(mainController.classId)
        .collection('activities')
        .where('activity',
            whereIn:
                filterActivities.isEmpty ? allActivities : filterActivities)
        .where('created_at', isGreaterThanOrEqualTo: startDate)
        .where('created_at', isLessThanOrEqualTo: endDate)
        .orderBy('created_at', descending: true)
        .limit(limit)
        .get();

      print('activities1: ${activities.docs.length}');  

      hasMore = activities.docs.length == limit;

      return activities.docs;
    }
  }

  @action
  void alteredFilter(String activity) {
    print('activity: $activity - $filterActivities');
    if (filterActivities.contains(activity)) {
      filterActivities.remove(activity);
    } else {
      filterActivities.add(activity);
    }
  }

  @action
  String getTitle(String activity) {
    switch (activity) {
      case 'MOMENT':
        return 'Momento';

      case 'HOMEWORK':
        return 'Dever de casa';

      case 'BATHROOM':
        return 'Banheiro';

      case 'WATTER':
        return 'Água';

      case 'FOOD':
        return 'Alimentação';

      case 'NOTE':
        return 'Bilhete';

      case 'REPORT':
        return 'Registro';

      case 'ATTENDANCE':
        return 'Chamada';

      case 'SLEEP':
        return 'Soneca';

      default:
        return activity;
    }
  }

  @action
  String getHour(Timestamp createdAt) {
    DateTime date = createdAt.toDate();
    String hour = date.hour.toString().padLeft(2, '0');
    String minute = date.minute.toString().padLeft(2, '0');
    return hour + ':' + minute;
  }

  @action
  Color getColor(String activity) {
    print('getColor activity: $activity');
    switch (activity) {
      case 'MOMENT':
        return MomentColor;

      case 'HOMEWORK':
        return HomeWorkColor;

      case 'BATHROOM':
        return BathroomColor;

      case 'WATTER':
        return FoodColor;

      case 'FOOD':
        return FoodColor;

      case 'NOTE':
        return NoteColor;

      case 'REPORT':
        return ReportColor;

      case 'ATTENDANCE':
        return AttendanceColor;

      case 'SLEEP':
        return SleepColor;

      default:
        return MessageColor;
    }
  }

  @action
  String getImage(String activity) {
    switch (activity) {
      case 'MOMENT':
        return "assets/icons/Icon_momentos.svg";

      case 'HOMEWORK':
        return "assets/icons/Icon_deverdecasa.svg";

      case 'BATHROOM':
        return "assets/icons/Icon_banheiro.svg";

      case 'WATTER':
        return "assets/icons/icon_alimentacao.svg";

      case 'FOOD':
        return "assets/icons/icon_alimentacao.svg";

      case 'NOTE':
        return "assets/icons/Icon_bilhete.svg";

      case 'REPORT':
        return "assets/icons/Icon_registro.svg";

      case 'ATTENDANCE':
        return "assets/icons/Icon_chamada.svg";

      case 'SLEEP':
        return "assets/icons/Icon_soneca.svg";

      default:
        return '';
    }
  }

  @action
  String? getDate(Timestamp createdAt, bool isFirst, Timestamp? previousCreatedAt) {
    List monthList = [
      '',
      'janeiro',
      'feverreiro',
      'março',
      'abril',
      'maio',
      'junho',
      'julho',
      'agosto',
      'setembro',
      'outubro',
      'novembro',
      'dezembro',
    ];    
    if(isFirst){
      DateTime dateTime = createdAt.toDate();
      String day = dateTime.day.toString().padLeft(2, '0');
      String month = monthList[dateTime.month];
      String year = dateTime.year.toString();
      String date = day + ' de ' + month + ' de ' + year;
      return date;
    } else {
      DateTime previousDateTime = previousCreatedAt!.toDate();
      String previousDay = previousDateTime.day.toString().padLeft(2, '0');
      String previousMonth = monthList[previousDateTime.month];
      String previousYear = previousDateTime.year.toString();
      String previousDate = previousDay + ' de ' + previousMonth + ' de ' + previousYear;

      DateTime dateTime = createdAt.toDate();
      String day = dateTime.day.toString().padLeft(2, '0');
      String month = monthList[dateTime.month];
      String year = dateTime.year.toString();
      String date = day + ' de ' + month + ' de ' + year;
      return previousDate != date ? date : null;
    }
  }
}
