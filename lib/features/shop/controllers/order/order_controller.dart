import 'package:adaroapp_admin_panel/data/repositories/order/order_repository.dart';
import 'package:adaroapp_admin_panel/features/shop/screens/banner/all_banner/table/base_data_table_controller.dart';
import 'package:adaroapp_admin_panel/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../models/order_model.dart';
import '../../../../utils/popups/loaders.dart';

class OrderController extends TBaseController<OrderModel> {
  static OrderController get instance => Get.find();

  RxBool statusLoader = false.obs;
  var orderStatus = OrderStatus.delivered.obs;
  final _orderRepository = Get.find<OrderRepository>();

  @override
  Future<List<OrderModel>> fetchItems() async {
    try {
      print("Fetching orders...");

      sortAscending.value = false;

      final orders = await _orderRepository.getAllOrders();

      print("Orders fetched: ${orders.length}");

      return orders;
    } catch (e, s) {
      print("ORDER FETCH ERROR: $e");
      print(s);
      return [];
    }
  }

  @override
  bool containsSearchQuery(OrderModel item, String query) {
    return item.id.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(OrderModel item) async {
    await _orderRepository.deleteOrder(item.docId);
  }

  void sortById(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending, (OrderModel o) => o.totalAmount.toString().toLowerCase());
  }

  void sortByDate(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending, (OrderModel o) => o.orderDate.toString().toLowerCase());
  }

  /// Update Product Status
  Future<void> updateOrderStatus(OrderModel order, OrderStatus newStatus) async {
    try {
      statusLoader.value = true;
      order.status = newStatus;
      await _orderRepository.updateOrderSpecificValue(order.docId, {'status' : newStatus.toString()});
      updateItemFromLists(order);
      orderStatus.value = newStatus;
      TLoaders.successSnackBar(title: 'Updated' , message: 'Order Status Updated');
    } catch (e) {
      TLoaders.warningSnackBar(title: 'Oh Snap',message: e.toString());
    } finally {
      statusLoader.value = false;
    }
  }


}