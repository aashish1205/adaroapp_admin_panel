import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorsController extends GetxController {
  final firestore = FirebaseFirestore.instance;

  /// All doctors
  final doctors = [].obs;

  /// 🔥 Selected Filter
  final selectedStatus = 'pending'.obs;

  /// 🔍 Search
  final searchText = ''.obs;
  final searchTextController = TextEditingController();

  /// ⏳ Loading
  final isLoading = false.obs;

  @override
  void onInit() {
    fetchDoctors();
    super.onInit();
  }

  /// Fetch all doctors
  Future<void> fetchDoctors() async {
    try {
      isLoading.value = true;

      final snapshot = await firestore.collection('users').get();
      doctors.value = snapshot.docs;

    } catch (e) {
      print("Error fetching doctors: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// 🔥 Filter + Search combined
  List get filteredDoctors {
    return doctors.where((d) {
      final isDoctor = d['role'] == 'doctor';

      final isPending =
          d['isApproved'] == false && (d['isRejected'] ?? false) == false;

      final isApproved = d['isApproved'] == true;

      final isRejected = (d['isRejected'] ?? false) == true;

      /// ✅ HANDLE STATUS
      bool statusMatch = switch (selectedStatus.value) {
        'all' => true,
        'pending' => isPending,
        'approved' => isApproved,
        'rejected' => isRejected,
        _ => false,
      };

      /// 🔍 Search filter
      final query = searchText.value.toLowerCase();

      final matchesSearch =
          (d['name'] ?? '').toString().toLowerCase().contains(query) ||
              (d['email'] ?? '').toString().toLowerCase().contains(query);

      return isDoctor && statusMatch && matchesSearch;
    }).toList();
  }

  /// 🔍 Search handler
  void searchQuery(String query) {
    searchText.value = query;
  }

  int get pendingCount => doctors.where((d) =>
  d['role'] == 'doctor' &&
      d['isApproved'] == false &&
      (d['isRejected'] ?? false) == false).length;

  int get approvedCount => doctors.where((d) =>
  d['role'] == 'doctor' &&
      d['isApproved'] == true).length;

  int get rejectedCount => doctors.where((d) =>
  d['role'] == 'doctor' &&
      (d['isRejected'] ?? false) == true).length;

  int get allDoctorsCount =>
      doctors.where((d) => d['role'] == 'doctor').length;

  /// ✅ Approve doctor
  Future<void> approveDoctor(String id) async {
    await firestore.collection('users').doc(id).update({
      'isApproved': true,
      'isRejected': false,
    });

    /// Update locally (no refetch)
    final index = doctors.indexWhere((d) => d.id == id);
    if (index != -1) {
      doctors[index]['isApproved'] = true;
      doctors[index]['isRejected'] = false;
      doctors.refresh();
    }
  }

  /// ❌ Reject doctor
  Future<void> rejectDoctor(String id) async {
    await firestore.collection('users').doc(id).update({
      'isApproved': false,
      'isRejected': true,
    });

    final index = doctors.indexWhere((d) => d.id == id);
    if (index != -1) {
      doctors[index]['isApproved'] = false;
      doctors[index]['isRejected'] = true;
      doctors.refresh();
    }
  }
}