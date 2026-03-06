import 'dart:typed_data';


import 'package:adaroapp_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:adaroapp_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:adaroapp_admin_panel/features/media/controllers/media_controller.dart';
import 'package:adaroapp_admin_panel/features/media/screens/widgets/folder_dropdown.dart';
import 'package:adaroapp_admin_panel/utils/constants/enums.dart';
import 'package:adaroapp_admin_panel/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';

import '../../../../models/image_model.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';

class MediaUploader extends StatelessWidget {
  const MediaUploader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MediaController.instance;
    return Obx(
      () => controller.showImagesUploaderSection.value
          ? Column(
              children: [
                /// Drag and drop area
                TRoundedContainer(
                  height: 250,
                  showBorder: true,
                  borderColor: TColors.borderPrimary,
                  backgroundColor: TColors.primaryBackground,
                  padding: EdgeInsets.all(TSizes.defaultSpace),
                  child: Column(
                    children: [
                      Expanded(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            DropzoneView(
                              mime: const ['image/jpeg', 'image/png'],
                              cursor: CursorType.Default,
                              operation: DragOperation.copy,
                              onLoaded: () => print('Zone loaded'),
                              onError: (ev) => print('Zone error: $ev'),
                              onHover: () => print('Zone hovered'),
                              onLeave: () => print('Zone left'),
                              onCreated: (ctrl) =>
                                  controller.dropzoneController = ctrl,

                              onDropInvalid: (ev) =>
                                  print('Zone invalid MIME : $ev'),
                              onDropFiles: (ev) =>
                                  print('Zone drop multiple: $ev'),
                              onDropFile: (file) async {
                                final bytes = await controller.dropzoneController.getFileData(file);
                                final name = await controller.dropzoneController.getFilename(file);

                                final image = ImageModel(
                                  url: '',
                                  file: file,
                                  folder: '',
                                  filename: name,
                                  localImageToDisplay: Uint8List.fromList(bytes),
                                );

                                controller.selectedImagesToUpload.add(image);
                              },
                            ),

                            /// Drop Zone Content
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  TImages.defaultMultiImageIcon,
                                  width: 50,
                                  height: 50,
                                ),
                                const SizedBox(height: TSizes.spaceBtwItems),
                                const Text('Drag and Drop Images here'),
                                const SizedBox(height: TSizes.spaceBtwItems),
                                OutlinedButton(
                                  onPressed: () => controller.selectedLocalImages(),
                                  child: const Text('Select Images'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwItems),

                /// Heading & Locally selected Images
                if (controller.selectedImagesToUpload.isNotEmpty)
                  TRoundedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /// Folders Dropdown
                            Row(
                              children: [
                                Text(
                                  'Select Folder',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineSmall,
                                ),
                                const SizedBox(width: TSizes.spaceBtwItems),
                                MediaFolderDropdown(
                                  onChanged: (MediaCategory? newValue) {
                                    if (newValue != null) {
                                      controller.selectedPath.value = newValue;
                                    }
                                  },
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                TextButton(
                                  onPressed: () => controller.selectedImagesToUpload.clear(),
                                  child: const Text('Remove All'),
                                ),
                                const SizedBox(width: TSizes.spaceBtwItems),
                                TDeviceUtils.isMobileScreen(context)
                                    ? const SizedBox.shrink()
                                    : SizedBox(
                                        width: TSizes.buttonWidth,
                                        child: ElevatedButton(
                                          onPressed: () => controller.uploadImagesConfirmation(),
                                          child: const Text('Upload'),
                                        ),
                                      ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: TSizes.spaceBtwSections),

                        /// Locally Selected Images
                        Wrap(
                          alignment: WrapAlignment.start,
                          spacing: TSizes.spaceBtwItems / 2,
                          runSpacing: TSizes.spaceBtwItems / 2,
                          children: controller.selectedImagesToUpload
                              .where(
                                (image) => image.localImageToDisplay != null
                              )
                              .map(
                                (element) =>
                                    TRoundedImage(
                                      width: 90,
                                        height: 90,
                                        padding: TSizes.sm,
                                        imageType: ImageType.memory,
                                      memoryImage: element.localImageToDisplay,
                                      backgroundColor: TColors.primaryBackground,
                                    ),
                              ).toList(),
                        ),
                        const SizedBox(height: TSizes.spaceBtwSections),

                        /// Upload Button for Mobile
                        TDeviceUtils.isMobileScreen(context)
                            ? SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () => controller.uploadImagesConfirmation(),
                                  child: const Text('Upload'),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                const SizedBox(height: TSizes.spaceBtwSections),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}
