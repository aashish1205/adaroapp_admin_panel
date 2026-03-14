import 'package:adaroapp_admin_panel/utils/helpers/network_manager.dart';
import 'package:get/get.dart';

import '../features/authentication/controllers/user_controller.dart';
import '../data/repositories/order/order_repository.dart';
import '../features/shop/controllers/order/order_controller.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {

    /// Core
    Get.lazyPut(() => NetworkManager(), fenix: true);
    Get.lazyPut(() => UserController(), fenix: true);

    /// Orders
    Get.lazyPut(() => OrderRepository(), fenix: true);
    Get.lazyPut(() => OrderController(), fenix: true);
  }
}