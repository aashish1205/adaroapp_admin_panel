import 'package:adaroapp_admin_panel/features/shop/screens/doctors/all_doctors/widgets/doctors_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controllers/doctors/doctors_controller.dart';


class DoctorsScreen extends StatelessWidget {
  const DoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DoctorsController());

    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: "Pending"),
              Tab(text: "Approved"),
              Tab(text: "Rejected"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                DoctorsTable(status: 'pending'),
                DoctorsTable(status: 'approved'),
                DoctorsTable(status: 'rejected'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}