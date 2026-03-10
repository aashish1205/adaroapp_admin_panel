import 'package:adaroapp_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:adaroapp_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:adaroapp_admin_panel/common/widgets/tables/table_header.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/constants/sizes.dart';
import '../table/customer_table.dart';

class CustomersDesktopScreen extends StatelessWidget {
  const CustomersDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
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
                    TTableHeader(showLeftWidget: false),
                    SizedBox(height: TSizes.spaceBtwItems),

                    // Table
                    CustomerTable(),
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
