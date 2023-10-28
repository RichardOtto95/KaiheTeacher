import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:teacher_side/app/core/root/root_controller.dart';

import '../../utils/auth_status_enum.dart';

part 'splash_controller.g.dart';

@Injectable()
class SplashController = _SplashControllerBase with _$SplashController;

abstract class _SplashControllerBase with Store {
  final RootController rootController = Modular.get();
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }

  @action
  initState() async{
    FirebaseAuth _auth = FirebaseAuth.instance;
    User? _user = _auth.currentUser;
    AuthStatus status = AuthStatus.loading;
    print('_user: $_user');
    if(_user == null){
      _user =  await _auth.authStateChanges().first;
    }
    print('_user: $_user');
    status = _user == null ? AuthStatus.signed_out : AuthStatus.signed_in;
    print('auth status: $status ');
    if (status == AuthStatus.signed_in) {
      print('_user!.emailVerified: ${_user!.emailVerified}');
      if (_user.emailVerified) {
        // print('logado');
        rootController.selectedTrunk = 2;
      } else {
        _auth.signOut();
        rootController.selectedTrunk = 1;
      }
    } else {
      // print('deslogado');

      if (status == AuthStatus.signed_out) {
        rootController.selectedTrunk = 1;
      }
    }
  }
}
