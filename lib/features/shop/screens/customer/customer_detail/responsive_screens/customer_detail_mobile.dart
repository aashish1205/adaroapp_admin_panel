import 'package:flutter/material.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../models/user_model.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../widgets/customer_info.dart';
import '../widgets/customer_orders.dart';
import '../widgets/shipping_address.dart';

class CustomerDetailMobileScreen extends StatelessWidget {
  const CustomerDetailMobileScreen({super.key, required this.customer});

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
              TBreadCrumbsWithHeading(
                returnToPreviousScreen: true,
                heading: customer.fullName,
                breadcrumbItems: const [TRoutes.customers, 'Details'],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Body


                  // Customer Info
                  CustomerInfo(customer: customer),
                  const SizedBox(height: TSizes.spaceBtwSections),

              // SHipping Address
              const ShippingAddress(),
              const SizedBox(width: TSizes.spaceBtwSections),

              // Right Side Customer Orders
              const CustomerOrders()
            ],
          ),
        ),
      ),
    );
  }
}
