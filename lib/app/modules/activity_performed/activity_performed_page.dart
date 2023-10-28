import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobx/mobx.dart';
import 'package:teacher_side/app/Model/constants.dart';
import 'package:teacher_side/app/Model/neumorphism.dart';
import 'package:teacher_side/app/modules/activity_performed/widgets/activity_card.dart';
import 'package:teacher_side/app/modules/main/main_controller.dart';
import 'package:teacher_side/shared/components/responsive.dart';
import '../../../shared/components/side_menu.dart';
import 'activity_performed_controller.dart';

class ActivityPerformedPage extends StatefulWidget {
  final String title;
  const ActivityPerformedPage({Key? key, this.title = "ActivityPerformed"})
      : super(key: key);

  @override
  _ActivityPerformedPageState createState() => _ActivityPerformedPageState();
}

class _ActivityPerformedPageState
    extends ModularState<ActivityPerformedPage, ActivityPerformedController> {
  final MainController mainController = Modular.get();
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      scrollController.addListener(() {
        if (scrollController.position.maxScrollExtent - 40 <
            scrollController.offset) {
          print('fim');
          if (store.hasMore) {
            setState(() {
              store.limit += 20;            
            });
          };
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
          defaultPadding, defaultPadding, defaultPadding, defaultPadding),
      child: Column(
        children: [
          Responsive.isMobile(context)
              ? Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _searchBar(),
                    SizedBox(height: defaultPadding),
                    Observer(builder: (context) {
                      return _selectDates(
                          store.startDate.toDate(), store.endDate.toDate());
                    }),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _activityButton(
                          "Dever de casa",
                          HomeWorkColor,
                          HomeWorkColorAlpha,
                          "HOMEWORK",
                        ),
                        _activityButton(
                          "Aviso",
                          NoteColor,
                          NoteColorAlpha,
                          "NOTE",
                        ),
                        _activityButton(
                          "Soneca",
                          SleepColor,
                          SleepColorAlpha,
                          "SLEEP",
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _activityButton(
                          "Chamada",
                          AttendanceColor,
                          AttendanceColorAlpha,
                          "ATTENDANCE",
                        ),
                        _activityButton(
                          "Momentos",
                          MomentColor,
                          MomentColorAlpha,
                          "MOMENT",
                        ),
                        _activityButton(
                          "Alimentação",
                          FoodColor,
                          FoodColorAlpha,
                          "FOOD",
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _activityButton(
                          "Autorizações",
                          NoteColor,
                          NoteColorAlpha,
                          "AUTHORIZATION",
                        ),
                        _activityButton(
                          "Banheiro",
                          BathroomColor,
                          BathroomColorAlpha,
                          "BATHROOM",
                        ),
                        _activityButton(
                          "Registro",
                          ReportColor,
                          ReportColorAlpha,
                          "REPORT",
                        ),
                      ],
                    )
                  ],
                )
              : Row(
                  children: [
                    Expanded(child: _searchBar()),
                    SizedBox(width: defaultPadding),
                    Observer(builder: (context) {
                      return _selectDates(
                          store.startDate.toDate(), store.endDate.toDate());
                    })
                  ],
                ),
          // SizedBox(height: defaultPadding),
          !Responsive.isMobile(context)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _activityButton(
                      "Autorizações",
                      NoteColor,
                      NoteColorAlpha,
                      "AUTHORIZATION",
                    ),
                    _activityButton(
                      "Momentos",
                      MomentColor,
                      MomentColorAlpha,
                      "MOMENT",
                    ),
                    _activityButton(
                      "Dever de casa",
                      HomeWorkColor,
                      HomeWorkColorAlpha,
                      "HOMEWORK",
                    ),
                    _activityButton(
                      "Chamada",
                      AttendanceColor,
                      AttendanceColorAlpha,
                      "ATTENDANCE",
                    ),
                    _activityButton(
                      "Aviso",
                      NoteColor,
                      NoteColorAlpha,
                      "NOTE",
                    ),
                    _activityButton(
                      "Alimentação",
                      FoodColor,
                      FoodColorAlpha,
                      "FOOD",
                    ),
                    _activityButton(
                      "Banheiro",
                      BathroomColor,
                      BathroomColorAlpha,
                      "BATHROOM",
                    ),
                    _activityButton(
                      "Soneca",
                      SleepColor,
                      SleepColorAlpha,
                      "SLEEP",
                    ),
                    _activityButton(
                      "Registro",
                      ReportColor,
                      ReportColorAlpha,
                      "REPORT",
                    ),
                  ],
                )
              : Container(),
          SizedBox(height: 10),
          Expanded(
            child: Observer(
              builder: (context) {
                return FutureBuilder<List>(
                  future: store.getActivities(mainController.classId),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    List activitiesList = snapshot.data!;
                    return RefreshIndicator(
                      onRefresh: () async {
                        await Future.delayed(Duration(seconds: 1), () {
                          setState(() {
                            // store.divisorMap.clear();
                          });
                        });
                      },
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: activitiesList.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot activityDoc = activitiesList[index]; 
                          DocumentSnapshot? previousDoc;
                          if(index != 0)                         {
                            previousDoc = activitiesList[index -1]; 
                          }

                          return Column(
                            children: [
                              ActivityCard(
                                title: store.getTitle(activityDoc['activity']),
                                description: activityDoc['title'],
                                hour: store.getHour(activityDoc['created_at']),
                                color: store.getColor(activityDoc['activity']),
                                image: store.getImage(activityDoc['activity']),
                                id: activityDoc['id'],
                                date: store.getDate(activityDoc['created_at'], index == 0, previousDoc != null ? previousDoc['created_at'] : null),
                                // press: () {},
                              ),
                              index == activitiesList.length - 1 && store.hasMore
                                ? Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: defaultPadding),
                                    alignment: Alignment.center,
                                    child: CircularProgressIndicator(),
                                  )
                                : Container(),
                            ],
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _activityButton(
      String text, Color color, Color colorAlpha, String activity) {
    return Observer(builder: (context) {
      // print(
      //     'Observer: ${store.filterActivities.contains(activity)} contains $activity');
      var clicled = store.filterActivities.contains(activity);

      return Expanded(
          child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: TextButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      side: BorderSide(color: color))),
              overlayColor: MaterialStateColor.resolveWith(
                  (states) => Colors.transparent),
              backgroundColor:
                  MaterialStateProperty.all(clicled ? color : colorAlpha)),
          onPressed: () {
            store.alteredFilter(activity);
            setState(() {});
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              text,
              style: TextStyle(color: clicled ? Colors.white : TextColor),
            ),
          ),
        ),
      ));
    });
  }

  Widget _searchBar() {
    return Container(
      child: TextField(
        onChanged: (value) {
          store.filterText = value;
        },
        decoration: InputDecoration(
          hintText: "",
          fillColor: SearchColor,
          filled: true,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(defaultPadding * 0.75),
            child: SvgPicture.asset("assets/icons/Search.svg",
                width: 24, color: AppColor),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(28)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    ).addNeumorphism(
      offset: Offset(2, 2),
      borderRadius: 28,
      blurRadius: 1,
      topShadowColor: Colors.white,
      bottomShadowColor: Color(0xFF30384D).withOpacity(0.2),
    );
  }

  double getSize() {
    return Responsive.isMobile(context) ? 90 : 130;
  }

  Widget _selectDates(DateTime _inicialDate, DateTime _endDate) {
    print("_inicialDate: $_inicialDate,_endDate: $_endDate,");
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: SearchColor,
                borderRadius: new BorderRadius.circular(28.0),
              ),
              child: Text(
                _inicialDate.day.toString().padLeft(2, '0') +
                    '/' +
                    _inicialDate.month.toString().padLeft(2, '0') +
                    '/' +
                    _inicialDate.year.toString(),
                style: TextStyle(color: TextColor),
              ),
            ).addNeumorphism(
              offset: Offset(2, 2),
              borderRadius: 28,
              blurRadius: 1,
              topShadowColor: Colors.white,
              bottomShadowColor: Color(0xFF30384D).withOpacity(0.2),
            ),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext builder) {
                  return Container(
                    height: MediaQuery.of(context).copyWith().size.height / 3,
                    child: ScrollConfiguration(
                      behavior: ScrollBehavior(),
                      child: CupertinoDatePicker(
                        initialDateTime: _inicialDate,
                        onDateTimeChanged: (DateTime newdate) {
                          print('onDateTimeChanged: $newdate');
                          _inicialDate = newdate;
                          store.startDate = Timestamp.fromDate(newdate);
                        },
                        use24hFormat: true,
                        maximumDate: new DateTime.now(),
                        // minimumYear: DateTime.now().year,
                        mode: CupertinoDatePickerMode.date,                      
                      ),
                    ),
                  );
                },
              );
            },
          ),
          Text("até"),
          InkWell(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: SearchColor,
                borderRadius: new BorderRadius.circular(28.0),
              ),
              child: InkWell(
                child: Text(
                  _endDate.day.toString().padLeft(2, '0') +
                      '/' +
                      _endDate.month.toString().padLeft(2, '0') +
                      '/' +
                      _endDate.year.toString(),
                  style: TextStyle(color: TextColor),
                ),
              ),
            ).addNeumorphism(
              offset: Offset(2, 2),
              borderRadius: 28,
              blurRadius: 1,
              topShadowColor: Colors.white,
              bottomShadowColor: Color(0xFF30384D).withOpacity(0.2),
            ),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext builder) {
                  return Container(
                    height: MediaQuery.of(context).copyWith().size.height / 3,
                    child: CupertinoDatePicker(
                      initialDateTime: _endDate,
                      onDateTimeChanged: (DateTime newdate) {
                        print('onDateTimeChanged: $newdate');
                        store.endDate = Timestamp.fromDate(newdate);
                      },
                      use24hFormat: true,
                      maximumDate: new DateTime.now().add(Duration(days: 1)),
                      // minimumYear: DateTime.now().year,
                      mode: CupertinoDatePickerMode.date,
                    ),
                  );
                },
              );
            },
          ),
          SizedBox(
            width: 10,
          ),
          Container(
              width: getSize(),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: AppColor,
                borderRadius: new BorderRadius.circular(28.0),
              ),
              child: TextButton(
                onPressed: () {
                  setState(() {});
                },
                child: Text(
                  "Procurar",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )).addNeumorphism(
            offset: Offset(2, 2),
            borderRadius: 28,
            blurRadius: 1,
            topShadowColor: Colors.white,
            bottomShadowColor: Color(0xFF30384D).withOpacity(0.2),
          ),
        ],
      ),
    );
  }
}
