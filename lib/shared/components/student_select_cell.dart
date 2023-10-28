import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teacher_side/app/Model/constants.dart';
import 'package:teacher_side/app/core/models/student_model.dart';
import 'package:teacher_side/app/modules/home/home_store.dart';
import 'package:teacher_side/app/modules/main/main_controller.dart';
import 'package:teacher_side/shared/components/responsive.dart';

class StudentSelectCell extends StatefulWidget {
  final StudentModel studentModel;
  final void Function() onTap;
  final bool selected;
  StudentSelectCell({
    Key? key,
    required this.selected,
    required this.studentModel,
    required this.onTap,
  }) : super(key: key);

  @override
  _StudentSelectCellState createState() => _StudentSelectCellState();
}

class _StudentSelectCellState extends State<StudentSelectCell>
    with AutomaticKeepAliveClientMixin {
  final HomeStore homeStore = Modular.get();
  final MainController mainController = Modular.get();

  // var color = Colors.grey;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: [
        TextButton(
            style: ButtonStyle(
              overlayColor: MaterialStateColor.resolveWith(
                  (states) => Colors.transparent),
            ),
            onLongPress: () {
              Modular.to
                  .pushNamed('/student-data/', arguments: widget.studentModel);
            },
            onPressed: widget.onTap,
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
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Visibility(
              visible: widget.selected,
              child: Container(
                width: 20,
                height: 20,
                decoration: new BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            SizedBox(
              width: defaultPadding,
            )
          ],
        ),
      ],
    );
  }
}
