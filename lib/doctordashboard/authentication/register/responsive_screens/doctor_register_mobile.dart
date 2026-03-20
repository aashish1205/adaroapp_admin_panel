import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../common/widgets/layouts/templates/login_template.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../controllers/doctor_register_controller.dart';
import '../widgets/doctor_register_form.dart';
import '../widgets/doctor_register_header.dart';

class DoctorRegisterMobileScreen extends StatelessWidget {
  DoctorRegisterMobileScreen({super.key});

  final controller = Get.put(DoctorRegisterController());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Header
              DoctorRegisterHeader(),

              // Form
              DoctorRegisterForm(),
            ],


          ),
        ),
      ),
    );
  }
}
