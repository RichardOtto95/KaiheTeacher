import 'package:flutter/material.dart';
import 'package:teacher_side/app/Model/constants.dart';

class TextMessageBubble extends StatelessWidget {
  final bool author;
  final String text;
  final String hour;
  final bool searched;

  const TextMessageBubble({
    Key? key,
    required this.author,
    required this.text,
    required this.hour,
    required this.searched,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('author: $author');
    return Container(
      margin: EdgeInsets.fromLTRB(
          defaultPadding, 0, defaultPadding, defaultPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
            author ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: author ? Color(0xff4c4c4c) : MessageColor,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    top: 15,
                    right: 20,
                    bottom: 8,
                  ),
                  child: Container(
                    width: 200,
                    child: Text(
                      text,
                      style: TextStyle(
                          color: Color(0xfffafafa),
                          fontSize: 14,
                          fontWeight:
                              !searched ? FontWeight.w400 : FontWeight.w900),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  margin: EdgeInsets.only(
                    right: 17,
                    bottom: 4,
                  ),
                  child: Text(
                    hour,
                    style: TextStyle(
                        color: Color(0xfffafafa),
                        fontSize: 14,
                        fontWeight:
                            !searched ? FontWeight.w300 : FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
