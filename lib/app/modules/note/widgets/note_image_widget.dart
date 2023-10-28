import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teacher_side/app/Model/constants.dart';
import '../note_store.dart';

class NoteImageWidget extends StatefulWidget {
  final Color color;
  NoteImageWidget(
    this.color,
  );

  @override
  NoteImageWidgetState createState() => NoteImageWidgetState();
}

class NoteImageWidgetState extends State<NoteImageWidget> {
  final NoteStore store = Modular.get();
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
                store.pickImage();
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
                    store.imagesList.length < 3 ? 3 : store.imagesList.length,
                    (index) {
                      if (index <= store.imagesList.length - 1) {
                        return Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: defaultPadding),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(7.0),
                                child: Image.memory(
                                  store.imagesList[index],
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
                                  store.imagesList.removeAt(index);
                                  store.fileNameList.removeAt(index);
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
