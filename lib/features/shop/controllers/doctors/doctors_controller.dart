import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';


class DoctorsController extends GetxController {
  final firestore = FirebaseFirestore.instance;

  final doctors = [].obs;

  @override
  void onInit() {
    fetchDoctors();
    super.onInit();
  }

  Future<void> fetchDoctors() async {
    final snapshot = await firestore.collection('users').get();
    doctors.value = snapshot.docs;
  }

  List getDoctorsByStatus(String status) {
    if (status == 'pending') {
      return doctors.where((d) =>
      d['role'] == 'doctor' &&
          d['isApproved'] == false &&
          (d['isRejected'] ?? false) == false).toList();
    }

    if (status == 'approved') {
      return doctors.where((d) =>
      d['role'] == 'doctor' &&
          d['isApproved'] == true).toList();
    }

    if (status == 'rejected') {
      return doctors.where((d) =>
      d['role'] == 'doctor' &&
          (d['isRejected'] ?? false) == true).toList();
    }

    return [];
  }

  Future<void> approveDoctor(String id) async {
    await firestore.collection('users').doc(id).update({
      'isApproved': true,
      'isRejected': false,
    });
    fetchDoctors();
  }

  Future<void> rejectDoctor(String id) async {
    await firestore.collection('users').doc(id).update({
      'isApproved': false,
      'isRejected': true,
    });
    fetchDoctors();
  }
}