import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teacher_side/app/Model/constants.dart';
import '../homework_store.dart';

class HomeworkImageWidget extends StatefulWidget {
  final Color color;
  HomeworkImageWidget(
    this.color,
  );

  @override
  HomeworkImageWidgetState createState() => HomeworkImageWidgetState();
}

class HomeworkImageWidgetState extends State<HomeworkImageWidget> {
  final HomeworkStore homeworkStore = Modular.get();
  File image = File("");
  final size = 75.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      // print(
      //     'LayoutBuilder: ${constraints.maxHeight} - ${constraints.maxWidth} - ${constraints.maxWidth * 0.25}');
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: constraints.maxWidth * 0.25,
            child: TextButton(
              onPressed: () {
                homeworkStore.pickImage();
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
                    homeworkStore.imagesList.length < 3
                        ? 3
                        : homeworkStore.imagesList.length,
                    (index) {
                      if (index <= homeworkStore.imagesList.length - 1) {
                        return Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: defaultPadding),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(7.0),
                                child: Image.memory(
                                  homeworkStore.imagesList[index],
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
                                  homeworkStore.imagesList.removeAt(index);
                                  homeworkStore.imagesNameList.removeAt(index);
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
          })             
        ],
      );
    });
  }

  //Precisa atualizar e colocar multiImage
  //https://pub.dev/packages/image_picker
  Future getImage() async {
    //Verificar se é mobile ou deskTop para trocar o source
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (image != null) {
        this.image = File(image.path);
      } else {
        // print('No image selected.');
      }
    });
  }
}
