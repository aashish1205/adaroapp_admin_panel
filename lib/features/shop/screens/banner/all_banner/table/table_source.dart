import 'package:adaroapp_admin_panel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:adaroapp_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../models/banner_model.dart';
import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';

class BannersRows extends DataTableSource {
  @override
  DataRow? getRow(int index) {
    return DataRow2(
        cells: [
          const DataCell(
            TRoundedImage(
              width: 180,
                height: 100,
                padding: TSizes.sm,
                image: TImages.banner1,
                imageType: ImageType.asset,
              borderRadius: TSizes.borderRadiusMd,
              backgroundColor: TColors.primaryBackground,
            ),
          ),
          const DataCell(Text('Shop')),
          const DataCell(Icon(Iconsax.eye, color: TColors.primary)),
          DataCell(
            TTableActionButtons(
              onEditPressed: () => Get.toNamed(TRoutes.editBanner,  arguments: BannerModel(imageUrl:'', targetScreen: '', active: false)),
              onDeletePressed: () {},
            )
          ),
        ]
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 10;

  @override
  int get selectedRowCount => 0;
}
