import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../data/repositories/user/user_repository.dart';
import '../../../../models/user_model.dart';
import '../../screens/banner/all_banner/table/base_data_table_controller.dart';

class CustomerController extends TBaseController<UserModel> {
  static CustomerController get instance => Get.find();
  final _customerRepository = Get.put(UserRepository());

  @override
  Future<List<UserModel>> fetchItems() async {
    return await _customerRepository.getAllUsers();
  }

  void sortByName(int sortColumnIndex, bool ascending) {
    sortByProperty(sortColumnIndex, ascending, (UserModel o) => o.fullName.toString().toLowerCase());
  }

  @override
  bool containsSearchQuery (UserModel item, String query) {
    return item.fullName.toLowerCase().contains(query.toLowerCase());
  }

  @override
  Future<void> deleteItem(UserModel item) async {
    await _customerRepository.deleteUser(item.id ?? '');
  }


}