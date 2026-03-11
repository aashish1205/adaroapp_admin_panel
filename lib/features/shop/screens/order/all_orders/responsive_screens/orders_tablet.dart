import 'package:flutter/material.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/tables/table_header.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../table/data_table.dart';

class OrdersTabletScreen extends StatelessWidget {
  const OrdersTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: const Column(
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
                    OrderTable(),
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
