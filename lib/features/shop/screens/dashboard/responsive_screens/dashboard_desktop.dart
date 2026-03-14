import 'package:adaroapp_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:adaroapp_admin_panel/features/shop/controllers/dashboard/dashboard_controller.dart';
import 'package:adaroapp_admin_panel/features/shop/controllers/product/product_images_controller.dart';
import 'package:adaroapp_admin_panel/features/shop/screens/dashboard/table/data_table.dart';
import 'package:adaroapp_admin_panel/features/shop/screens/dashboard/widgets/order_status_graph.dart';
import 'package:adaroapp_admin_panel/features/shop/screens/dashboard/widgets/weekly_sales.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/sizes.dart';
import '../widgets/dashboard_card.dart';


class DashboardDesktopScreen extends StatelessWidget {
  const DashboardDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(ProductImagesController());
    //final controller = Get.put(DashboardController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading 
              Text('Dashboard', style: Theme.of(context).textTheme.headlineLarge),
             // ElevatedButton(onPressed: () => controller.selectThumbnailImage(), child: const Text('Select Single Image')),
             // const SizedBox(height: TSizes.spaceBtwSections),
             // ElevatedButton(onPressed: () => controller.selectMultipleProductImages(), child: const Text('Select Multiple Image')),


              const SizedBox(height: TSizes.spaceBtwSections),
              
              // Cards
              Row(
                children: [
                  Expanded(child: TDashboardCard(title: 'Sales total', subTitle: '₹3650.8', stats: 25)),
                  SizedBox(width: TSizes.spaceBtwItems),
                  Expanded(child: TDashboardCard(title: 'Average Order Value', subTitle: '₹364.0', stats: 15)),
                  SizedBox(width: TSizes.spaceBtwItems),
                  Expanded(child: TDashboardCard(title: 'Total Orders', subTitle: '36', stats: 44)),
                  SizedBox(width: TSizes.spaceBtwItems),
                  Expanded(child: TDashboardCard(title: 'Visitors', subTitle: '501', stats: 2)),

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
                              Text('Recent Orders', style: Theme.of(context).textTheme.headlineSmall),
                              const SizedBox(height: TSizes.spaceBtwSections),
                              //const DashboardOrderTable(),
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
              )
            ],
          ),
        ),
      ),
    );
  }


}












