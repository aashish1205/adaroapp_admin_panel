import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';

class PrescriptionPdfService {

  static Future<Uint8List> generatePrescription({
    required String patientName,
    required String symptoms,
    required List medicines,
  }) async {

    final pdf = pw.Document();

    final logo = pw.MemoryImage(
      (await rootBundle.load("assets/logos/adaro-logo-black.png")).buffer.asUint8List(),
    );

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {

          return pw.Stack(
            children: [

              /// WATERMARK
              pw.Center(
                child: pw.Opacity(
                  opacity: 0.05,
                  child: pw.Image(
                    logo,
                    width: 300,
                  ),
                ),
              ),

              /// MAIN CONTENT
              pw.Container(
                padding: const pw.EdgeInsets.all(20),

                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [

                    /// HEADER STRIP
                    pw.Container(
                      padding: const pw.EdgeInsets.all(10),
                      color: PdfColors.red300,

                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [

                          pw.Row(
                            children: [

                              pw.Container(
                                height: 40,
                                width: 40,
                                child: pw.Image(logo),
                              ),

                              pw.SizedBox(width: 10),

                              pw.Text(
                                "Adaro Healthcare",
                                style: pw.TextStyle(
                                  fontSize: 18,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColors.white,
                                ),
                              ),

                            ],
                          ),

                          pw.Text(
                            "Digital Prescription",
                            style: pw.TextStyle(
                              color: PdfColors.white,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),

                        ],
                      ),
                    ),

                    pw.SizedBox(height: 20),

                    /// PATIENT INFORMATION BOX
                    pw.Container(
                      padding: const pw.EdgeInsets.all(12),
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(color: PdfColors.grey),
                        borderRadius: pw.BorderRadius.circular(6),
                      ),

                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [

                          pw.Text(
                            "Patient Information",
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),

                          pw.SizedBox(height: 8),

                          pw.Text("Patient Name: $patientName"),
                          pw.Text("Symptoms: $symptoms"),

                        ],
                      ),
                    ),

                    pw.SizedBox(height: 25),

                    /// MEDICINE TITLE
                    pw.Text(
                      "Prescribed Medicines",
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),

                    pw.SizedBox(height: 10),

                    /// MEDICINE TABLE
                    pw.Table(
                      border: pw.TableBorder.all(color: PdfColors.grey),

                      children: [

                        /// HEADER
                        pw.TableRow(
                          decoration: const pw.BoxDecoration(
                            color: PdfColors.red100,
                          ),
                          children: [

                            _tableCell("Medicine"),
                            _tableCell("Dosage"),
                            _tableCell("Frequency"),
                            _tableCell("Duration"),

                          ],
                        ),

                        /// MEDICINE ROWS
                        ...medicines.map((med){

                          return pw.TableRow(
                            children: [

                              _tableCell(med["name"]),
                              _tableCell(med["dosage"]),
                              _tableCell(med["frequency"]),
                              _tableCell(med["duration"]),

                            ],
                          );

                        }).toList()

                      ],
                    ),

                    pw.Spacer(),

                    /// FOOTER
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [

                        pw.Text(
                          "Date: ${DateTime.now().toString().split(" ")[0]}",
                        ),

                        pw.Column(
                          children: [

                            pw.Container(
                              width: 120,
                              height: 1,
                              color: PdfColors.black,
                            ),

                            pw.SizedBox(height: 4),

                            pw.Text(
                              "Doctor Signature",
                              style: const pw.TextStyle(fontSize: 10),
                            ),

                          ],
                        )

                      ],
                    )

                  ],
                ),
              )

            ],
          );
        },
      ),
    );

    return pdf.save();
  }

}

pw.Widget _tableCell(String text) {

  return pw.Padding(
    padding: const pw.EdgeInsets.all(8),

    child: pw.Text(
      text ?? "",
      style: const pw.TextStyle(fontSize: 10),
    ),
  );

}