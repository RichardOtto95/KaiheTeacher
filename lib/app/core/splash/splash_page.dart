import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:teacher_side/app/core/root/root_controller.dart';
import 'package:teacher_side/app/core/splash/splash_controller.dart';
import 'package:teacher_side/app/utils/auth_status_enum.dart';

class SplashPage extends StatefulWidget {
  final String title;
  const SplashPage({Key? key, this.title = 'SplashPage'}) : super(key: key);
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  final RootController rootController = Modular.get();
  final SplashController store = Modular.get();
  late ReactionDisposer disposer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      store.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Container()));
  }
}
