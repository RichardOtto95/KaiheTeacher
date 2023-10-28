import 'package:flutter_modular/flutter_modular.dart';
import 'package:teacher_side/app/Model/constants.dart';
import 'package:flutter/material.dart';
import 'package:teacher_side/shared/components/responsive.dart';
import 'sign_up_controller.dart';

class SignUpPage extends StatefulWidget {
  final String title;
  const SignUpPage({Key? key, this.title = 'SignUpPage'}) : super(key: key);
  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final SignUpController signUpController = Modular.get();
  String? messageError;
  bool loadCircular = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
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
              child: Column(
                children: [
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
                                        image: AssetImage(
                                            'assets/images/Login.png'),
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
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            fontSize:
                                                Responsive.isMobile(context)
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
                                                        new BorderRadius
                                                            .circular(15.0),
                                                  ),
                                                  child: TextField(
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText: "E-mail",
                                                      prefixText: "   ",
                                                    ),
                                                    focusNode: emailFocus,
                                                    onChanged: (String value) {
                                                      signUpController.email =
                                                          value;
                                                    },
                                                    onEditingComplete: () {
                                                      passwordFocus
                                                          .requestFocus();
                                                    },
                                                  )),
                                              SizedBox(height: defaultPadding),
                                              Stack(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: LoginColor,
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(15.0),
                                                    ),
                                                    child: TextField(
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText: "Senha",
                                                        prefixText: "   ",
                                                      ),
                                                      focusNode: passwordFocus,
                                                      obscureText:
                                                          obscurePassword,
                                                      onChanged:
                                                          (String value) {
                                                        signUpController
                                                            .password = value;
                                                      },
                                                      onEditingComplete: () {
                                                        confirmPasswordFocus
                                                            .requestFocus();
                                                      },
                                                    ),
                                                  ),
                                                  Positioned(
                                                    right: 0,
                                                    child: IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          obscurePassword =
                                                              !obscurePassword;
                                                        });
                                                      },
                                                      icon: Icon(Icons
                                                          .remove_red_eye_outlined),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: defaultPadding),
                                              Stack(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: LoginColor,
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(15.0),
                                                    ),
                                                    child: TextField(
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            "Confirme a senha",
                                                        prefixText: "   ",
                                                      ),
                                                      focusNode:
                                                          confirmPasswordFocus,
                                                      obscureText:
                                                          obscureConfirmPassword,
                                                      onChanged:
                                                          (String value) {
                                                        signUpController
                                                                .confirmPassword =
                                                            value;
                                                      },
                                                    ),
                                                  ),
                                                  Positioned(
                                                    right: 0,
                                                    child: IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          obscureConfirmPassword =
                                                              !obscureConfirmPassword;
                                                        });
                                                      },
                                                      icon: Icon(Icons
                                                          .remove_red_eye_outlined),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: defaultPadding),
                                              Container(
                                                height: 20,
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 5, 0, 0),
                                                  child: Text(
                                                    messageError == null
                                                        ? ""
                                                        : messageError!,
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize:
                                                          Responsive.isMobile(
                                                                  context)
                                                              ? 13.0
                                                              : 18,
                                                    ),
                                                  ),
                                                ),
                                              ),
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
                                                        child:
                                                            Text("Cadastrar"),
                                                        onPressed: () async {
                                                          setState(() {
                                                            loadCircular = true;
                                                          });
                                                          String? response;
                                                          response =
                                                              await signUpController
                                                                  .signUp();

                                                          setState(() {
                                                            messageError =
                                                                response;
                                                            loadCircular =
                                                                false;
                                                          });
                                                        },
                                                      ),
                                              ),
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
