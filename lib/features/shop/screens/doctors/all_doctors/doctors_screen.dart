import 'package:adaroapp_admin_panel/features/shop/screens/doctors/all_doctors/responsive_screens/doctors_desktop.dart';
import 'package:adaroapp_admin_panel/features/shop/screens/doctors/all_doctors/responsive_screens/doctors_mobile.dart';
import 'package:adaroapp_admin_panel/features/shop/screens/doctors/all_doctors/responsive_screens/doctors_tablet.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/layouts/templates/site_layout.dart';

class DoctorsScreen extends StatelessWidget {
  const DoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TSiteTemplate(
      desktop: DoctorsDesktopScreen(),
      tablet: DoctorsTabletScreen(),
      mobile: DoctorsMobileScreen(),
    );
  }
}