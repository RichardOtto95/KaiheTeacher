import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teacher_side/app/Model/constants.dart';
import 'package:teacher_side/app/core/models/student_model.dart';
import 'package:teacher_side/app/modules/classroom/classroom_controller.dart';
import 'package:teacher_side/app/modules/home/home_store.dart';
import 'package:teacher_side/shared/components/responsive.dart';

class StudentCellClassRoom extends StatefulWidget {
  final StudentModel studentModel;
  StudentCellClassRoom({
    Key? key,
    required this.studentModel,
  }) : super(key: key);

  @override
  _StudentCellClassRoomState createState() => _StudentCellClassRoomState();
}

class _StudentCellClassRoomState extends State<StudentCellClassRoom>
    with AutomaticKeepAliveClientMixin {
  final HomeStore homeStore = Modular.get();
  final ClassroomController classroomController = Modular.get();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Observer(builder: (context) {
      return Stack(
        children: [
          TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateColor.resolveWith(
                  (states) => Colors.transparent),
            ),
            onLongPress: () {
              Modular.to.pushNamed(
                '/student-data-view',
                arguments: widget.studentModel,
              );
            },
            onPressed: () async {
              if (classroomController.removingStudents) {
                if (classroomController.removeStudentsList
                    .contains(widget.studentModel.id)) {
                  classroomController.removeStudentsList
                      .remove(widget.studentModel.id);
                } else {
                  classroomController.removeStudentsList
                      .add(widget.studentModel.id);
                }
                print("tap: ${classroomController.removeStudentsList}");
              }
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
          Positioned(
            top: 0,
            right: 15,
            child: Visibility(
              visible: classroomController.removingStudents,
              child: GestureDetector(
                onTap: () {
                  if (classroomController.removingStudents) {
                    if (classroomController.removeStudentsList
                        .contains(widget.studentModel.id)) {
                      classroomController.removeStudentsList
                          .remove(widget.studentModel.id);
                    } else {
                      classroomController.removeStudentsList
                          .add(widget.studentModel.id);
                    }
                    print("tap: ${classroomController.removeStudentsList}");
                  }
                },
                child: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: classroomController.removeStudentsList
                            .contains(widget.studentModel.id)
                        ? Colors.red
                        : Colors.white,
                  ),
                  alignment: Alignment.bottomCenter,
                  child: Icon(
                    Icons.remove,
                    color: classroomController.removeStudentsList
                            .contains(widget.studentModel.id)
                        ? Colors.white
                        : Colors.red,
                  ),
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}
