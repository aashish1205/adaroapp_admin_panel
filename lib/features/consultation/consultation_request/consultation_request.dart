
import 'package:adaroapp_admin_panel/features/consultation/consultation_request/responsive_screens/consultation_desktop.dart';
import 'package:adaroapp_admin_panel/features/consultation/consultation_request/responsive_screens/consultation_mobile.dart';
import 'package:adaroapp_admin_panel/features/consultation/consultation_request/responsive_screens/consultation_tablet.dart';
import 'package:flutter/material.dart';
import 'package:adaroapp_admin_panel/common/widgets/layouts/templates/site_layout.dart';


class ConsultationRequestsScreen extends StatelessWidget {
  const ConsultationRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: ConsultationsDesktopScreen(),
      tablet: ConsultationsTabletScreen(),
      mobile: ConsultationsMobileScreen(),
    );
  }
}