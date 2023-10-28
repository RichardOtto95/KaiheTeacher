import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teacher_side/app/core/root/root_controller.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
part 'sign_up_controller.g.dart';

class SignUpController = _SignUpControllerBase with _$SignUpController;

abstract class _SignUpControllerBase with Store {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final RootController rootController = Modular.get();

  @observable
  int value = 0;
  @observable
  String email = '';
  @observable
  String password = '';
  @observable
  String confirmPassword = '';

  @action
  Future<String?> signUp() async {
    bool filledAllFields =
        email.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty;
    if (!filledAllFields) {
      return 'Todos os campos são obrigatórios';
    } else {
      bool emailValid = RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(email);

      bool passwordValid = password.length >= 8;

      bool confirmPasswordValid = password == confirmPassword;

      if (!emailValid) {
        return 'Digite um e-mail válido';
      }

      if (!passwordValid) {
        return 'Mínimo de 8 caracteres na senha';
      }

      if (!confirmPasswordValid) {
        return 'Senhas diferentes';
      }

      try {
        QuerySnapshot teachers = await FirebaseFirestore.instance
            .collection('preregistrations')
            .where('type', isEqualTo: 'TEACHER')
            .where('email', isEqualTo: email)
            .get();

        if (teachers.docs.isNotEmpty) {
          DocumentSnapshot teacherPreviousRegisted = teachers.docs.first;
          String status = teacherPreviousRegisted['status'];

          if (status == 'PENDING') {
            UserCredential userCredential =
                await _auth.createUserWithEmailAndPassword(
                    email: email, password: password);

            User? _user = userCredential.user;

            // user = _user;

            print('siginEmail $_user');

            if (_user != null) {
              print('%%%%%%%% signinPhone _user.exists == false  %%%%%%%%');

              await _user.reload();
              await _user.sendEmailVerification();

              DocumentReference teacherDoc = FirebaseFirestore.instance
                  .collection('teachers')
                  .doc(_user.uid);

              await teacherDoc.set(teacherPreviousRegisted.data());

              await teacherDoc.update({
                'id': _user.uid,
                'created_at': FieldValue.serverTimestamp(),
                'notification_enabled': true,
                'status': 'ACTIVE',
                'connected': true,
                'country': 'Brasil',
              });

              QuerySnapshot classesQuery = await FirebaseFirestore.instance.collection("classes").get();

              for (var i = 0; i < classesQuery.docs.length; i++) {
                DocumentSnapshot classDoc = classesQuery.docs[i];
                await teacherDoc.collection('classes').doc(classDoc.id).set({
                  'created_at': FieldValue.serverTimestamp(),
                  'id': classDoc.id,
                });

                classDoc.reference.collection('teachers').doc(teacherDoc.id).set({
                  "id": teacherDoc.id,
                  "added_at": FieldValue.serverTimestamp(),
                });
                
              }              

              if(!kIsWeb){
                String? tokenString = await FirebaseMessaging.instance.getToken();
                print('tokenId: $tokenString');

                await teacherDoc.update({
                  'token_id': [tokenString]
                });
              }

              await teacherPreviousRegisted.reference
                  .update({'status': 'REGISTERED'});

              // Modular.to.pushNamed('/home/');
              if (_user.emailVerified) {
                rootController.selectedTrunk = 2;
                Modular.to.pop();
                email = '';
                password = '';
                confirmPassword = '';
                return 'SUCCESS';
              } else {
                Fluttertoast.showToast(
                  msg: 'O seu e-mail não foi validado!',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
                print('Modular.to.path ${Modular.to.path}');
                // Modular.to.pop();
                Modular.to.pushNamed('/login');
              }
            }
          } else {
            return 'Usuário já cadastrado';
          }
        } else {
          return 'Usuário não encontrado';
        }
      } on FirebaseAuthException catch (error) {
        print('ERROR');
        print(error.code);

        if (error.code == 'invalid-email') {
          return 'E-mail inválido!';
        }

        if (error.code == 'email-already-in-use') {
          return 'Esse e-mail já está em uso!';
        }

        if (error.code == 'operation-not-allowed') {
          return 'OPS... erro inesperado, contate o suporte.';
        }

        if (error.code == 'weak-password') {
          return 'Senha fraca!';
        }
      }
    }
  }
}
