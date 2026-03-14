import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../models/order_model.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';

class OrderRepository extends GetxController {
  // Singleton instance of the OrderRepository
  static OrderRepository get instance => Get.find();

  // Firebase Firestore instance
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /*-----------------Functions-------------------*/

  // Get all orders related to the current user
  Future<List<OrderModel>> getAllOrders () async {
    try {
      final result = await _db.collection('Orders').get();
      print("Docs found: ${result.docs.length}");
      return result.docs
          .map((doc) => OrderModel.fromSnapshot(doc))
          .toList();    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      debugPrint("ORDER REPOSITORY ERROR: $e");
      rethrow;
    }
  }

  //Store a new user order
  Future<void> addOrder (OrderModel order) async {
    try {
      await _db.collection ('Orders').add(order.toJson());
    } on FirebaseException catch (e) {
      throw TFirebaseException (e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Update a specific value of an order instance
  Future<void> updateOrderSpecificValue(String orderId, Map<String, dynamic> data) async {
    try {
      await _db.collection ('Orders').doc (orderId).update(data);
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    }on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
// Delete an order
  Future<void> deleteOrder(String orderId) async {
    try {
      await _db.collection("Orders").doc(orderId).delete();
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

}