import 'package:adaroapp_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:adaroapp_admin_panel/common/widgets/loaders/animation_loader.dart';
import 'package:adaroapp_admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:adaroapp_admin_panel/features/media/controllers/media_controller.dart';
import 'package:adaroapp_admin_panel/features/media/screens/widgets/folder_dropdown.dart';
import 'package:adaroapp_admin_panel/features/media/screens/widgets/view_image_detail.dart';
import 'package:adaroapp_admin_panel/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../models/image_model.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';

class MediaContent extends StatelessWidget {
  const MediaContent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MediaController.instance;
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Media Image Header
          Row(
            children: [
              Text('Select Folder' , style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(width: TSizes.spaceBtwItems),
              MediaFolderDropdown(onChanged: (MediaCategory? newValue) {
                if (newValue != null) {
                  controller.selectedPath.value = newValue;
                  controller.getMediaImages();
                }
              })
            ],
          ),
          SizedBox(height: TSizes.spaceBtwSections),

          /// Show Media
          Obx(
            () {
              // Get Selected Folder Images
              List<ImageModel> images = _getSelectedFolderImages(controller);

              // Loader
              if (controller.loading.value && images.isEmpty) return const TLoaderAnimation();

              // Empty Widget
              if (images.isEmpty) return _buildEmptyAnimationWidget(context);

              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: images
                        .map((image) => GestureDetector(
                      onTap: () => Get.dialog(ImagePopup(image: image)),
                      child: SizedBox(
                        width: 140,
                        height: 180,
                        child: Column(
                          children: [
                             _buildSimpleList(image),
                            Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
                                  child: Text(image.filename, maxLines: 1, overflow: TextOverflow.ellipsis),
                                )
                            )
                          ],
                        ),
                      ),
                    )).toList(),
                  ),


                  /// Load More media Button
                  if (!controller.loading.value)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: TSizes.spaceBtwSections),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: TSizes.buttonWidth,
                          child: ElevatedButton.icon(
                            onPressed: () => controller.loadMoreMediaImages(),
                            label: const Text('Load More'),
                            icon: const Icon(Iconsax.arrow_down),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          

        ],
      ),
    );
  }

  List<ImageModel> _getSelectedFolderImages(MediaController controller) {
    List<ImageModel> images = [];
    if (controller.selectedPath.value == MediaCategory.banners) {
      images = controller.allBannerImages.where((image) => image.url.isNotEmpty).toList();
    } else if (controller.selectedPath.value == MediaCategory.brands) {
      images = controller.allBrandImages.where((image) => image.url.isNotEmpty).toList();
    } else if (controller.selectedPath.value == MediaCategory.categories) {
      images = controller.allCategoryImages.where((image) => image.url.isNotEmpty).toList();
    } else if (controller.selectedPath.value == MediaCategory.products) {
      images = controller.allProductImages.where((image) => image.url.isNotEmpty).toList();
    } else if (controller.selectedPath.value == MediaCategory.users) {
      images = controller.allUserImages.where((image) => image.url.isNotEmpty).toList();
    }
    return images;
  }

  Widget _buildEmptyAnimationWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: TSizes.lg * 3),
      child: TAnimationLoaderWidget(
        width: 300,
        height: 300,
        text: 'Select your Desired Folder',
        animation: TImages.packageAnimation,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );

  }

  Widget _buildSimpleList(ImageModel image) {
    return TRoundedImage(
      width: 140,
        height: 140,
        padding: TSizes.sm,
        image: image.url,
        imageType: ImageType.network,
      margin: TSizes.spaceBtwItems / 2,
      backgroundColor: TColors.primaryBackground,
    );
  }
}
