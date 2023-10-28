import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobx/mobx.dart';
import 'package:teacher_side/app/core/root/root_controller.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final RootController rootController = Modular.get();

  @observable
  String email = '';
  @observable
  String password = '';

  @action
  Future<String?> signIn() async {
    bool filledAllFields = email.isNotEmpty && password.isNotEmpty;
    if (!filledAllFields) {
      return 'Todos os campos são obrigatórios';
    } else {
      // bool emailValid = RegExp(
      //         r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      //     .hasMatch(email);

      // if (!emailValid) {
      //   return 'Digite um e-mail válido';
      // }

      try {
        final FirebaseAuth _auth = FirebaseAuth.instance;
        User? _authUser = _auth.currentUser;
        if(_authUser == null){
          UserCredential userCredential = await _auth.signInWithEmailAndPassword(
              email: email, password: password);

          User? _user = userCredential.user;

          print('siginEmail $_user');

          DocumentSnapshot teacherDoc = await FirebaseFirestore.instance
              .collection("teachers")
              .doc(_user!.uid)
              .get();

          print('_user!.uid: ${_user.uid}');

          if(!kIsWeb){
            String? tokenString = await FirebaseMessaging.instance.getToken();
            print('tokenId: $tokenString');

            await teacherDoc.reference.update({
              'token_id': [tokenString]
            });
          }

          print('_user.emailVerified: ${_user.emailVerified}');

          if (_user.emailVerified) {
            // Modular.to.pushNamed('/home');
            rootController.selectedTrunk = 2;
            email = '';
            password = '';
          } else {
            await _user.sendEmailVerification();

            // Fluttertoast.showToast(
            //   msg: 'O seu e-mail não foi validado!',
            //   toastLength: Toast.LENGTH_SHORT,
            //   gravity: ToastGravity.CENTER,
            //   timeInSecForIosWeb: 1,
            //   backgroundColor: Colors.red,
            //   textColor: Colors.white,
            //   fontSize: 16.0,
            // );
            return "O seu e-mail não foi validado!";
          }

          return null;
        } else {
          await _authUser.reload();
          if (_authUser.emailVerified) {
            // Modular.to.pushNamed('/home');
            rootController.selectedTrunk = 2;
            email = '';
            password = '';
          } else {
            await _authUser.sendEmailVerification();

          //   Fluttertoast.showToast(
          //       msg: 'O seu e-mail não foi validado!',
          //       toastLength: Toast.LENGTH_SHORT,
          //       gravity: ToastGravity.CENTER,
          //       timeInSecForIosWeb: 1,
          //       backgroundColor: Colors.red,
          //       textColor: Colors.white,
          //       fontSize: 16.0);
            return 'O seu e-mail não foi validado!';
          }

          return null;
        }
      } on FirebaseAuthException catch (error) {
        print('ERROR');
        print(error.code);

        if (error.code == 'too-many-requests') {
          // Fluttertoast.showToast(
          //     msg: 'Aguerde alguns minutos para tentar novamente!',
          //     toastLength: Toast.LENGTH_SHORT,
          //     gravity: ToastGravity.CENTER,
          //     timeInSecForIosWeb: 1,
          //     backgroundColor: Colors.red,
          //     textColor: Colors.white,
          //     fontSize: 16.0);
          return 'Aguerde alguns minutos para tentar novamente!';
        }

        if (error.code == 'invalid-email') {
          return 'E-mail inválido!';
        }

        if (error.code == 'user-not-found') {
          return 'Não há usuário com este e-mail!';
        }

        if (error.code == 'user-disabled') {
          return 'Esse usuário foi desativado!';
        }

        if (error.code == 'wrong-password') {
          return 'Senha incorreta!';
        }

        return error.code;
      }

    }
  }

 //redefenir senha
 var controllerNewPassword = TextEditingController();

 @observable 
 String resultNewPasswordString = '';

 @action 
 sendEmailNewPassWord(BuildContext context) async{
  var firebaseAuth = FirebaseAuth.instance;
  await firebaseAuth.sendPasswordResetEmail(email: controllerNewPassword.text).then((value) {
    resultNewPasswordString = 'Email enviado com sucesso!';
  }).catchError((erro){
    resultNewPasswordString = 'Erro ao enviar email, confira se o email está correto';
  });

  await Future.delayed(Duration(seconds: 3));
  resultNewPasswordString = '';
  Navigator.pop(context);

 }
}
