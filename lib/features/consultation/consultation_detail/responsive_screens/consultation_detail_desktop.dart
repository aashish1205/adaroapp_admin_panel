import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../services/consultation_services.dart';
import '../../services/prescription_pdf_service.dart';

class ConsultationDetailDesktopScreen extends StatelessWidget {
  const ConsultationDetailDesktopScreen({super.key, required this.orderId, required this.userId});

  final String orderId;


  final String  userId;



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
            padding: const EdgeInsets.all(24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// LEFT SIDE → PATIENT PANEL
                Expanded(
                  flex: 2,
                  child: PatientProfileCard(
                    data: data,
                    orderId: orderId,
                  ),
                ),

                const SizedBox(width: 24),

                /// RIGHT SIDE → CONSULTATION PANEL
                Expanded(
                  flex: 3,
                  child: DoctorConsultationPanel(
                    orderId: orderId,
                    userId: userId,
                    data: data,
                  ),
                ),

              ],
            ),
          );
        },
      ),
    );
  }


}


class PatientProfileCard extends StatelessWidget {

  final Map<String,dynamic> data;
  final String orderId;

  const PatientProfileCard({
    super.key,
    required this.data,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),

      child: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Patient Profile",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            _profileTile(Icons.person, "Name", data['Name']),
            _profileTile(Icons.phone, "Phone", data['PhoneNumber']),
            _profileTile(Icons.receipt, "Order ID", orderId),
            _profileTile(Icons.currency_rupee, "Amount", "₹${data['totalAmount']}"),

          ],
        ),
      ),
    );
  }

  Widget _profileTile(IconData icon,String title,String value){

    return ListTile(
      leading: Icon(icon,color: Colors.blue),
      title: Text(value),
      subtitle: Text(title),
    );

  }
}

class DoctorConsultationPanel extends StatefulWidget {

  final String orderId;
  final String userId;
  final Map<String,dynamic> data;

  const DoctorConsultationPanel({
    super.key,
    required this.orderId,
    required this.userId,
    required this.data,
  });

  @override
  State<DoctorConsultationPanel> createState() => _DoctorConsultationPanelState();
}

class _DoctorConsultationPanelState extends State<DoctorConsultationPanel> {

  List<Map<String, String>> medicines = [];

  final symptomsController = TextEditingController();
  final allergyController = TextEditingController();
  final historyController = TextEditingController();

  void addMedicine() {
    setState(() {
      medicines.add({
        "name": "",
        "dosage": "",
        "frequency": "",
        "duration": ""
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),

      child: Padding(
        padding: const EdgeInsets.all(24),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                "Consultation",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              consultationButtons(),

              const SizedBox(height: 30),

              medicalForm(),

              const SizedBox(height: 30),

              prescriptionBuilder(),

            ],
          ),
        ),
      ),
    );
  }

  Widget consultationButtons() {
    return Row(
      children: [

        Expanded(
          child: ElevatedButton.icon(
            icon: const Icon(Icons.call),
            label: const Text("Call Patient"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Calling Patient...")),
              );
            },
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: ElevatedButton.icon(
            icon: const Icon(Icons.check_circle),
            label: const Text("Accept Consultation"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: acceptConsultation,
          ),
        ),

      ],
    );
  }

  void acceptConsultation() async {
    final firestore = FirebaseFirestore.instance;

    WriteBatch batch = firestore.batch();

    final globalOrder =
    firestore.collection("Orders").doc(widget.orderId);

    final userOrder =
    firestore
        .collection("Users")
        .doc(widget.userId)
        .collection("Orders")
        .doc(widget.orderId);

    batch.update(globalOrder, {
      "prescriptionStatus": "doctor_assigned",
      "doctorAssigned": true,
      "doctorAssignedAt": FieldValue.serverTimestamp(),
    });

    batch.update(userOrder, {
      "prescriptionStatus": "doctor_assigned",
      "doctorAssigned": true,
      "doctorAssignedAt": FieldValue.serverTimestamp(),
    });

    await batch.commit();

    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text("Consultation Accepted"),
          content: Text(
              "You can now contact the patient and create a prescription."
          ),
        );
      },
    );
  }


  Widget medicalForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "Medical Information",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 16),

        TextField(
          controller: symptomsController,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: "Symptoms",
            border: OutlineInputBorder(),
          ),
        ),

        const SizedBox(height: 12),

        TextField(
          controller: allergyController,
          decoration: const InputDecoration(
            labelText: "Allergies",
            border: OutlineInputBorder(),
          ),
        ),

        const SizedBox(height: 12),

        TextField(
          controller: historyController,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: "Medical History",
            border: OutlineInputBorder(),
          ),
        ),

      ],
    );
  }


  Widget prescriptionBuilder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "Prescription",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 16),

        ListView.builder(
          shrinkWrap: true,
          itemCount: medicines.length,
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(12),

                child:Row(
                  children: [

                    Expanded(
                      flex: 3,
                      child: _medicineField("Medicine"),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      flex: 2,
                      child: _medicineField("Dosage"),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      flex: 2,
                      child: _medicineField("Frequency"),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      flex: 2,
                      child: _medicineField("Duration"),
                    ),

                  ],
                )
              ),
            );
          },
        ),

        const SizedBox(height: 16),

        ElevatedButton.icon(
          icon: const Icon(Icons.add),
          label: const Text("Add Medicine"),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: addMedicine,
        ),

        const SizedBox(height: 20),

        SizedBox(
          width: double.infinity,
          height: 50,
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xffef5350),
                  Color(0xffd32f2f),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.picture_as_pdf),
              label: const Text(
                "Generate Prescription",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
                onPressed: () async {

                  try {

                    print("STEP 1 → GENERATING PDF");

                    final pdfBytes = await PrescriptionPdfService.generatePrescription(
                      patientName: widget.data['Name'],
                      symptoms: symptomsController.text,
                      medicines: medicines,
                    );

                    print("STEP 2 → PDF GENERATED");

                    final url = await ConsultationService.uploadPrescription(
                      pdfBytes,
                      widget.orderId,
                    );

                    print("STEP 3 → PDF UPLOADED: $url");

                    final firestore = FirebaseFirestore.instance;

                    WriteBatch batch = firestore.batch();

                    final globalOrder =
                    firestore.collection("Orders").doc(widget.orderId);

                    final userOrder =
                    firestore
                        .collection("Users")
                        .doc(widget.userId)
                        .collection("Orders")
                        .doc(widget.orderId);

                    batch.update(globalOrder, {
                      "prescriptionUrl": url,
                      "prescriptionStatus": "completed"
                    });

                    batch.update(userOrder, {
                      "prescriptionUrl": url,
                      "prescriptionStatus": "completed"
                    });

                    print("STEP 4 → UPDATING FIRESTORE");

                    await batch.commit();

                    print("STEP 5 → FIRESTORE UPDATED");

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Prescription generated successfully"),
                      ),
                    );

                  } catch (e) {

                    print("PRESCRIPTION ERROR: $e");

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error: $e")),
                    );

                  }

                }
            ),
          ),
        )

      ],
    );
  }

  Widget _medicineField(String label) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
    );
  }
}






