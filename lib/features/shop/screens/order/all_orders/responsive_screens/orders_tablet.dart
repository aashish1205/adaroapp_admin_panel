import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/loaders/loader_animation.dart';
import '../../../../../../common/widgets/tables/table_header.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/order/order_controller.dart';
import '../table/data_table.dart';

class OrdersTabletScreen extends StatelessWidget {
  const OrdersTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OrderController.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              TBreadCrumbsWithHeading(
                heading: 'Orders',
                breadcrumbItems: ['Orders'],
              ),
              SizedBox(height: TSizes.spaceBtwSections),
              // Table Body
              TRoundedContainer(
                child: Column(
                  children: [
                    // Table Header
                    TTableHeader(showLeftWidget: false),
                    SizedBox(height: TSizes.spaceBtwItems),
                    // Table
                    Obx(() {
                      // Show Loader
                      if (controller.isLoading.value) return const TLoaderAnimation();

                      return OrderTable();
                    }),
                  ],
                ), // Column
              ), // TRoundedContainer
            ],
          ),
        ),
      ),
    );
  }
}
