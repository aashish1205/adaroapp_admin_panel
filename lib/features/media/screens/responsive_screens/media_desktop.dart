import 'package:adaroapp_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:adaroapp_admin_panel/features/media/controllers/media_controller.dart';
import 'package:adaroapp_admin_panel/features/media/screens/widgets/media_content.dart';
import 'package:adaroapp_admin_panel/features/media/screens/widgets/media_uploader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../routes/routes.dart';
import '../../../../utils/constants/sizes.dart';

class MediaDesktopScreen extends StatelessWidget {
  const MediaDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MediaController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// BreadCrumbs
                TBreadCrumbsWithHeading(heading: 'Media', breadcrumbItems: [TRoutes.login,'Media Screen']),

                SizedBox(
                  width: TSizes.buttonWidth * 1.5,
                  child: ElevatedButton.icon(
                    onPressed: () => controller.showImagesUploaderSection.value = !controller.showImagesUploaderSection.value,
                    icon: const Icon(Iconsax.cloud_add),
                    label: const Text('Upload Images')),
                ),
              ],
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Upload Area
            const MediaUploader(),

            /// Media
            const MediaContent(),
          ],
        ),
        ),
      ),
    );
  }
}
