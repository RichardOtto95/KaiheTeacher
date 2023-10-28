import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teacher_side/app/core/empty_states/noConnection.dart';
import 'package:teacher_side/app/core/splash/splash_module.dart';
import 'package:teacher_side/app/modules/home/home_store.dart';
import 'package:teacher_side/app/modules/login/login_module.dart';
import 'package:teacher_side/app/modules/main/main_module.dart';
import 'root_controller.dart';




class RootPage extends StatefulWidget {
  const RootPage({ Key? key }) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final RootController controller = Modular.get();

  
  List<Widget> trunkModule = [SplashModule(), LoginModule(), MainModule()];
  

  @override
  void initState() {
    controller.checkConnectivityState().then((value) => {
     if(value){}else{
       showDialog(context: context, builder: (context){
         return NoConnection();
       })
     }
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     // print('xxxxxxx root page xxxxxxxxx');
    // if (FirebaseAuth.instance.currentUser != null) {
    //   return HomeModule();
    // } else {
    //   return LoginModule();
    //   // return Container();
    // }
    return Observer(
      builder: (context) {
        // print('xxxxxxx observer root page ${controller.selectedTrunk} xxxxxx');
        return trunkModule[controller.selectedTrunk];
      },
    );
  }
}
