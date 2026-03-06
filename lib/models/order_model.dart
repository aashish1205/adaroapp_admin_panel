import 'package:adaroapp_admin_panel/utils/helpers/helper_functions.dart';

import '../utils/constants/enums.dart';

class OrderModel {
  final String id;
  final OrderStatus status;
  final double totalAmount;
  final DateTime orderDate;
  final String paymentMethod;
  final DateTime? deliveryDate;

  final dynamic userId;

  final dynamic docId;

  const OrderModel( {
    required this.id,
    this.userId = '',
    this.docId = '',
    required this.status,
    required this.totalAmount,
    required this.orderDate,
    this.deliveryDate,
    this.paymentMethod = 'Paypal',
  });

  String get formattedOrderDate => THelperFunctions.getFormattedDate(orderDate);

  String get formattedDeliveryDate => deliveryDate != null ? THelperFunctions.getFormattedDate(deliveryDate!): '';

  String get orderStatusText => status == OrderStatus.delivered ? 'Delivered' : status == OrderStatus.shipped ? 'Shipment on the way' : 'Processing';

  /// Static function to create an empty user model;
  static OrderModel empty() => OrderModel(id: '', status: OrderStatus.pending, totalAmount: 0, orderDate: DateTime.now(), );

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'userId' : userId,
      'status': status.toString(),
      'totalAmount' : totalAmount,
      'orderDate' : orderDate,
    };
  }
}