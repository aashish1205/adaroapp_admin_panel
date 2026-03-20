import 'package:adaroapp_admin_panel/doctordashboard/authentication/login/widgets/doctor_login_form.dart';
import 'package:adaroapp_admin_panel/doctordashboard/authentication/login/widgets/doctor_login_header.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/sizes.dart';

class DoctorLoginMobileScreen extends StatelessWidget {
  const DoctorLoginMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Header
              DoctorLoginHeader(),

              // Form
              DoctorLoginForm(),
            ],


          ),
        ),
      ),
    );
  }
}
