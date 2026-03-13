import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;

class PrescriptionPdfService {

  static Future<Uint8List> generatePrescription({

    required String patientName,
    required String symptoms,
    required List medicines,

  }) async {

    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) {

          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [

              pw.Text(
                "Medical Prescription",
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 20),

              pw.Text("Patient Name: $patientName"),
              pw.Text("Symptoms: $symptoms"),

              pw.SizedBox(height: 20),

              pw.Text(
                "Medicines",
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 10),

              ...medicines.map((med){

                return pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [

                    pw.Text(med["name"]),
                    pw.Text(med["dosage"]),
                    pw.Text(med["frequency"]),
                    pw.Text(med["duration"]),

                  ],
                );

              }).toList(),

            ],
          );

        },
      ),
    );

    return pdf.save(); // returns Uint8List instead of File
  }

}