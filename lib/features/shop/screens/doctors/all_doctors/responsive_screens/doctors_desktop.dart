import 'package:adaroapp_admin_panel/features/shop/controllers/doctors/doctors_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/loaders/loader_animation.dart';
import '../../../../../../common/widgets/tables/table_header.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../controllers/order/order_controller.dart';
import '../../../order/all_orders/table/data_table.dart';
import '../table/doctors_table.dart';

class DoctorsDesktopScreen extends StatelessWidget {
  const DoctorsDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DoctorsController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// 🔹 Breadcrumb
              TBreadCrumbsWithHeading(
                heading: 'Doctors',
                breadcrumbItems: ['Doctors'],
              ),

              SizedBox(height: TSizes.spaceBtwSections),

              /// 🔥 FILTER DROPDOWN (OUTSIDE TABLE)
              Obx(() => SizedBox(
                width: 240,
                child: DropdownButtonFormField<String>(
                  value: controller.selectedStatus.value,
                  decoration: const InputDecoration(
                    labelText: 'Filter Doctors',

                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.filter_list),
                    isDense: true,
                  ),
                  items: [
                    _dropdownItem("All Doctors", "all", controller.allDoctorsCount, Colors.blue),
                    _dropdownItem("Pending", "pending", controller.pendingCount, Colors.orange),
                    _dropdownItem("Approved", "approved", controller.approvedCount, Colors.green),
                    _dropdownItem("Rejected", "rejected", controller.rejectedCount, Colors.red),
                  ],
                  onChanged: (value) {
                    if (value != null) controller.selectedStatus.value = value;
                  },
                ),
              )),

              SizedBox(height: TSizes.spaceBtwSections),

              /// 🔹 Table Container
              TRoundedContainer(
                child: Column(
                  children: [

                    /// 🔹 Table Header (ONLY search now)
                    TTableHeader(
                      showLeftWidget: false,
                      searchController: controller.searchTextController,
                      searchOnChanged: controller.searchQuery,
                    ),

                    const SizedBox(height: TSizes.spaceBtwItems),

                    /// 🔥 Table
                    Obx(() {
                      if (controller.isLoading.value) {
                        return const TLoaderAnimation();
                      }

                      return const DoctorsTable();
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> _dropdownItem(
      String title, String value, int count, Color color) {
    return DropdownMenuItem(
      value: value,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              count.toString(),
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
