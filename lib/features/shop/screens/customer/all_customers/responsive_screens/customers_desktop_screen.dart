import 'package:adaroapp_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:adaroapp_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:adaroapp_admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:adaroapp_admin_panel/common/widgets/tables/table_header.dart';
import 'package:adaroapp_admin_panel/features/shop/controllers/customer/customer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../../utils/constants/sizes.dart';
import '../table/customer_table.dart';

class CustomersDesktopScreen extends StatelessWidget {
  const CustomersDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              TBreadCrumbsWithHeading(heading: 'Customers', breadcrumbItems: ['Customers']),
              SizedBox(height: TSizes.spaceBtwSections),

              TRoundedContainer(
                child: Column(
                  children: [
                    // Table Header
                    TTableHeader(showLeftWidget: false,
                    searchController: controller.searchTextController,
                      searchOnChanged: (query) => controller.searchQuery(query),
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),

                    // Table
                    Obx(() {
                      // Show Loader
                      if (controller.isLoading.value) return const TLoaderAnimation();

                      return const CustomerTable();
                    }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
