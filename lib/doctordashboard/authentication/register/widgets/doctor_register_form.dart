import 'package:adaroapp_admin_panel/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/validators/validation.dart';
import '../../../controllers/doctor_register_controller.dart';

class DoctorRegisterForm extends StatelessWidget {
  const DoctorRegisterForm({super.key});



  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DoctorRegisterController());
    return Form(
      key: controller.formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            /// Full Name
            TextFormField(
              controller: controller.name,
              validator: (value) => TValidator.validateEmptyText('Name', value),
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.user),
                labelText: "Full Name",
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            /// Email
            TextFormField(
              controller: controller.email,
              validator: TValidator.validateEmail,
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right), labelText: TTexts.email,
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            /// Password
            Obx(
                  () => TextFormField(
                controller: controller.password,
                validator: (value) => TValidator.validateEmptyText('Password', value),
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.password_check),
                  labelText: TTexts.password,
                  suffixIcon: IconButton(onPressed: () => controller.hidePassword.value = !controller.hidePassword.value, icon:  Icon(controller.hidePassword.value ? Iconsax.eye_slash : Iconsax.eye)),
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields ),

            TextFormField(
              controller: controller.specialization,
              validator: (value) => TValidator.validateEmptyText('Specialization', value),
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.briefcase),
                labelText: "Specialization",
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),

            /// Remember Me & Forget Password

            const SizedBox(height: TSizes.spaceBtwSections),

            /// Sign in Button
            Obx(() => SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : () {
                  if (controller.formKey.currentState!.validate()) {
                    controller.registerDoctor();
                  }
                },
                child: controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : const Text("Register"),
              ),
            )),

            TextButton(
              onPressed: () {
                Get.toNamed(TRoutes.doctorLogin);
              },
              child: const Text("Already have an account? Login"),
            )
          ],
        ),
      ),
    );
  }
}
