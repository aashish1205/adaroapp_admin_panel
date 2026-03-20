import 'package:adaroapp_admin_panel/doctordashboard/authentication/register/widgets/doctor_register_form.dart';
import 'package:adaroapp_admin_panel/doctordashboard/authentication/register/widgets/doctor_register_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../common/widgets/layouts/templates/login_template.dart';
import '../../../controllers/doctor_register_controller.dart';

class DoctorRegisterDesktopTabletScreen extends StatelessWidget {
  DoctorRegisterDesktopTabletScreen({super.key});

  final controller = Get.put(DoctorRegisterController());

  @override
  Widget build(BuildContext context) {
    return const TLoginTemplate(child: Column(
      children: [
        // Header
        DoctorRegisterHeader(),

        // Form
        DoctorRegisterForm(),
      ],
    ));
  }
}