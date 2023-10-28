import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
part 'food_controller.g.dart';

@Injectable()
class FoodController = _FoodControllerBase with _$FoodController;

abstract class _FoodControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
