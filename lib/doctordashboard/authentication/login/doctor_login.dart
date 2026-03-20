import 'package:adaroapp_admin_panel/doctordashboard/authentication/login/responsive_screens/doctor_login_desktop.dart';
import 'package:adaroapp_admin_panel/doctordashboard/authentication/login/responsive_screens/doctor_login_mobile.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/layouts/templates/site_layout.dart';
import '../register/responsive_screens/doctor_register_desktop.dart';

class DoctorLoginScreen extends StatelessWidget {
  const DoctorLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(useLayout: false, desktop: DoctorLoginDesktopTabletScreen(),mobile: DoctorLoginMobileScreen(),);
  }
}
