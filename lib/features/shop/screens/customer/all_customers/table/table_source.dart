import 'package:adaroapp_admin_panel/common/widgets/icons/table_action_icon_buttons.dart';
import 'package:adaroapp_admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:adaroapp_admin_panel/features/shop/controllers/customer/customer_controller.dart';
import 'package:adaroapp_admin_panel/models/user_model.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../../routes/routes.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';

class CustomerRows extends DataTableSource {
  final controller = CustomerController.instance;

  @override
  DataRow2 getRow(int index) {

    return DataRow2(
        cells: [
          DataCell(
            Row(
              children: [
                const TRoundedImage(
                  width: 50,
                  height: 50,
                  padding: TSizes.sm,
                  image: TImages.defaultImage,
                  imageType: ImageType.network,
                  borderRadius: TSizes.borderRadiusMd,
                  backgroundColor: TColors.primaryBackground,
                ),
                const SizedBox(width: TSizes.spaceBtwItems),
                Expanded(
                    child: Text(
                        'Aashish Gupta',
                      style: Theme.of(Get.context!).textTheme.bodyLarge!.apply(color: TColors.primary),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ))
              ],
            )
          ),
          const DataCell(Text('ag21105@gmail.com')),
          const DataCell(Text('9076008283')),
          DataCell(Text(DateTime.now().toString())),
          DataCell(
            TTableActionButtons(
              view: true,
              edit: false,
              onViewPressed: () => Get.toNamed(TRoutes.customerDetails, arguments: UserModel.empty()),
              onDeletePressed: () {},
            )
          )
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