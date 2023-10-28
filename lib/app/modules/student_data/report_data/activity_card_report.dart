import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teacher_side/app/Model/constants.dart';
import 'package:teacher_side/app/core/models/report_model.dart';
import '../../../../shared/components/responsive.dart';
import '../student_data_controller.dart';

class ActivityCardReport extends StatelessWidget {
  final StudentDataController store = Modular.get();

  ActivityCardReport({
    required this.press,
    required this.reportModel,
  });

  final VoidCallback press;
  final ReportModel reportModel;
  // bool selected = true;

  @override
  Widget build(BuildContext context) {
    //  Here the shadow is not showing properly
    double rightPadding = store.editReports ? defaultPadding *2 : defaultPadding;
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(defaultPadding, defaultPadding, rightPadding, defaultPadding),
          child: Container(
            decoration: BoxDecoration(
              color: MessageColor,
              borderRadius: BorderRadius.circular(7),
            ),
            child: TextButton(
              onPressed: press,
              child: Observer(
                builder: (context) {
                  return Container(
                    padding:
                        EdgeInsets.fromLTRB(10, defaultPadding, 10, defaultPadding),
                    decoration: BoxDecoration(
                      color: Responsive.isMobile(context) ? MessageColor : store.reportNote == reportModel.note ? MessageColor : Colors.white,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Center(
                              child: SvgPicture.asset(
                                "assets/icons/Icon_mensagem.svg",
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: defaultPadding / 2),
                            Expanded(
                              child: Text.rich(
                                TextSpan(
                                  text: '${reportModel.title} \n',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Responsive.isMobile(context) ? Colors.white : store.reportNote == reportModel.note ? Colors.white : MessageColor,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: reportModel.note,
                                      style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                          color: Responsive.isMobile(context) ? Colors.white : store.reportNote == reportModel.note ? Colors.white : MessageColor,
                                        ),
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
                                  hourFormatting(),
                                  style: Theme.of(context).textTheme.caption!.copyWith(
                                    color: Responsive.isMobile(context) ? Colors.white : store.reportNote == reportModel.note ? Colors.white : MessageColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
              ),
            ),
          ),
        ),
        store.editReports ?
        Positioned(
          right: 0,
          child: IconButton(
            icon: Icon(Icons.remove_circle, color: Colors.red,),
            onPressed: (){
              store.removeReport(reportModel.id, reportModel.studentId, context);
            },
          ),
        ) : Container(),
      ],
    );
  }

  String hourFormatting() {
    DateTime dateTime = reportModel.createdAt.toDate();
    String hour = dateTime.hour.toString().padLeft(2, '0');
    String minute = dateTime.minute.toString().padLeft(2, '0');
    return hour + ':' + minute;
  }
}
