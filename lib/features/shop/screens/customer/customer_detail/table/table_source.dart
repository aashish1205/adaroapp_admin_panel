import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../models/order_model.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import 'package:data_table_2/data_table_2.dart';

class CustomerOrdersRows extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    final order = OrderModel(
      id: 'id',
      status: OrderStatus.shipped,
      totalAmount: 235.5,
      orderDate: DateTime.now(), items: [],
    );
    const totalAmount = '2563.5';
    return DataRow2(
      selected: false,
      onTap: () => Get.toNamed(TRoutes.orderDetails, arguments: order),
      cells: [
        DataCell(
          Text(
            order.id,
            style: Theme.of(
              Get.context!,
            ).textTheme.bodyLarge!.apply(color: TColors.primary),
          ),
        ),
        DataCell(Text(order.formattedOrderDate)),
        const DataCell(Text('${5} Items')),
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
        const DataCell(Text('\₹$totalAmount')),
      ],
    ); // DataRow2
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 5;

  @override
  int get selectedRowCount => 0;
}
