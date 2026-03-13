import 'package:adaroapp_admin_panel/features/consultation/consultation_detail/consultation_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ConsultationsDesktopScreen extends StatelessWidget {
  const ConsultationsDesktopScreen({super.key});



  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(16),

      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Orders')
            .where('consultationRequested', isEqualTo: true)
            .where('prescriptionStatus', isEqualTo: 'consultation_requested')
            .snapshots(),

        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final orders = snapshot.data!.docs;

          if (orders.isEmpty) {
            return const Center(
              child: Text("No consultation requests"),
            );
          }

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {

              final order = orders[index];
              final data = order.data() as Map<String, dynamic>;
              final userId = data['userId'];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),

                child: ListTile(
                  title: Text("Order ID: ${order.id}"),
                  subtitle: Text(
                    "Total Amount: ₹${data['totalAmount']}",
                  ),


                  trailing: ElevatedButton(
                    onPressed: () {
                      Get.to(() => ConsultationDetailScreen(
                        orderId: order.id, userId: data['userId'],
                      ));
                    },
                    child: const Text("View"),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}