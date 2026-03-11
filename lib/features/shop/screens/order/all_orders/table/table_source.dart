import 'package:adaroapp_admin_panel/features/shop/controllers/dashboard/dashboard_controller.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/icons/table_action_icon_buttons.dart';
import '../../../../../../models/order_model.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';

class OrderRows extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    final order = DashboardController.orders[index];

    return DataRow2(
      onTap: () => Get.toNamed(TRoutes.orderDetails, arguments: order),
      selected: false,
      onSelectChanged: (value) {},
      cells: [
        DataCell(
          Text(
            order.id,
            style: Theme.of(
              Get.context!,
            ).textTheme.bodyLarge!.apply(color: TColors.primary),
          ), // Text
        ), // DataCell
        DataCell(Text(order.formattedOrderDate)),
        DataCell(Text('${order.items.length} Items')),
        DataCell(
          TRoundedContainer(
            radius: TSizes.cardRadiusSm,
            padding: const EdgeInsets.symmetric(
              vertical: TSizes.sm,
              horizontal: TSizes.md,
            ),
            backgroundColor: THelperFunctions.getOrderStatusColor(
              order.status,
            ).withOpacity(0.1),
            child: Text(
              order.status.name.capitalize.toString(),
              style: TextStyle(
                color: THelperFunctions.getOrderStatusColor(order.status),
              ),
            ), // Text
          ), // TRoundedContainer
        ), // DataCell
        DataCell(Text('\$${order.totalAmount}')),
        DataCell(
          TTableActionButtons(
            view: true,
            edit: false,
            onViewPressed: () =>
                Get.toNamed(TRoutes.orderDetails, arguments: order, parameters: {'orderId' : order.id}),
            onDeletePressed: () {},
          ), // TTableActionButtons
        ), // DataCell
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => DashboardController.orders.length;

  @override
  int get selectedRowCount => 0;
}
