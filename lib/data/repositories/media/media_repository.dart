
import 'dart:io';


import 'package:adaroapp_admin_panel/models/image_model.dart';
import 'package:adaroapp_admin_panel/utils/constants/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MediaRepository extends GetxController {
  static MediaRepository get instance => Get.find();

  // Firebase Storage instance
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Upload any Image using any File
  Future<ImageModel> uploadImageFileInStorage({
    required Uint8List bytes,
    required String path,
    required String imageName,
  }) async {
    try {
      print("Uploading image to storage..."); // Extra Comments
      final Reference ref =
      _storage.ref('$path/${DateTime.now().millisecondsSinceEpoch}_$imageName');

      await ref.putData(bytes, SettableMetadata(contentType: 'image/jpeg'),); // Edited Line on 26-02-2026
      print("Upload success");  // Extra Comments

      final String downloadURL = await ref.getDownloadURL();
      print("Download URL: $downloadURL");
      final FullMetadata metadata = await ref.getMetadata();

      return ImageModel.fromFirebaseMetaData(
        metadata,
        path,
        imageName,
        downloadURL,
      );
    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      print("STORAGE ERROR: $e"); // Extra Comments
      throw e.toString();
    }
  }

  /// Upload Image data in firestore
  Future<String> uploadImageFileInDatabase(ImageModel image) async {
    try {
      print("Saving image to Firestore...");
      final data = await FirebaseFirestore.instance.collection('Images').add(image.toJson());
      print("Saved in Firestore: ${data.id}");
      return data.id;

    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      print("FIRESTORE ERROR: $e");
      throw e.toString();
    }
  }

  /// Fetch Images From the Firestore based on media category and load count
  Future<List<ImageModel>> fetchImagesFromDatabase(MediaCategory mediaCategory, int loadCount) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Images')
          .where('mediaCategory', isEqualTo: mediaCategory.name)

          .limit(loadCount)
          .get();

      return querySnapshot.docs.map((e) => ImageModel.fromSnapshot(e)).toList();

    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<ImageModel>> loadMoreImagesFromDatabase(MediaCategory mediaCategory, int loadCount, DateTime lastFetchedDate) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Images')
          .where('mediaCategory', isEqualTo: mediaCategory.name.toString())
          .orderBy('createdAt' , descending: true)
          .startAfter([lastFetchedDate])
          .limit(loadCount)
          .get();

      return querySnapshot.docs.map((e) => ImageModel.fromSnapshot(e)).toList();


    } on FirebaseException catch (e) {
      throw e.message!;
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }

  // Delete file from firebase storage and corresponding document from firestore
  Future<void> deleteFileFromStorage(ImageModel image) async {
    try {
      await FirebaseStorage.instance.ref(image.fullPath).delete();
      await FirebaseFirestore.instance.collection('Images').doc(image.id).delete();

    } on FirebaseException catch (e) {
      throw e.message ?? 'Something went wrong while deleting image.';
    } on SocketException catch (e) {
      throw e.message;
    } on PlatformException catch (e) {
      throw e.message!;
    } catch (e) {
      throw e.toString();
    }
  }
}