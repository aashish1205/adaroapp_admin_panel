import 'package:adaroapp_admin_panel/doctordashboard/authentication/register/responsive_screens/doctor_register_desktop.dart';
import 'package:adaroapp_admin_panel/doctordashboard/authentication/register/responsive_screens/doctor_register_mobile.dart';
import 'package:adaroapp_admin_panel/doctordashboard/authentication/register/widgets/doctor_register_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../common/widgets/layouts/templates/site_layout.dart';
import '../../controllers/doctor_register_controller.dart';

class DoctorRegisterScreen extends StatelessWidget {
  DoctorRegisterScreen({super.key});

  final controller = Get.put(DoctorRegisterController());

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(useLayout: false, desktop: DoctorRegisterDesktopTabletScreen(),mobile: DoctorRegisterMobileScreen(),);
  }
}