import 'package:adaroapp_admin_panel/data/repositories/banners/banners_repository.dart';
import 'package:adaroapp_admin_panel/features/media/controllers/media_controller.dart';
import 'package:adaroapp_admin_panel/features/shop/controllers/banner/banner_controller.dart';
import 'package:adaroapp_admin_panel/models/banner_model.dart';
import 'package:adaroapp_admin_panel/utils/helpers/network_manager.dart';
import 'package:adaroapp_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:adaroapp_admin_panel/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../models/image_model.dart';
import '../../../../routes/app_screens.dart';

class CreateBannerController extends GetxController {
  static CreateBannerController get instance => Get.find();

  final imageURL = ''.obs;
  final loading = false.obs;
  final isActive = false.obs;
  final RxString targetScreen = AppScreens.allAppScreenItems[0].obs;
  final formKey = GlobalKey<FormState>();

  /// Pick Thumbanil Image From Media
  void pickImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    // Handle the selected Images
    if (selectedImages != null && selectedImages.isNotEmpty) {
      // Set the selected image to the main image or perform any other action
      ImageModel selectedImage = selectedImages.first;

      // Update the main image using the selectedImage
      imageURL.value = selectedImage.url;
    }
  }

  /// Register new Banner
  Future<void> createBanner() async {
    try {
      // Start Loading
      TFullScreenLoader.popUpCircular();
      
      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      
      // Form Validation
      if (!formKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      
      // Map Data
      final newRecord = BannerModel(
          id: '',
          imageUrl: imageURL.value,
          targetScreen: targetScreen.value,
          active: isActive.value
      );

      // Call Repository to Create New Banner and Update Id
      newRecord.id = await BannerRepository.instance.createBanner(newRecord);

      // Update ALl data list
      BannerController.instance.addItemToLists(newRecord);

      // Remove Loader
      TFullScreenLoader.stopLoading();

      // Success Message & Redirect
      TLoaders.successSnackBar(title: 'Congratulations', message: 'New Record has been added.');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap' , message: e.toString());
    }
  }
}