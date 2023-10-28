import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teacher_side/app/Model/constants.dart';

import '../activity_performed_controller.dart';

class ActivityCard extends StatelessWidget {
  ActivityCard({
    required this.title,
    required this.description,
    required this.hour,
    required this.color,
    required this.image,
    required this.id, 
    this.date,
  });

  final String title, description, hour, image, id;
  final Color color;
  final String? date;

  final ActivityPerformedController activityPerformedController = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         date != null
          ? Container(
            margin: EdgeInsets.fromLTRB(
                defaultPadding, defaultPadding, defaultPadding, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 1,
                  width: 50,
                  color: Colors.grey,
                ),
                Text(
                  date!,
                  style: TextStyle(color: Colors.grey),
                ),
                Container(
                  height: 1,
                  width: 50,
                  color: Colors.grey,
                ),
              ],
            ),
          )
          : Container(),
        Container(
          padding: EdgeInsets.fromLTRB(10, defaultPadding, 10, defaultPadding),
          margin: EdgeInsets.only(
            top: defaultPadding,
            left: defaultPadding,
            right: defaultPadding,
          ),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // SvgPicture.asset(
                  //   image,
                  //   height: 20,
                  //   width: 20,
                  //   fit: BoxFit.cover,
                  // ),
                  SizedBox(width: defaultPadding / 2),
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  Text(
                    hour,
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
              Text(
                description,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
