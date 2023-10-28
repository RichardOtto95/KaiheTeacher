import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teacher_side/app/Model/constants.dart';

class ActivityCard extends StatelessWidget {
  final Map<String, dynamic> activityMap;
  final String hour;
  final bool isActive;
  final VoidCallback press;

  const ActivityCard({
    this.isActive = true,
    required this.hour,
    required this.press,
    required this.activityMap,
  });

  @override
  Widget build(BuildContext context) {
    //  Here the shadow is not showing properly
    print("activityMap: $activityMap");
    return Padding(
      padding: EdgeInsets.all(defaultPadding),
      child: Container(
        decoration: BoxDecoration(
          color: getColor(),
          borderRadius: BorderRadius.circular(7),
        ),
        child: TextButton(
          onPressed: press,
          child: Stack(
            children: [
              Container(
                padding:
                    EdgeInsets.fromLTRB(10, defaultPadding, 10, defaultPadding),
                decoration: BoxDecoration(
                  //color: isActive ? MessageColor : Colors.white,
                  color: getColor(),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Center(
                          child: SvgPicture.asset(
                            getSvgPath(),
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: defaultPadding / 2),
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              text: activityMap.containsKey("title")
                                  ? activityMap["title"]
                                  : activityMap.containsKey("responsible_name")
                                      ? activityMap["responsible_name"]
                                      : "Comunicado dos responsáveis",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                              children: [
                                if (activityMap.containsKey("note"))
                                  TextSpan(
                                    text: " ${activityMap["note"]}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: Colors.white),
                                  ),
                                if (activityMap.containsKey("description"))
                                  TextSpan(
                                    text: " ${activityMap["description"]}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: Colors.white),
                                  ),
                                if (activityMap.containsKey("text"))
                                  TextSpan(
                                    text: "${activityMap["text"]}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: Colors.white),
                                  ),
                              ],
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              hour,
                              style:
                                  Theme.of(context).textTheme.caption!.copyWith(
                                      // color: isActive ? Colors.white : null,
                                      color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
              // if (true)
              //   Positioned(
              //       right: 8,
              //       top: 8,
              //       child: Container(
              //         height: 12,
              //         width: 12,
              //         decoration: BoxDecoration(
              //           shape: BoxShape.circle,
              //           color: Colors.red,
              //         ),
              //       )),
            ],
          ),
        ),
      ),
    );
  }

  String getSvgPath() {
    switch (activityMap["activity"]) {
      case "ATTENDANCE":
        return "assets/icons/Icon_chamada.svg";
      case "ATTENDENCE":
        return "assets/icons/Icon_chamada.svg";
      case "FOOD":
        return "assets/icons/Icon_alimentação.svg";
      case "BATHROOM":
        return "assets/icons/Icon_banheiro.svg";
      case "HOMEWORK":
        return "assets/icons/Icon_deverdecasa.svg";
      case "NOTE":
        return "assets/icons/Icon_mensagem.svg";
      case "MOMENT":
        return "assets/icons/Icon_momentos.svg";
      case "REPORT":
        return "assets/icons/Icon_registro.svg";
      case "SLEEP":
        return "assets/icons/icon_soneca.svg";
      default:
        return "";
    }
  }

  Color getColor() {
    switch (activityMap["activity"]) {
      case "ATTENDANCE":
        return AttendanceColor;
      case "ATTENDENCE":
        return AttendanceColor;
      case "FOOD":
        return FoodColor;
      case "BATHROOM":
        return BathroomColor;
      case "HOMEWORK":
        return HomeWorkColor;
      case "NOTE":
        return Color(0xFFE04848);
      case "MOMENT":
        return MomentColor;
      case "REPORT":
        return ReportColor;
      case "SLEEP":
        return SleepColor;
      default:
        return Colors.grey;
    }
  }
}
