import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:teacher_side/app/Model/constants.dart';
import 'package:teacher_side/app/modules/main/main_controller.dart';
import '../messages_store.dart';
import 'text_message_bubble.dart';

class Chat extends StatefulWidget {
  final String chatId;
  final String? filterMessageId;

  const Chat({
    Key? key,
    required this.chatId,
    this.filterMessageId,
  }) : super(key: key);
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final MainController mainController = Modular.get();
  final MessagesStore store = Modular.get();
  final ItemScrollController itemScrollController = ItemScrollController();
  bool inProgress = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // print('dispose chat');
    mainController.chatPage = false;
    super.dispose();
  }

  jumpToMessage(QuerySnapshot messagesQuery) {
    print("messagesQuery.docs.length: ${messagesQuery.docs.length}");
    if (inProgress == false) {
      inProgress = true;
      for (int i = messagesQuery.docs.length - 1; i > 0; i--) {
        // print("i: $i id: ${messagesQuery.docs[i].id}");
        if (messagesQuery.docs[i].id == widget.filterMessageId) {
          WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
            itemScrollController.scrollTo(
                index: i, duration: Duration(milliseconds: 300));
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    double bottom = MediaQuery.of(context).viewInsets.bottom;
    String userId = FirebaseAuth.instance.currentUser!.uid;
    return Material(
      child: Observer(builder: (context) {
        if (store.image != null || store.fileWeb != null) {
          return Stack(
            children: [
              store.fileWeb != null
                  ? Container(
                      height: maxHeight,
                      width: maxWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/pdf.png',
                            fit: BoxFit.cover,
                            height: 200,
                            width: 200,
                          ),
                          Text(store.fileName),
                        ],
                      ),
                    )
                  : Container(
                      height: maxHeight,
                      width: maxWidth,
                      child: Image.memory(store.image!),
                    ),
              Positioned(
                right: 20,
                bottom: 20,
                child: InkWell(
                  onTap: () => store.sendFile(widget.chatId, context),
                  child: Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: MessageColor),
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 60,
                child: InkWell(
                  onTap: () {
                    store.image = null;
                    store.fileWeb = null;
                    store.fileName = '';
                  },
                  child: Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: MessageColor),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return Column(
          children: [
            AppBar(
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(20))),
              backgroundColor: MessageColor,
              title: Row(
                children: [
                  SvgPicture.asset("assets/icons/Icon_mensagem.svg", width: 26),
                  SizedBox(width: defaultPadding),
                  Text("Mensagem"),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('classes')
                    .doc(mainController.classId)
                    .collection('chats')
                    .doc(widget.chatId)
                    .collection('messages')
                    .where('status', isEqualTo: 'VISIBLE')
                    .orderBy('created_at', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    );
                  }
                  QuerySnapshot messagesQuery = snapshot.data!;

                  WidgetsBinding.instance!.addPostFrameCallback((_) {
                    jumpToMessage(messagesQuery);
                  });

                  return ScrollablePositionedList.builder(
                    padding: EdgeInsets.only(top: 10),
                    reverse: true,
                    scrollDirection: Axis.vertical,
                    itemCount: messagesQuery.docs.length,
                    itemScrollController: itemScrollController,
                    itemBuilder: (context, index) {
                      DocumentSnapshot messageDoc = messagesQuery.docs[index];
                      if (messageDoc['file_data'] != null) {
                        return Container(
                          width: maxWidth,
                          alignment: messageDoc['author_id'] == userId
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(
                                right: 15, left: 15, bottom: 15),
                            padding: EdgeInsets.all(5),
                            height: 180,
                            // width: 200,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(17)),
                              color: messageDoc['author_id'] == userId
                                  ? Color(0xff4c4c4c)
                                  : Colors.red,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment:
                                  messageDoc['author_id'] == userId
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 150,
                                  child: messageDoc['file_extension'] == 'pdf'
                                      ? InkWell(
                                          onTap: () {
                                            if (messageDoc['author_id'] !=
                                                userId) {
                                              store.downloadFiles(
                                                messageDoc['file_data'],
                                                messageDoc['file_name'],
                                                context,
                                              );
                                            }
                                          },
                                          child: Column(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15)),
                                                child: Image.asset(
                                                  'images/pdf.png',
                                                  fit: BoxFit.cover,
                                                  height: 130,
                                                  width: 130,
                                                ),
                                              ),
                                              Text(messageDoc['file_name'])
                                            ],
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Container(
                                                    width: 600,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.7,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                messageDoc[
                                                                    'file_data']))),
                                                  );
                                                });
                                          },
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            child: CachedNetworkImage(
                                              imageUrl: messageDoc['file_data'],
                                            ),
                                          ),
                                        ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                    store.getHour(messageDoc['created_at']),
                                    style: TextStyle(
                                      color: Color(0xfffafafa),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return TextMessageBubble(
                        author: messageDoc['author_id'] ==
                            FirebaseAuth.instance.currentUser!.uid,
                        hour: store.getHour(messageDoc['created_at']),
                        text: messageDoc['text'],
                        searched: messageDoc['id'] == widget.filterMessageId,
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              height: 72,
              width: maxWidth,
              margin: EdgeInsets.only(bottom: bottom),
              decoration: BoxDecoration(color: Color(0xfffafafa), boxShadow: [
                BoxShadow(
                    offset: Offset(0, -3),
                    color: Color(0x15000000),
                    blurRadius: 3)
              ]),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 45,
                    // width: 240,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0xff9A9EA4).withOpacity(.7)),
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          width: maxWidth * .45,
                          height: maxHeight * .03,
                          alignment: Alignment.center,
                          child: TextField(
                            controller: store.textEditingController,
                            cursorColor: Color(0xff707070),
                            maxLines: 2,
                            decoration: InputDecoration.collapsed(
                              border: InputBorder.none,
                              hintText: 'Digite uma mensagem...',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff7C8085).withOpacity(.8),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            store.sendTextMessage(widget.chatId);
                          },
                          icon: Icon(
                            Icons.send,
                            color: Color(0xff434B56).withOpacity(.85),
                            size: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 5),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      store.uploadFile(
                        camera: true,
                      );
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      child: Icon(
                        Icons.camera_alt,
                        color: Color(0xff434B56).withOpacity(.85),
                        size: 25,
                      ),
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      store.uploadFile();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      child: Icon(
                        Icons.attachment_outlined,
                        color: Color(0xff434B56).withOpacity(.85),
                        size: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

class SeparatorDay extends StatelessWidget {
  const SeparatorDay({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Container(
            height: 1,
            width: 100,
            color: Color(0xff787C81),
          ),
          Spacer(),
          Text(
            'dia 05 de juho',
            style: TextStyle(
              color: Color(0xff787C81),
            ),
          ),
          Spacer(),
          Container(
            height: 1,
            width: 100,
            color: Color(0xff787C81),
          ),
        ],
      ),
    );
  }
}
