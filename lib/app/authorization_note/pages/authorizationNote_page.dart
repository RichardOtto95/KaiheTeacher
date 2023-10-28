import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mobx_widget/mobx_widget.dart';
import 'package:teacher_side/app/Model/constants.dart';
import 'package:teacher_side/app/authorization_note/models/AuthorizationNote_model.dart';
import 'package:teacher_side/app/authorization_note/stores/authorizationNote_store.dart';
import 'package:flutter/material.dart';
import 'package:teacher_side/app/authorization_note/models/student_authorize_model.dart';
import 'package:teacher_side/app/modules/main/main_controller.dart';
import 'package:teacher_side/shared/components/responsive.dart';

class AuthorizationNotePage extends StatefulWidget {
  final String title;
  const AuthorizationNotePage({Key? key, this.title = 'AuthorizationNotePage'})
      : super(key: key);
  @override
  AuthorizationNotePageState createState() => AuthorizationNotePageState();
}

class AuthorizationNotePageState extends State<AuthorizationNotePage> {
  final AuthorizationNoteStore store = Modular.get();
  final MainController mainContrller = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Responsive.isMobile(context) == false
            ? Row(
                children: [
                  Expanded(flex: 2, child: NotesWithAuthorizationPage()),
                  Expanded(flex: 2, child: StudentsWithAuthorization())
                ],
              )
            : PageView(
                children: [
                  NotesWithAuthorizationPage(),
                ],
              ));
  }
}

class NotesWithAuthorizationPage extends StatefulWidget {
  const NotesWithAuthorizationPage({Key? key}) : super(key: key);

  @override
  State<NotesWithAuthorizationPage> createState() =>
      _NotesWithAuthorizationPageState();
}

class _NotesWithAuthorizationPageState
    extends State<NotesWithAuthorizationPage> {
  final AuthorizationNoteStore store = Modular.get();
  final MainController mainContrller = Modular.get();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ObserverFuture<List<AuthorizationNoteModel>, Exception>(
      // Use this widget to handle ObservableFuture events
      retry: 2, // It will retry 2 times after the first error event
      autoInitialize: true, // If true, it will call [fetchData] automatically
      fetchData: () {
        store.getNotes(mainContrller.classId!);
      } // VoidCallback
      ,
      observableFuture: () => store.notesAuthorization,
      onData: (_, data) {
        if (data.length == 0) {
          return Center(
              child: Text(
                  "Nenhum bilhete que precise de autorização cadastrado para essa turma"));
        }
        return Padding(
            padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.05,
                top: MediaQuery.of(context).size.height * 0.05,
                bottom: MediaQuery.of(context).size.height * 0.05),
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var noteAuthotization = data[index];
                  return Column(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: Responsive.isMobile(context) ? 20 : 45,
                                right: Responsive.isMobile(context) ? 0 : 10,
                                top: Responsive.isMobile(context) ? 48 : 0),
                            child: GestureDetector(
                              onTap: () async {
                                store.changeNoteId(noteAuthotization.id);
                                store.changeAuthorizaionNote(noteAuthotization);
                                store.getStudentsAuthorie(
                                    mainContrller.classId!,
                                    noteAuthotization.id);
                                if (Responsive.isMobile(context)) {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return StudentsWithAuthorization();
                                  }));
                                }
                              },
                              child: Container(
                                  width: double.infinity,
                                  height: 80,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFEB6780),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SvgPicture.asset(
                                          "assets/icons/Icon_bilhete.svg",
                                          height: 40,
                                          width: 40,
                                          // color: Colors.white,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              noteAuthotization.title,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              noteAuthotization.note,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                        Text(
                                          DateFormat("H:m").format(
                                              noteAuthotization.created_at),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: Responsive.isMobile(context) ? 0 : 10,
                          )
                        ],
                      )
                    ],
                  );
                }));
      },
      onNull: (_) => Text('NULL'),
      onError: (_, error) => Text('Ocorreu um erro ao tentar buscar os dados'),
      onPending: (_) => Center(child: CircularProgressIndicator()),
      onUnstarted: (_) => Text('UNSTARTED'),
    ));
  }
}

class StudentsWithAuthorization extends StatefulWidget {
  @override
  State<StudentsWithAuthorization> createState() =>
      _StudentsWithAuthorizationState();
}

class _StudentsWithAuthorizationState extends State<StudentsWithAuthorization> {
  final AuthorizationNoteStore store = Modular.get();
  final MainController mainContrller = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      if (Responsive.isMobile(context)) {
        return Scaffold(
            body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/autorização_view.png'),
                  fit: Responsive.isMobile(context)
                      ? BoxFit.scaleDown
                      : BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Column(children: [
              Padding(
                padding: EdgeInsets.only(
                    top: Responsive.isMobile(context) == true
                        ? 155.0
                        : Responsive.isTablet(context)
                            ? 10
                            : MediaQuery.of(context).size.height * 0.08,
                    left: 47,
                    right: 67),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/Icon_bilhete.svg",
                      height: 40,
                      width: 40,
                      // color: Colors.white,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Observer(builder: (context) {
                          return store.authorizaionNoteForPage == null
                              ? Text('')
                              : Text(
                                  store.authorizaionNoteForPage!.title,
                                  style: TextStyle(color: Colors.white),
                                );
                        }),
                        Observer(builder: (context) {
                          return store.authorizaionNoteForPage == null
                              ? Text('')
                              : Text(
                                  store.authorizaionNoteForPage!.note,
                                  style: TextStyle(color: Colors.white),
                                );
                        })
                      ],
                    ),
                    Observer(builder: (context) {
                      return store.authorizaionNoteForPage == null
                          ? Text('')
                          : Text(
                              DateFormat("H:m").format(
                                  store.authorizaionNoteForPage!.created_at),
                              style: TextStyle(color: Colors.white),
                            );
                    })
                  ],
                ),
              ),
              Builder(builder: (context) {
                if (Responsive.isMobile(context)) {
                  return Container();
                }
                return SizedBox(
                  height: 30,
                );
              }),
              ObserverFuture<List<StudentAuthorizeaModel>, Exception>(
                // Use this widget to handle ObservableFuture events
                retry: 2, // It will retry 2 times after the first error event
                autoInitialize:
                    false, // If true, it will call [fetchData] automatically
                fetchData: () {
                  store.getStudentsAuthorie(
                      mainContrller.classId!, store.noteId);
                }, // VoidCallback

                observableFuture: () => store.StudentsAuthorize,
                onData: (_, data) {
                  if (data.length == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 28.0),
                      child: Center(
                          child: Text('Nenhum aluno foi autorizado ainda')),
                    );
                  }
                  return Container(
                    height: 400,
                    width: 440,
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent:
                                Responsive.isMobile(context) ? 200 : 400,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                        itemCount: data.length,
                        itemBuilder: (BuildContext ctx, index) {
                          var student = data[index];
                          return Padding(
                            padding: EdgeInsets.only(
                                left: Responsive.isMobile(context) ? 20.0 : 0),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/person.jpeg',
                                  width: 80,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(student.name)
                              ],
                            ),
                          );
                        }),
                  );
                },
                onNull: (_) => Text('NULL'),
                onError: (_, error) =>
                    Center(child: Text('Erro ao buscar os alunos autorizados')),
                onPending: (_) => Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            ]),
          ),
        ));
      }
      return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/autorização_view.png'),
                fit: Responsive.isMobile(context)
                    ? BoxFit.scaleDown
                    : BoxFit.cover)),
        child: Column(children: [
          Padding(
            padding: EdgeInsets.only(
                top: Responsive.isMobile(context) == true
                    ? 155.0
                    : Responsive.isTablet(context)
                        ? 10
                        : MediaQuery.of(context).size.height * 0.08,
                left: 47,
                right: 67),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SvgPicture.asset(
                  "assets/icons/Icon_bilhete.svg",
                  height: 40,
                  width: 40,
                  // color: Colors.white,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Observer(builder: (context) {
                      return store.authorizaionNoteForPage == null
                          ? Text('')
                          : Text(
                              store.authorizaionNoteForPage!.title,
                              style: TextStyle(color: Colors.white),
                            );
                    }),
                    Observer(builder: (context) {
                      return store.authorizaionNoteForPage == null
                          ? Text('')
                          : Text(
                              store.authorizaionNoteForPage!.note,
                              style: TextStyle(color: Colors.white),
                            );
                    })
                  ],
                ),
                Observer(builder: (context) {
                  return store.authorizaionNoteForPage == null
                      ? Text('')
                      : Text(
                          DateFormat("H:m").format(
                              store.authorizaionNoteForPage!.created_at),
                          style: TextStyle(color: Colors.white),
                        );
                })
              ],
            ),
          ),
          Builder(builder: (context) {
            if (Responsive.isMobile(context)) {
              return Container();
            }
            return SizedBox(
              height: 30,
            );
          }),
          ObserverFuture<List<StudentAuthorizeaModel>, Exception>(
            // Use this widget to handle ObservableFuture events
            retry: 2, // It will retry 2 times after the first error event
            autoInitialize:
                false, // If true, it will call [fetchData] automatically
            fetchData: () {
              store.getStudentsAuthorie(mainContrller.classId!, store.noteId);
            }, // VoidCallback

            observableFuture: () => store.StudentsAuthorize,
            onData: (_, data) {
              if (data.length == 0) {
                return Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child:
                      Center(child: Text('Nenhum aluno foi autorizado ainda')),
                );
              }
              return Container(
                height: 400,
                width: 440,
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent:
                            Responsive.isMobile(context) ? 50 : 400,
                        childAspectRatio: 3 / 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20),
                    itemCount: data.length,
                    itemBuilder: (BuildContext ctx, index) {
                      var student = data[index];
                      return Padding(
                        padding: EdgeInsets.only(
                            left: Responsive.isMobile(context) ? 20.0 : 0),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/person.jpeg',
                              width: 80,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(student.name)
                          ],
                        ),
                      );
                    }),
              );
            },
            onNull: (_) => Text('NULL'),
            onError: (_, error) =>
                Center(child: Text('Erro ao buscar os alunos autorizados')),
            onPending: (_) => Padding(
              padding: const EdgeInsets.only(top: 28.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          )
        ]),
      );
    });
  }
}
