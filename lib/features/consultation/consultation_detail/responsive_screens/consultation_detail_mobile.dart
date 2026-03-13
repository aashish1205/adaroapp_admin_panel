import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ConsultationDetailMobileScreen extends StatelessWidget {
  const ConsultationDetailMobileScreen({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Consultation Details"),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection("Orders")
            .doc(orderId)
            .get(),
        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text("Order ID: $orderId"),

                const SizedBox(height: 20),

                Text("Patient Name: ${data['Name']}"),

                Text("Phone: ${data['PhoneNumber']}"),

                const SizedBox(height: 20),

                Text("Total Amount: ₹${data['totalAmount']}"),

                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Accept Consultation"),
                ),

              ],
            ),
          );
        },
      ),
    );
  }
}
