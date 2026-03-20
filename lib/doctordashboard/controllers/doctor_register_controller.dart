import 'package:adaroapp_admin_panel/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/repositories/authentication/authentication_repository.dart';

class DoctorRegisterController extends GetxController {

  // 🔹 Controllers
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final specialization = TextEditingController();

  // 🔹 Form Key (IMPORTANT)
  final formKey = GlobalKey<FormState>();

  // 🔹 UI States
  final isLoading = false.obs;
  final hidePassword = true.obs;

  final _authRepo = AuthenticationRepository.instance;

  // 🔹 Register Doctor
  Future<void> registerDoctor() async {

    // ✅ Validate Form FIRST
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;

      await _authRepo.registerDoctor(
        name: name.text.trim(),
        email: email.text.trim(),
        password: password.text.trim(),
        specialization: specialization.text.trim(),
      );

      // ✅ Success Message
      Get.snackbar(
        "Success",
        "Registration submitted. Wait for admin approval",
      );

      // ✅ Navigate to login
      Get.offAllNamed(TRoutes.doctorLogin);

    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // 🔹 Clear Controllers (Optional but good practice)
  @override
  void onClose() {
    name.dispose();
    email.dispose();
    password.dispose();
    specialization.dispose();
    super.onClose();
  }
}