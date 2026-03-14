import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';

class TLoaderAnimation extends StatelessWidget {

  const TLoaderAnimation({
    super.key,
    this.height = 300,
    this.width = 300,
  });

  final double height, width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          // Lottie animation instead of Image
          Lottie.asset(
            TImages.emptyAnimation,
            height: height,
            width: width,
          ),

          const SizedBox(height: TSizes.spaceBtwItems),

          const Text('Loading your data....'),
        ],
      ),
    );
  }
}