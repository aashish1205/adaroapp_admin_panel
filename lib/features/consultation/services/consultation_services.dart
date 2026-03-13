import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class ConsultationService {

  static Future<String> uploadPrescription(

      Uint8List pdfBytes,
      String orderId,

      ) async {

    final ref = FirebaseStorage.instance
        .ref()
        .child("prescriptions/$orderId.pdf");

    await ref.putData(pdfBytes);

    final url = await ref.getDownloadURL();

    return url;
  }
}