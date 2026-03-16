import 'package:adaroapp_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:adaroapp_admin_panel/features/shop/screens/order/orders_detail/responsive_screens/order_detail_desktop.dart';
import 'package:adaroapp_admin_panel/features/shop/screens/order/orders_detail/responsive_screens/order_detail_mobile.dart';
import 'package:adaroapp_admin_panel/features/shop/screens/order/orders_detail/responsive_screens/order_detail_tablet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../models/order_model.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final OrderModel? order = Get.arguments;
    final orderId = Get.parameters['orderId'];

    /// If page refreshes and arguments are lost
    if (order == null) {
      return const Scaffold(
        body: Center(
          child: Text('Loading order...'),
        ),
      );
    }

    return TSiteTemplate(
      desktop: OrderDetailDesktopScreen(order: order),
      tablet: OrderDetailTabletScreen(order: order),
      mobile: OrderDetailMobileScreen(order: order),
    );
  }
}
