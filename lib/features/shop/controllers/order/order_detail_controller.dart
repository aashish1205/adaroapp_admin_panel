import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../../data/repositories/user/user_repository.dart';
import '../../../../models/order_model.dart';
import '../../../../models/user_model.dart';
import '../../../../utils/popups/loaders.dart';


class OrderDetailController extends GetxController {
  static OrderDetailController get instance => Get.find();

  RxBool loading = true.obs;
  Rx<OrderModel> order = OrderModel.empty().obs;
  Rx<UserModel> customer = UserModel.empty().obs;

  @override
  void onInit() {
    super.onInit();
    getCustomerOfCurrentOrder();
  }

  /// Load customer orders
  Future<void> getCustomerOfCurrentOrder() async {
    try {
      loading.value = true;

      /// Prevent empty userId call
      if (order.value.userId.isEmpty) {
        return;
      }

      final user =
      await UserRepository.instance.fetchUserDetails(order.value.userId);

      customer.value = user;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      loading.value = false;
    }
  }
}