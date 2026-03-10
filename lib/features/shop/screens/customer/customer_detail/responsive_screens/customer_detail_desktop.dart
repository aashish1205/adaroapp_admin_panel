import 'package:adaroapp_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:adaroapp_admin_panel/models/user_model.dart';
import 'package:flutter/material.dart';

import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../widgets/customer_info.dart';
import '../widgets/customer_orders.dart';
import '../widgets/shipping_address.dart';

class CustomerDetailDesktopScreen extends StatelessWidget {
  const CustomerDetailDesktopScreen({super.key, required this.customer});

  final UserModel customer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              const TBreadCrumbsWithHeading(
                returnToPreviousScreen: true,
                heading: 'Aashish Gupta',
                breadcrumbItems: [TRoutes.customers, 'Details'],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Body
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left SIde Customer Information
                  Expanded(
                      child:  Column(
                        children: [
                        // Customer Info
                        CustomerInfo(customer: customer),
                        const SizedBox(height: TSizes.spaceBtwSections),

                        // SHipping Address
                        const ShippingAddress(),
                      ],
                      ),
                  ),
                  const SizedBox(width: TSizes.spaceBtwSections),

                  // Right Side Customer Orders
                  const Expanded(flex: 2, child: CustomerOrders()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
