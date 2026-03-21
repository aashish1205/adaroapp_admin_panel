import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../controllers/doctors/doctors_controller.dart';
import 'package:data_table_2/data_table_2.dart';

class DoctorsTable extends StatelessWidget {


  const DoctorsTable({super.key, });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DoctorsController>();

    return Obx(() {
      final doctors = controller.filteredDoctors;

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
                mainAxisSize: MainAxisSize.min,
                children: [

                  if (doc['isApproved'] == false && (doc['isRejected'] ?? false) == false) ...[
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      onPressed: () => controller.approveDoctor(doc.id),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () => controller.rejectDoctor(doc.id),
                    ),
                  ],

                  if (doc['isApproved'] == true)
                    const Icon(Icons.verified, color: Colors.green),

                  if ((doc['isRejected'] ?? false) == true)
                    const Icon(Icons.block, color: Colors.red),
                ],
              ))
            ]);
          }).toList(),
        ),
      );
    });
  }

  Widget _statusWidget(dynamic doc) {
    if (doc['isApproved'] == true) {
      return _buildBadge("Approved", Colors.green);
    }
    if ((doc['isRejected'] ?? false) == true) {
      return _buildBadge("Rejected", Colors.red);
    }
    return _buildBadge("Pending", Colors.orange);
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.w500),
      ),
    );
  }

  void _confirmAction(BuildContext context,
      {required String title,
        required String message,
        required VoidCallback onConfirm}) {

    Get.defaultDialog(
      title: title,
      middleText: message,
      textCancel: "Cancel",
      textConfirm: "Yes",
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
        onConfirm();
      },
    );
  }
}