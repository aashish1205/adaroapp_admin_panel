import 'package:adaroapp_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:adaroapp_admin_panel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:adaroapp_admin_panel/features/shop/controllers/dashboard/dashboard_controller.dart';
import 'package:adaroapp_admin_panel/utils/helpers/helper_functions.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/routes.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/order/order_controller.dart';

class OrderRows extends DataTableSource {
  final controller = OrderController.instance;

  @override
  DataRow? getRow(int index) {
    final order = DashboardController.instance.orderController.filteredItems[index];
    return DataRow2(
      onTap: () => Get.toNamed(TRoutes.orderDetails, arguments: order,),
        selected: controller.selectedRows[index],
        onSelectChanged: (value) => controller.selectedRows[index] = value ?? false,
        cells: [
      DataCell(
        Text(
          order.id,
          style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: TColors.primary),
        )
      ),
      DataCell(Text(order.formattedOrderDate)),
      DataCell(Text('${order.items.length} Items')),
      DataCell(
        TRoundedContainer(
          radius: TSizes.cardRadiusSm,
          padding: const EdgeInsets.symmetric(vertical: TSizes.xs, horizontal: TSizes.md),
          backgroundColor: THelperFunctions.getOrderStatusColor(order.status).withOpacity(0.1),
          child: Text(
            order.status.name.capitalize.toString(),
            style: TextStyle(color: THelperFunctions.getOrderStatusColor(order.status)),
          ),
        )
      ),
      DataCell(Text('₹${order.totalAmount}')),



    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.filteredItems.length;

  @override
  int get selectedRowCount => controller.selectedRows.where((selected) => selected).length;

}