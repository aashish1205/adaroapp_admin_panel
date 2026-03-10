import 'package:flutter/material.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../../models/user_model.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';

class CustomerInfo extends StatelessWidget {
  const CustomerInfo({super.key, required this.customer});

  final UserModel customer;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Customer Information',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: TSizes.spaceBtwSections),

          // Personal Info Card
          Row(
            children: [
              const TRoundedImage(
                padding: 0,
                backgroundColor: TColors.primaryBackground,
                image: TImages.user,
                imageType: ImageType.asset,
              ), // TRounded Image
              const SizedBox(width: TSizes.spaceBtwItems),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Aashish Gupta',
                      style: Theme.of(context).textTheme.titleLarge,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const Text(
                      'ag21105@gmail.com',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ), // Column
              ), // Expanded
            ],
          ), // Row
          const SizedBox(height: TSizes.spaceBtwSections),

          // Meta Data
          Row(
            children: [
              const SizedBox(width: 120, child: Text('Username')),
              const Text(':'),
              const SizedBox(width: TSizes.spaceBtwItems / 2),
              Expanded(child: Text('Aashish' , style: Theme.of(context).textTheme.titleMedium)),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          Row(
            children: [
              const SizedBox(width: 120, child: Text('Country')),
              const Text(':'),
              const SizedBox(width: TSizes.spaceBtwItems / 2),
              Expanded(child: Text('India' , style: Theme.of(context).textTheme.titleMedium)),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          Row(
            children: [
              const SizedBox(width: 120, child: Text('Phone Number')),
              const Text(':'),
              const SizedBox(width: TSizes.spaceBtwItems / 2),
              Expanded(child: Text('+91 9076008283' , style: Theme.of(context).textTheme.titleMedium)),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          // Divider
          const Divider(),
          const SizedBox(height: TSizes.spaceBtwItems),

          // Additional Details
          Row(
            children: [
              Expanded(child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Last Order' , style: Theme.of(context).textTheme.titleLarge),
                  const Text('7 Days Ago , #[36d54]' ),
                ],
              )
              ),
              Expanded(child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Average Order Value' , style: Theme.of(context).textTheme.titleLarge),
                  const Text('\₹3352' ),
                ],
              )
              ),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          // Additional Details Cont.
          Row(
            children: [
              Expanded(child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Registered' , style: Theme.of(context).textTheme.titleLarge),
                  Text(customer.formattedDate ),
                ],
              )
              ),
              Expanded(child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email Marketing' , style: Theme.of(context).textTheme.titleLarge),
                  const Text('Subscribed' ),
                ],
              ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
