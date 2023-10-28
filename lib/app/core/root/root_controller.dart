import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
part 'root_controller.g.dart';

@Injectable()
class RootController = _RootControllerBase with _$RootController;

abstract class _RootControllerBase with Store {
  @observable
  int selectedTrunk = 0;

  
  Future<bool> checkConnectivityState() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();
 
    if (result == ConnectivityResult.wifi) {
      print('Connected to a Wi-Fi network');
      return true;
    } else if (result == ConnectivityResult.mobile) {
      print('Connected to a mobile network');
      return true;
    } 
    return false;
  }
}
