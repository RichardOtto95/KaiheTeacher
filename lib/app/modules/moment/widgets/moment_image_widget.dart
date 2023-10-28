import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teacher_side/app/Model/constants.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../moment_store.dart';

class MomentImageWidget extends StatefulWidget {
  final Color color;
  MomentImageWidget(
    this.color,
  );

  @override
  MomentImageWidgetState createState() => MomentImageWidgetState();
}

class MomentImageWidgetState extends State<MomentImageWidget> {
  final MomentStore momentStore = Modular.get();
  File image = File("");
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
                momentStore.pickImage();
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
                    momentStore.imagesList.length < 3
                        ? 3
                        : momentStore.imagesList.length,
                    (index) {
                      if (index <= momentStore.imagesList.length - 1) {
                        return Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: defaultPadding),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(7.0),
                                child: Image.memory(
                                  momentStore.imagesList[index],
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
                                  momentStore.imagesList.removeAt(index);
                                  momentStore.fileNameList.removeAt(index);
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

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (image != null) {
        this.image = File(image.path);
      } else {
        print('No image selected.');
      }
    });
  }
}
