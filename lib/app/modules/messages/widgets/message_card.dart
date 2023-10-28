import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teacher_side/app/Model/constants.dart';

import '../messages_store.dart';

class MessageCard extends StatelessWidget {
  final MessagesStore store = Modular.get();
  final String hour, parentId, chatId;
  final bool isActive;
  final VoidCallback press;

  MessageCard({
    this.isActive = true,
    required this.hour,
    required this.press,
    required this.parentId,
    required this.chatId,
  });

  @override
  Widget build(BuildContext context) {
    print('message card build');
    return Column(
      children: [
        Observer(
          builder: (context) {
            if (store.divisorsMap.containsKey(chatId)) {
              return Text(store.divisorsMap[chatId]);
            } else {
              return Container();
            }
          },
        ),
        Container(
          margin: EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
            color: MessageColor,
            borderRadius: BorderRadius.circular(7),
          ),
          child: TextButton(
            onPressed: press,
            child: Stack(
              children: [
                Container(
                  // color: isActive ? MessageColor : Colors.white,
                  padding: EdgeInsets.fromLTRB(
                      10, defaultPadding, 10, defaultPadding),
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
                            child: FutureBuilder<
                                    DocumentSnapshot<Map<String, dynamic>>>(
                                future: FirebaseFirestore.instance
                                    .collection('parents')
                                    .doc(parentId)
                                    .get(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return LinearProgressIndicator();
                                  }
                                  DocumentSnapshot parentDoc =
                                      snapshot.data!;

                                  return FutureBuilder<DocumentSnapshot>(
                                      future: store.getStudent(parentDoc),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return LinearProgressIndicator();
                                        }
                                        DocumentSnapshot studentDoc =
                                            snapshot.data!;
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              studentDoc['username'],
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              "${parentDoc['username']} - ${parentDoc['kinship']}",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        );
                                      });
                                }),
                          ),
                          Column(
                            children: [
                              Text(
                                hour,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                      // color: isActive ? Colors.white : null,
                                      color: Colors.white,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )
                // if (true)
                //   Positioned(
                //       right: 8,
                //       top: 8,
                //       child: Container(
                //         height: 12,
                //         width: 12,
                //         decoration: BoxDecoration(
                //           shape: BoxShape.circle,
                //           color: Colors.red,
                //         ),
                //       )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
