import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teacher_side/app/Model/constants.dart';
import 'package:teacher_side/app/core/root/root_controller.dart';
import 'package:teacher_side/app/modules/login/login_store.dart';
import 'package:flutter/material.dart';
import 'package:teacher_side/shared/components/responsive.dart';
// import 'package:bot_toast/bot_toast.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key? key, this.title = 'LoginPage'}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final LoginStore loginStore = Modular.get();
  final RootController rootController = Modular.get();
  String? messageError;
  bool loadCircular = false;
  bool obscurePassword = true;
  FocusNode passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return new Scaffold(
        body: new GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: SizedBox(
          height: (screenHeight - keyboardHeight),
          child: SingleChildScrollView(
              child: Container(
            decoration: BoxDecoration(color: AppColor),
            child: Column(children: [
              Center(
                child: Stack(
                  children: [
                    Responsive.isMobile(context) ?
                    Container(
                      padding: EdgeInsets.fromLTRB(0, screenHeight, 0, 0),
                      decoration: BoxDecoration(
                          color: AppColor,
                          image: DecorationImage(
                            image: AssetImage('assets/images/LoginPage.png'),
                          )),
                    ) : Container(),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          Responsive.isMobile(context) ? 0 : 370,
                          Responsive.isMobile(context) ? 340 : 50,
                          0,
                          0),
                      child: Column(
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              if (!Responsive.isMobile(context))
                                Container(
                                  width: 700,
                                  height: 700,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/Login.png'),
                                    scale: 0.7,
                                  )),
                                ),
                              Column(
                                children: [
                                  Container(
                                    child: Text(
                                      "A sua agenda escolar em um só lugar",
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: Responsive.isMobile(context)
                                            ? 13.0
                                            : 18,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        50, defaultPadding, 50, 0),
                                    child: SizedBox(
                                      width: 400,
                                      child: Column(
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(
                                                color: LoginColor,
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        15.0),
                                              ),
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Login",
                                                    prefixText: "   "),
                                                onChanged: (String value) {
                                                  loginStore.email = value;
                                                },
                                                onEditingComplete: () =>
                                                    passwordFocus
                                                        .requestFocus(),
                                              )),
                                          SizedBox(height: defaultPadding),
                                          Container(
                                              decoration: BoxDecoration(
                                                color: LoginColor,
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        15.0),
                                              ),
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Senha",
                                                    prefixText: "   "),
                                                focusNode: passwordFocus,
                                                onChanged: (String value) {
                                                  loginStore.password = value;
                                                },
                                              )),
                                          SizedBox(height: defaultPadding),
                                          Container(
                                              height: 40,
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 5, 0, 0),
                                                child: Text(
                                                  messageError != null
                                                      ? messageError!
                                                      : "",
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize:
                                                        Responsive.isMobile(
                                                                context)
                                                            ? 13.0
                                                            : 18,
                                                  ),
                                                ),
                                              )),
                                          Container(
                                              width: screenWidth * 0.4,
                                              height: screenHeight * 0.05,
                                              decoration: BoxDecoration(
                                                color: LoginColor,
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        10.0),
                                              ),
                                              child: loadCircular
                                                  ? Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    )
                                                  : MaterialButton(
                                                      child: Text("Entrar"),
                                                      onPressed: () async {
                                                        User? _user = FirebaseAuth.instance.currentUser;
                                                        print('_user != null: ${_user != null}');
                                                        setState(() {
                                                          loadCircular = true;
                                                        });                                             
                                                        // if(_user != null){
                                                        //   rootController.selectedTrunk = 2;
                                                        // } else {

                                                        
                                                        String? response;
                                                        response =
                                                          await loginStore
                                                            .signIn();

                                                        setState(() {
                                                          messageError =
                                                              response;
                                                          loadCircular = false;
                                                        });
                                                        // }
                                                      },
                                                    )),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  top: screenWidth * 0.01),
                                              width: screenWidth * 0.4,
                                              height: screenHeight * 0.05,
                                              decoration: BoxDecoration(
                                                color: LoginColor,
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        10.0),
                                              ),
                                              child: MaterialButton(
                                                child: Text("Cadastrar-se"),
                                                onPressed: () {
                                                  loginStore.password = "";
                                                  loginStore.email = "";
                                                  Modular.to
                                                      .pushNamed('/sign-up/');
                                                },
                                              )), 

                                              SizedBox(height: 100,),
                                              EsqueceuSenha()
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ), 
            
            ]),
          ))),
    ));
  }
}



                                        class EsqueceuSenha extends StatelessWidget {
                                          LoginStore loginStore = Modular.get();
                                          @override
                                          Widget build(BuildContext context) {
                                            return               GestureDetector(
                                                onTap: (){
                                                  showDialog(context: context, builder: (context){
                                                    return AlertDialog(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                                          
                                                          title: Text('Digite seu email para redefenir sua senha'),
                                                          content: Container(
                                                            height: Responsive.isMobile(context) ? MediaQuery.of(context).size.height * 0.35 : MediaQuery.of(context).size.height * 0.35,
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                 Image.asset('assets/images/esqueceuasenha.png'),
                                                               
                                                                TextField(
                                                                  controller: loginStore.controllerNewPassword,
                                                                ),
                                                                SizedBox(height: 10,),
                                                                Observer(builder: (context){
                                                                  return Text(loginStore.resultNewPasswordString);
                                                                })
                                                              ],
                                                            ),
                                                          ),
                                                          actions: [
                                                            Container(
                                                              width: double.infinity,
                                                              decoration: BoxDecoration(
                                                                borderRadius : BorderRadius.all(Radius.circular(60),
                                                              )),
                                                              child: ElevatedButton(
                                                                style: ElevatedButton.styleFrom(
                                                                        primary: Color(0xFF75C3B5), // Background color
                                                                      ),
                                                                      onPressed: () async{
                                                                await loginStore.sendEmailNewPassWord(context);
                                                              }, child: Text('Enviar')),
                                                            ),
                                                          ]);
                                                      
                                                  });
                                                },
                                                child:  Text('Esqueceu sua senha?', style: TextStyle(color: Responsive.isMobile(context) ? Colors.white : Colors.black, fontSize: 17),));
  }
}