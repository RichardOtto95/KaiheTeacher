import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teacher_side/app/Model/constants.dart';
import 'package:teacher_side/app/modules/main/main_controller.dart';
import 'package:teacher_side/app/modules/messages/messages_store.dart';
import 'package:flutter/material.dart';
import 'package:teacher_side/app/modules/messages/widgets/message_card.dart';
import 'package:teacher_side/shared/components/responsive.dart';
import 'package:teacher_side/shared/components/side_menu.dart';
import 'widgets/chat.dart';
import 'widgets/search_card.dart';

class MessagesPage extends StatefulWidget {
  final String title;
  const MessagesPage({Key? key, this.title = 'MessagesPage'}) : super(key: key);
  @override
  MessagesPageState createState() => MessagesPageState();
}

class MessagesPageState extends State<MessagesPage> {
  final MessagesStore store = Modular.get();
  final MainController mainController = Modular.get();
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    print('dispose message');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: kIsWeb ? defaultPadding : 0),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Row(
                children: [
                  if (Responsive.isTablet(context))
                    IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () {
                        // _scaffoldKey.currentState!.openDrawer();
                      },
                    ),
                  if (!Responsive.isDesktop(context)) SizedBox(width: 5),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        store.searchTxt = value;
                        store.filterMessages(value);
                        setState(() {});
                      },
                      controller: textController,
                      decoration: InputDecoration(
                        hintText: "Pesquisar",
                        fillColor: Colors.white60,
                        filled: true,
                        prefixIcon: Padding(
                          padding:
                              const EdgeInsets.all(defaultPadding * 0.75), //15
                          child: SvgPicture.asset(
                            "assets/icons/Search.svg",
                            width: 24,
                            color: Colors.red,
                          ),
                        ),
                        // icon: Icon(Icons.close),
                        suffixIcon: IconButton(
                          onPressed: () {
                            store.searchTxt = "";
                            store.searchList.clear();
                            textController.clear();
                            setState(() {});
                          },
                          icon: Icon(Icons.close),
                          color: MessageColor,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Observer(builder: (context) {
                return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('classes')
                      .doc(mainController.classId)
                      .collection("chats")
                      // .where("teacher_id",
                      //     isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .where("status", isEqualTo: "ACTIVE")
                      .orderBy('updated_at', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      print('error');
                      print(snapshot.error);
                    }
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    QuerySnapshot chatQuery = snapshot.data!;

                    print('chatQuery: ${chatQuery.docs.length}');

                    return Observer(builder: (context) {
                      if (store.searchList.isEmpty && store.searchTxt == "") {
                        return ListView.builder(
                          itemCount: chatQuery.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot chatDoc = chatQuery.docs[index];
                            DateTime date = chatDoc['updated_at'].toDate();
                            store.getDivisor(chatDoc.id, chatDoc['updated_at']);
                            print(chatDoc['responsible_id']);

                            return Column(
                              children: [
                                MessageCard(
                                  chatId: chatDoc.id,
                                  parentId: chatDoc['responsible_id'],
                                  hour: date.hour.toString().padLeft(2, '0') +
                                      ":" +
                                      date.minute.toString().padLeft(2, '0'),
                                  isActive: Responsive.isMobile(context)
                                      ? false
                                      : index == 0,
                                  press: () {
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());

                                    mainController.chatPage = true;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) => Chat(
                                          chatId: chatDoc.id,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        if (store.searchList.isEmpty) {
                          return Padding(
                            padding: EdgeInsets.only(top: 50),
                            child: Text("Sem mensagens com este texto"),
                          );
                        }
                        return ListView.builder(
                          itemCount: store.searchList.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot messageDoc =
                                store.searchList[index];
                            DateTime date = messageDoc['created_at'].toDate();

                            return Column(
                              children: [
                                SearchCard(
                                  text: messageDoc['text'],
                                  hour: date.hour.toString().padLeft(2, '0') +
                                      ":" +
                                      date.minute.toString().padLeft(2, '0'),
                                  isActive: Responsive.isMobile(context)
                                      ? false
                                      : index == 0,
                                  press: () {
                                    mainController.chatPage = true;
                                    print("messageDoc: ${messageDoc.data()}");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) => Chat(
                                          chatId: messageDoc['chat_id'],
                                          filterMessageId: messageDoc['id'],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    });
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
