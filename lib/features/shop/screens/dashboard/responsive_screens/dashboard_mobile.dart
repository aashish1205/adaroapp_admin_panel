import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/dashboard/dashboard_controller.dart';
import '../table/data_table.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/order_status_graph.dart';
import '../widgets/weekly_sales.dart';

class DashboardMobileScreen extends StatelessWidget {
  const DashboardMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            Text('Dashboard' , style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Cards
            Row(
              children: [
                Expanded(
                  child: Obx(
                        () => TDashboardCard(
                      headingIcon: Iconsax.note,
                      headingIconColor: Colors.blue,
                      headingIconBgColor: Colors.blue.withOpacity(0.1),
                      context: context,
                      title: 'Sales total',
                      subTitle: '\₹${controller.orderController.allItems.fold(0.0, (previousValue, element) => previousValue + element.totalAmount).toStringAsFixed(2)}',
                      stats: 25,
                    ),
                  ),
                ),
                const SizedBox(width: TSizes.spaceBtwItems),
                Expanded(
                  child: Obx(
                        () => TDashboardCard(
                      headingIcon: Iconsax.external_drive,
                      headingIconColor: Colors.green,
                      headingIconBgColor: Colors.green.withOpacity(0.1),
                      context: context,
                      title: 'Average Order Value',
                      subTitle: '\₹${(controller.orderController.allItems.fold(0.0, (previousValue, element) => previousValue + element.totalAmount) / controller.orderController.allItems.length).toStringAsFixed(2)}',
                      stats: 15,
                    ),
                  ),
                ),
                SizedBox(width: TSizes.spaceBtwItems),

                Expanded(
                  child: Obx(
                        () => TDashboardCard(
                      headingIcon: Iconsax.box,
                      headingIconColor: Colors.deepPurple,
                      headingIconBgColor: Colors.deepPurple.withOpacity(0.1),
                      context: context,
                      title: 'Total Orders',
                      subTitle: '\₹${controller.orderController.allItems.length}',
                      stats: 44,
                    ),
                  ),
                ),
                SizedBox(width: TSizes.spaceBtwItems),
                Expanded(
                  child: Obx(
                        () => TDashboardCard(
                      headingIcon: Iconsax.user,
                      headingIconColor: Colors.deepOrange,
                      headingIconBgColor: Colors.deepOrange.withOpacity(0.1),
                      context: context,
                      title: 'Visitors',
                      subTitle: controller.customerController.allItems.length.toString(),
                      stats: 2,
                    ),
                  ),
                ),
              ],
            ),


            /// Bar Graph
            const TWeeklySalesGraph(),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Recent Orders
            /// Orders
            TRoundedContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Recent Orders', style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const DashboardOrderTable(),
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Pie Chart
            const OrderStatusPieChart(),

          ],
        ),),
      ),
    );
  }
}
