import 'package:adaroapp_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:adaroapp_admin_panel/features/shop/controllers/dashboard/dashboard_controller.dart';
import 'package:adaroapp_admin_panel/features/shop/controllers/product/product_images_controller.dart';
import 'package:adaroapp_admin_panel/features/shop/screens/dashboard/table/data_table.dart';
import 'package:adaroapp_admin_panel/features/shop/screens/dashboard/widgets/order_status_graph.dart';
import 'package:adaroapp_admin_panel/features/shop/screens/dashboard/widgets/weekly_sales.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../widgets/dashboard_card.dart';

class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(ProductImagesController());
    final controller = Get.put(DashboardController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading
              Text(
                'Dashboard',
                style: Theme.of(context).textTheme.headlineLarge,
              ),

              // ElevatedButton(onPressed: () => controller.selectThumbnailImage(), child: const Text('Select Single Image')),
              // const SizedBox(height: TSizes.spaceBtwSections),
              // ElevatedButton(onPressed: () => controller.selectMultipleProductImages(), child: const Text('Select Multiple Image')),
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
                        subTitle: controller.orderController.allItems.length.toString(),
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
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Graphs
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        /// Bar Graph
                        TWeeklySalesGraph(),
                        const SizedBox(height: TSizes.spaceBtwSections),

                        /// Orders
                        TRoundedContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Recent Orders',
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: TSizes.spaceBtwSections),
                              const DashboardOrderTable(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: TSizes.spaceBtwSections),

                  /// Pie Chart
                  const Expanded(child: OrderStatusPieChart()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
