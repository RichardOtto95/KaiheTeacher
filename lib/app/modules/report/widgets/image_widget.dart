import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teacher_side/app/Model/constants.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../report_controller.dart';

class ImageWidget extends StatefulWidget {
  final Color color;
  ImageWidget(
    this.color,
  );

  @override
  ImageWidgetState createState() => ImageWidgetState();
}

class ImageWidgetState extends State<ImageWidget> {
  final ReportController reportController = Modular.get();
  final size = 75.0;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: constraints.maxWidth * 0.25,
            child: TextButton(
              onPressed: () {
                reportController.pickImage();     
              },
              child: Container(
                decoration: BoxDecoration(
                    color: widget.color,
                    borderRadius: new BorderRadius.circular(7.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(2, 3),
                      ),
                    ]),
                width: this.size,
                height: this.size,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("+",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: Colors.black54)),
                    Text(
                      "Adicionar",
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
          ),
          Observer(builder: (context) {
           return Container(
              width: constraints.maxWidth * 0.75,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                  reportController.imagesList.length < 3
                        ? 3
                        : reportController.imagesList.length,
                    (index) {
                      if (index <= reportController.imagesList.length - 1) {
                        return Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: defaultPadding),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(7.0),
                                child: Image.memory(
                                  reportController.imagesList[index],
                                  height: this.size,
                                  width: this.size,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 10,
                              top: -10,
                              child: IconButton(
                                onPressed: (){
                                  reportController.imagesList.removeAt(index);
                                  reportController.fileNameList.removeAt(index);
                                },
                                icon: Icon(
                                  Icons.minimize,
                                  color: Colors.red,
                                ),
                              ),
                            ), 
                          ],
                        );
                      }
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(7.0),
                        child: Container(
                          margin: EdgeInsets.only(right: defaultPadding),
                          decoration: BoxDecoration(
                            color: widget.color,
                            borderRadius: new BorderRadius.circular(7.0),
                          ),
                          width: this.size,
                          height: this.size,
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          }),
        ],
      );
    });
  }
}
