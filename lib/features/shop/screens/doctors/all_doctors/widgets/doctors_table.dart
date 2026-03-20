import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../controllers/doctors/doctors_controller.dart';
import 'package:data_table_2/data_table_2.dart';

class DoctorsTable extends StatelessWidget {
  final String status;

  const DoctorsTable({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DoctorsController>();

    return Obx(() {
      final doctors = controller.getDoctorsByStatus(status);

      if (doctors.isEmpty) {
        return const Center(child: Text("No Doctors Found"));
      }

      return Padding(
        padding: const EdgeInsets.all(16),
        child: DataTable2(
          columnSpacing: 12,
          minWidth: 900,
          columns: const [
            DataColumn(label: Text("Name")),
            DataColumn(label: Text("Email")),
            DataColumn(label: Text("Specialization")),
            DataColumn(label: Text("Status")),
            DataColumn(label: Text("Actions")),
          ],
          rows: doctors.map<DataRow>((doc) {
            return DataRow(cells: [

              // Name
              DataCell(Text(doc['name'] ?? '')),

              // Email
              DataCell(Text(doc['email'] ?? '')),

              // Specialization
              DataCell(Text(doc['specialization'] ?? '')),

              // Status Badge
              DataCell(_statusWidget(doc)),

              // Actions
              DataCell(Row(
                children: [

                  if (status == 'pending') ...[
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      onPressed: () =>
                          controller.approveDoctor(doc.id),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () =>
                          controller.rejectDoctor(doc.id),
                    ),
                  ],

                  if (status == 'approved')
                    const Icon(Icons.verified, color: Colors.green),

                  if (status == 'rejected')
                    const Icon(Icons.block, color: Colors.red),
                ],
              )),
            ]);
          }).toList(),
        ),
      );
    });
  }

  Widget _statusWidget(dynamic doc) {
    if (doc['isApproved'] == true) {
      return const Text("Approved", style: TextStyle(color: Colors.green));
    }
    if ((doc['isRejected'] ?? false) == true) {
      return const Text("Rejected", style: TextStyle(color: Colors.red));
    }
    return const Text("Pending", style: TextStyle(color: Colors.orange));
  }
}