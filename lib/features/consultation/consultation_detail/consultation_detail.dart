import 'package:adaroapp_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:adaroapp_admin_panel/features/consultation/consultation_detail/responsive_screens/consultation_detail_desktop.dart';
import 'package:adaroapp_admin_panel/features/consultation/consultation_detail/responsive_screens/consultation_detail_mobile.dart';
import 'package:adaroapp_admin_panel/features/consultation/consultation_detail/responsive_screens/consultation_detail_tablet.dart';
import 'package:flutter/material.dart';

class ConsultationDetailScreen extends StatelessWidget {
  const ConsultationDetailScreen({super.key, required this.orderId, required this.userId});

  final String orderId;

  final String userId;

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      desktop: ConsultationDetailDesktopScreen(orderId: orderId, userId: userId),
      tablet: ConsultationDetailTabletScreen(orderId: orderId),
      mobile: ConsultationDetailMobileScreen(orderId: orderId),
    );
  }
}
