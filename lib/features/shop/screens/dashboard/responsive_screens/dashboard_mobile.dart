import 'package:flutter/material.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../utils/constants/sizes.dart';
import '../table/data_table.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/order_status_graph.dart';
import '../widgets/weekly_sales.dart';

class DashboardMobileScreen extends StatelessWidget {
  const DashboardMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            Text('Dashboard' , style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Cards
            TDashboardCard(title: 'Sales total', subTitle: '₹3650.8', stats: 25),
            const SizedBox(height: TSizes.spaceBtwItems),
            TDashboardCard(title: 'Average Order Value', subTitle: '₹364.0', stats: 15),
            const SizedBox(height: TSizes.spaceBtwItems),
            TDashboardCard(title: 'Total Orders', subTitle: '36', stats: 44),
            const SizedBox(height: TSizes.spaceBtwItems),
            TDashboardCard(title: 'Visitors', subTitle: '501', stats: 2),
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
