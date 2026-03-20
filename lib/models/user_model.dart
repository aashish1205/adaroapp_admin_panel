import 'package:adaroapp_admin_panel/features/personalization/models/address_model.dart';
import 'package:adaroapp_admin_panel/utils/formatters/formatter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/constants/enums.dart';
import 'order_model.dart';

/// Model class representing user data
class UserModel {
  final String? id;
  String firstName;
  String lastName;
  String userName;
  String email;
  String phoneNumber;
  String profilePicture;
  AppRole role;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<OrderModel>? orders;
  List<AddressModel>? addresses;
  bool isApproved;
  String specialization;

  UserModel({
    this.id,
    required this.email,
    this.firstName = '',
    this.lastName = '',
    this.userName = '',
    this.phoneNumber = '',
    this.profilePicture = '',
    this.role = AppRole.user,
    this.createdAt,
    this.updatedAt,
    this.isApproved = true, // default for admin/users
    this.specialization = '',
  });

  /// Helper methods
  String get fullName => '$firstName $lastName';

  String get formattedDate => TFormatter.formatDate(createdAt);

  String get formattedUpdatedAtDate => TFormatter.formatDate(updatedAt);

  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  /// Static function to create an empty user model.
  static UserModel empty() => UserModel(email: '');

  /// Convert model to JSON structure data in Firebase.
  Map<String, dynamic> toJson() {
    return {
      'FirstName' : firstName,
      'LastName' : lastName,
      'UserName' : userName,
      'Email' : email,
      'PhoneNumber' : phoneNumber,
      'ProfilePicture' : profilePicture,
      'Role' : role.name.toString(),
      'CreatedAt' : createdAt,
      'UpdatedAt' : updatedAt =  DateTime.now(),

      // 🔥 NEW FIELDS
      'isApproved': isApproved,
      'specialization': specialization,
    };
  }

  /// Factory method to create a UserModel from a Firebase document snapshot.
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data.containsKey('FirstName') ? data ['FirstName'] ?? '' : '',
        lastName: data.containsKey('LastName') ? data ['LastName'] ?? '' : '',
        userName: data.containsKey('UserName') ? data ['UserName'] ?? '' : '',
        email: data.containsKey('Email') ? data['Email'] ?? '' : '',
        phoneNumber: data.containsKey('PhoneNumber') ? data ['PhoneNumber'] ?? '' : '',
        profilePicture: data.containsKey('ProfilePicture') ? data ['ProfilePicture'] ?? '' : '',
// 🔥 ROLE FIX (IMPORTANT)
        role: data.containsKey('Role')
            ? data['Role'] == 'admin'
            ? AppRole.admin
            : data['Role'] == 'doctor'
            ? AppRole.doctor
            : AppRole.user
            : AppRole.user,        createdAt: data.containsKey('CreatedAt') ? data ['CreatedAt']?.toDate() ?? DateTime.now() : DateTime.now(),
        updatedAt: data.containsKey('UpdatedAt') ? data ['UpdatedAt']?.toDate() ?? DateTime.now() : DateTime.now(),
      );
    } else {
      return empty();
    }
  }
}
