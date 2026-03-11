import 'package:adaroapp_admin_panel/features/shop/screens/order/orders_detail/widgets/order_items.dart';
import 'package:flutter/material.dart';

import '../../../../../../common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import '../../../../../../models/order_model.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../widgets/order_customer.dart';
import '../widgets/order_info.dart';
import '../widgets/order_transaction.dart';

class OrderDetailMobileScreen extends StatelessWidget {
  const OrderDetailMobileScreen({super.key,required this.order});

  final OrderModel order;

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
                heading: order.id,
                breadcrumbItems: [TRoutes.orders,'Details'],
              ),
              SizedBox(height: TSizes.spaceBtwSections),

              // Body
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left side Order Information
                  Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          // Order Info
                          OrderInfo(order: order),
                          const SizedBox(height: TSizes.spaceBtwSections),

                          // Items
                          OrderItems(order: order),
                          const SizedBox(height: TSizes.spaceBtwSections),

                          // Transactions
                          OrderTransaction(order: order),
                        ],
                      )
                  ),
                  const SizedBox(width: TSizes.spaceBtwSections),

                  // Right Side Order Orders
                  Expanded(child: Column(
                    children: [
                      // Customer Info
                      OrderCustomer(order: order),
                      const SizedBox(height: TSizes.spaceBtwSections),
                    ],
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
