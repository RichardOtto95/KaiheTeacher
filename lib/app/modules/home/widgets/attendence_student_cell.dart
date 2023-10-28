import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teacher_side/app/Model/constants.dart';
import 'package:teacher_side/app/core/models/student_model.dart';
import 'package:teacher_side/app/modules/attendence/attendence_store.dart';
import 'package:teacher_side/app/modules/home/home_store.dart';
import 'package:teacher_side/shared/components/responsive.dart';

class AttendenceStudentCell extends StatefulWidget {
  final StudentModel studentModel;
  AttendenceStudentCell({
    Key? key,
    required this.studentModel,
  }) : super(key: key);

  @override
  _AttendenceStudentCellState createState() => _AttendenceStudentCellState();
}

class _AttendenceStudentCellState extends State<AttendenceStudentCell>
    with AutomaticKeepAliveClientMixin {
  final HomeStore homeStore = Modular.get();
  final AttendenceStore store = Modular.get();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: [
        TextButton(
          style: ButtonStyle(
            overlayColor:
                MaterialStateColor.resolveWith((states) => Colors.transparent),
          ),
          onLongPress: () {
            Modular.to.pushNamed(
              '/student-data-view',
              arguments: widget.studentModel,
            );
          },
          onPressed: () {
            store.studentAttendenceAltered(widget.studentModel.id);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Column(
              children: [
                SizedBox(
                  height: 80,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: 
                      widget.studentModel.avatar != null ?
                      CachedNetworkImage(
                        imageUrl: widget.studentModel.avatar!,
                        progressIndicatorBuilder: (context, url,
                                downloadProgress) =>
                            Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    new AlwaysStoppedAnimation<Color>(AppColor),
                                value: downloadProgress.progress,
                                strokeWidth: 4,
                              ),
                            ),
                        height: Responsive.isMobile(context) ? 170 : 210,
                        width: Responsive.isMobile(context) ? 170 : 200,
                        fit: BoxFit.cover,
                      ) : Image.asset(
                        "assets/images/person.jpeg",
                        height: Responsive.isMobile(context) ? 170 : 210,
                        width: Responsive.isMobile(context) ? 170 : 200,
                        fit: BoxFit.cover,
                      ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Center(
                      child: Text(
                        widget.studentModel.username,
                        maxLines: 3,
                        style: TextStyle(color: Colors.black),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Observer(builder: (context) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: new BoxDecoration(
                  color: store.getColor(
                      homeStore.studentAttendenceMap[widget.studentModel.id]),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(
                width: defaultPadding,
              )
            ],
          );
        }),
      ],
    );
  }
}
