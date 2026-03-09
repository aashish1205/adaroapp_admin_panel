import 'package:adaroapp_admin_panel/data/repositories/banners/banners_repository.dart';
import 'package:adaroapp_admin_panel/features/shop/screens/banner/all_banner/table/base_data_table_controller.dart';
import 'package:adaroapp_admin_panel/models/banner_model.dart';
import 'package:get/get.dart';

class BannerController extends TBaseController<BannerModel> {
  static BannerController get instance => Get.find();

  final _bannerRepository = Get.put(BannerRepository());

  @override
  Future<void> deleteItem(BannerModel item) async {
    await _bannerRepository.deleteBanner((item.id ?? '') as BannerModel);
  }

  @override
  Future<List<BannerModel>> fetchItems() async {
    return await _bannerRepository.getAllBanners();
  }

  /// Method for formatting a  route string.
  String formatRoute(String route) {
    if (route.isEmpty) return '';
    // Remove the leading '/'
    String formatted = route.substring(1);

    // Capitalize the first character
    formatted =  formatted[0].toUpperCase() + formatted.substring(1);

    return formatted;
  }

  @override
  bool containsSearchQuery(BannerModel item, String query) {
    return false;
  }

}