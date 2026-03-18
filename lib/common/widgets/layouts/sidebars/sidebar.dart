import 'package:adaroapp_admin_panel/common/widgets/images/t_circular_image.dart';
import 'package:adaroapp_admin_panel/features/personalization/controllers/settings_controller.dart';
import 'package:adaroapp_admin_panel/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../routes/routes.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';
import 'menu/menu_item.dart';

class TSidebar extends StatelessWidget {
  const TSidebar({super.key,});


  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: BeveledRectangleBorder(),
      child: Container(
        decoration: BoxDecoration(
          color: TColors.white,
          border: Border(right: BorderSide(color: TColors.grey, width:1))
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Obx(
                    () => TCircularImage(
                      width: 150,
                      height: 150,
                      padding: 0,
                      margin: TSizes.sm,
                      backgroundColor: Colors.transparent,
                      imageType: SettingsController.instance.settings.value.appLogo.isNotEmpty ? ImageType.network : ImageType.asset,
                      image: SettingsController.instance.settings.value.appLogo.isNotEmpty ? SettingsController.instance.settings.value.appLogo : TImages.darkAppLogo,

                    ),
                  ),
                  Expanded(child: Obx(()
                  => Text(
                    SettingsController.instance.settings.value.appName,
                    style: Theme.of(context).textTheme.headlineLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                  )),
                ],
              ),
              SizedBox(height: TSizes.spaceBtwSections/2),
              Padding(padding: EdgeInsets.all(TSizes.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('MENU', style: Theme.of(context).textTheme.bodySmall!.apply(letterSpacingDelta: 1.2)),

                  // Menu Items
                 const TMenuItem(route: TRoutes.dashboard, icon: Iconsax.status, itemName: 'Dashboard'),
                 const TMenuItem(route: TRoutes.media, icon: Iconsax.image, itemName: 'Media'),
                 const TMenuItem(route: TRoutes.banners, icon: Iconsax.picture_frame, itemName: 'Banners'),
                  const TMenuItem(route: TRoutes.customers, icon: Iconsax.profile_2user, itemName: 'Customers'),
                  const TMenuItem(route: TRoutes.orders, icon: Iconsax.box, itemName: 'Orders'),

                  const TMenuItem(route: TRoutes.consultationRequest, icon: Iconsax.cloud_plus, itemName: 'Doctor Consultation'),

                  // Other Menu Items
                  Text('OTHER' , style: Theme.of(context).textTheme.bodySmall!.apply(letterSpacingDelta: 1.2)),
                  const TMenuItem(route: TRoutes.profile, icon: Iconsax.user, itemName: 'Profile'),
                  const TMenuItem(route: TRoutes.settings, icon: Iconsax.setting_2, itemName: 'Settings'),

                  const TMenuItem(route: 'logout', icon: Iconsax.logout, itemName: 'Logout'),
                ],

              ),
              )
            ],
          ),

        )
      ),
    );
  }
}


