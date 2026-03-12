import 'package:adaroapp_admin_panel/common/widgets/breadcrumbs/breadcrumb_with_heading.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import '../widgets/settings_form.dart';
import '../widgets/settings_image_and_meta.dart';

class SettingsDesktopScreen extends StatelessWidget {
  const SettingsDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumbs
              TBreadCrumbsWithHeading(
                heading: 'Settings',
                breadcrumbItems: ['Settings'],
              ),
              SizedBox(height: TSizes.spaceBtwSections),
              // Body
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Pic and Meta
                  Expanded(child: SettingsImageAndMeta()),
                  SizedBox(width: TSizes.spaceBtwSections),
                  // Form
                  Expanded(flex: 2, child: SettingsForm()),
                ],
              ), // Row
            ],
          ), // Column
        ), // Padding
      ), // SingleChildScrollView
    ); // Scaffold
  }
}
