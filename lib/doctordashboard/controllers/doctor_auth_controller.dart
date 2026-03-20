
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/repositories/authentication/authentication_repository.dart';


class DoctorAuthController extends GetxController {
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  final specialization = TextEditingController();

  final isLoading = false.obs;

  final _authRepo = AuthenticationRepository.instance;


}