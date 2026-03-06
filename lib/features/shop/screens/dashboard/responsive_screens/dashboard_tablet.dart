import 'package:adaroapp_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:adaroapp_admin_panel/features/shop/screens/dashboard/widgets/order_status_graph.dart';
import 'package:adaroapp_admin_panel/features/shop/screens/dashboard/widgets/weekly_sales.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import '../table/data_table.dart';
import '../widgets/dashboard_card.dart';

class DashboardTabletScreen extends StatelessWidget {
  const DashboardTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            Text('Dashboard' , style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Cards
            Row(
              children: [
                Expanded(child: TDashboardCard(title: 'Sales total', subTitle: '₹3650.8', stats: 25)),
                SizedBox(width: TSizes.spaceBtwItems),
                Expanded(child: TDashboardCard(title: 'Average Order Value', subTitle: '₹364.0', stats: 15)),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Row(
              children: [
                Expanded(child: TDashboardCard(title: 'Total Orders', subTitle: '36', stats: 44)),
                SizedBox(width: TSizes.spaceBtwItems),
                Expanded(child: TDashboardCard(title: 'Visitors', subTitle: '501', stats: 2)),
              ],
            ),

            const SizedBox(height: TSizes.spaceBtwSections),

            /// Bar Graph
            const TWeeklySalesGraph(),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Recent Orders
            /// Orders
            TRoundedContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Recent Orders', style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  const DashboardOrderTable(),
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Pie Chart
            const OrderStatusPieChart(),
          ],
        ),),
      ),
    );
  }
}
