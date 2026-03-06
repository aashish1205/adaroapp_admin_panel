import 'package:adaroapp_admin_panel/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../styles/spacing_styles.dart';

class TLoginTemplate extends StatelessWidget {
  const TLoginTemplate({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 550,
        child: SingleChildScrollView(
          child: Container(
            padding: TSpacingStyle.paddingWithAppBarHeight,
            decoration: BoxDecoration(
              color: THelperFunctions.isDarkMode(context) ? TColors.black : Colors.white,
              borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
