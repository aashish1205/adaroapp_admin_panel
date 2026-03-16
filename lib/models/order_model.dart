import 'package:adaroapp_admin_panel/utils/helpers/helper_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../utils/constants/enums.dart';
import '../features/personalization/models/address_model.dart';
import 'cart_item_model.dart';

class OrderModel {
  final String id;
  final String docId;
  final String userId;
  OrderStatus status;
  final double totalAmount;
  final double shippingCost;
  final double taxCost;
  final DateTime orderDate;
  final String paymentMethod;
  final AddressModel? shippingAddress;
  final AddressModel? billingAddress;
  final DateTime? deliveryDate;
  final List<CartItemModel> items;
  final bool billingAddressSameAsShipping;

  OrderModel({
    required this.id,
    this.userId = '',
    this.docId = '',
    required this.status,
    required this.items,
    required this.totalAmount,
    required this.shippingCost,
    required this.taxCost,
    required this.orderDate,
    this.paymentMethod = 'Cash on Delivery',
    this.billingAddress,
    this.shippingAddress,
    this.deliveryDate,
    this.billingAddressSameAsShipping = true,
  });

  String get formattedOrderDate => THelperFunctions.getFormattedDate(orderDate);


  String get formattedDeliveryDate =>
      deliveryDate != null
          ? THelperFunctions.getFormattedDate(deliveryDate!)
          : '';

  String get orderStatusText =>
      status == OrderStatus.delivered
          ? 'Delivered'
          : status == OrderStatus.shipped
          ? 'Shipment on the way'
          : 'Processing';

  /// Empty model
  static OrderModel empty() =>
      OrderModel(
        id: '',
        status: OrderStatus.pending,
        totalAmount: 0,
        shippingCost: 0,
        taxCost: 0,
        orderDate: DateTime.now(),
        items: [], // ✅ empty list
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status.toString(),
      'totalAmount': totalAmount,
      'shippingCost': shippingCost,
      'taxCost': taxCost,
      'orderDate': orderDate,
      'paymentMethod': paymentMethod,
      'billingAddress': billingAddress?.toJson(),
      'shippingAddress': shippingAddress?.toJson(),
      'deliveryDate': deliveryDate,
      'billingAddressSameAsShipping': billingAddressSameAsShipping,
      'items': items.map((item) => item.toJson()).toList(), // ✅ include items
    };
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return OrderModel(
      docId: snapshot.id,
      id: data['id'] ?? '',
      userId: data['userId'] ?? '',



      status: data.containsKey('status')
          ? OrderStatus.values.firstWhere(
            (e) => e.name == data['status'],
        orElse: () => OrderStatus.pending,
      )
          : OrderStatus.pending,

      totalAmount: data.containsKey('totalAmount')
          ? (data['totalAmount'] as num).toDouble()
          : 0.0,

      shippingCost: data.containsKey('shippingCost')
          ? (data['shippingCost'] as num).toDouble()
          : 0.0,

      taxCost: data.containsKey('taxCost')
          ? (data['taxCost'] as num).toDouble()
          : 0.0,

      orderDate: data.containsKey('orderDate')
          ? (data['orderDate'] as Timestamp).toDate()
          : DateTime.now(),

      paymentMethod: data['paymentMethod'] ?? '',

      deliveryDate: data['deliveryDate'] != null
          ? (data['deliveryDate'] as Timestamp).toDate()
          : null,

      shippingAddress: data.containsKey('Name')
          ? AddressModel(
        id: data['Id'] ?? '',
        name: data['Name'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        street: data['Street'] ?? '',
        city: data['City'] ?? '',
        state: data['State'] ?? '',
        postalCode: data['PostalCode'] ?? '',
        country: data['Country'] ?? '',
        selectedAddress: data['SelectedAddress'] ?? false,
      )
          : null,

      billingAddress: null,

      items: data.containsKey('items')
          ? (data['items'] as List)
          .map((item) {
        try {
          return CartItemModel.fromJson(item);
        } catch (e) {
          debugPrint("Cart item parse error: $e");
          return CartItemModel.empty();
        }
      }).toList()
          : [],
    );
  }
}


