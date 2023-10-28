import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:teacher_side/firebase_options.dart';
import 'app/app_module.dart';
import 'app/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform
      // options: FirebaseOptions(
      //   apiKey: "AIzaSyDzYDJLcQjlS-bVVCaz4z7hzs9mkVVayD0",
      //   appId: "1:223539143896:web:29976875b9712caa85a3ad",
      //   messagingSenderId: "223539143896",
      //   projectId: "kaihe-54d62",
      //   storageBucket: "kaihe-54d62.appspot.com",
      //   authDomain: "kaihe-54d62.firebaseapp.com",
      //   measurementId: "G-ZG2VGM8K7L",
      // ),
      );

  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}
