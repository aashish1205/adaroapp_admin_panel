import 'package:adaroapp_admin_panel/doctordashboard/authentication/login/widgets/doctor_login_form.dart';
import 'package:adaroapp_admin_panel/doctordashboard/authentication/login/widgets/doctor_login_header.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/layouts/templates/login_template.dart';
import '../../../../features/authentication/screens/login/widgets/login_form.dart';
import '../../../../features/authentication/screens/login/widgets/login_header.dart';

class DoctorLoginDesktopTabletScreen extends StatelessWidget {
  const DoctorLoginDesktopTabletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TLoginTemplate(child: Column(
      children: [
        // Header
        DoctorLoginHeader(),

        // Form
        DoctorLoginForm(),
      ],
    ));
  }
}
