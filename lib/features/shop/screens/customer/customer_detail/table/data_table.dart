import 'package:adaroapp_admin_panel/features/shop/controllers/customer/customer_detail_controller.dart';
import 'package:adaroapp_admin_panel/features/shop/screens/customer/customer_detail/table/table_source.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:get/get.dart';
import '../../../../../../common/widgets/data_table/paginated_data_table.dart';
import '../../../../../../utils/device/device_utility.dart';

class CustomerOrderTable extends StatelessWidget {
  const CustomerOrderTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CustomerDetailController.instance;
    return Obx(
      () {
        // Customers & selected Rows are Hidden just to update the UI +> Obx +=>[Product Rows]
        Visibility(visible: false, child: Text(controller.filteredCustomerOrders.length.toString()),);
        Visibility(visible: false, child: Text(controller.selectedRows.length.toString()),);

        return TPaginatedDataTable(
          minWidth: 550,
          tableHeight: 640,
          dataRowHeight: kMinInteractiveDimension,
          sortAscending: controller.sortAscending.value,
          sortColumnIndex: controller.sortColumnIndex.value,
          columns: [
            DataColumn2(label: Text('Order ID') , onSort: (columnIndex, ascending) => controller.sortById(columnIndex, ascending)),
            const DataColumn2(label: Text('Date')),
            const DataColumn2(label: Text('Items')),
            DataColumn2(
              label: const Text('Status'),
              fixedWidth: TDeviceUtils.isMobileScreen(context) ? 100 : null,
            ),
            const DataColumn2(label: Text('Amount'), numeric: true),
          ],
          source: CustomerOrdersRows(),
        );
      },
    ); // TPaginatedDataTable
  }
}
