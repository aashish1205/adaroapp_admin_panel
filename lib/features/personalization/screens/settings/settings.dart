import 'package:adaroapp_admin_panel/common/widgets/layouts/templates/site_layout.dart';
import 'package:adaroapp_admin_panel/features/personalization/screens/settings/responsive_screens/settings_desktop.dart';
import 'package:adaroapp_admin_panel/features/personalization/screens/settings/responsive_screens/settings_mobile.dart';
import 'package:adaroapp_admin_panel/features/personalization/screens/settings/responsive_screens/settings_tablet.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TSiteTemplate(
      desktop: SettingsDesktopScreen(),
      tablet: SettingsTabletScreen(),
      mobile: SettingsMobileScreen(),
    );
  }
}
