import 'package:flutter/material.dart';

import '../../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../../common/widgets/images/t_rounded_image.dart';
import '../../../../../../models/order_model.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/enums.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/constants/sizes.dart';

class OrderCustomer extends StatelessWidget {
  const OrderCustomer({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Personal Info
        TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Customer', style: Theme
                  .of(context)
                  .textTheme
                  .headlineMedium),
              const SizedBox(height: TSizes.spaceBtwSections),
              Row(
                  children: [
                    const TRoundedImage(
                      padding: 0,
                      backgroundColor: TColors.primaryBackground,
                      image: TImages.user,
                      imageType: ImageType.asset,
                    ), // TRounded Image
                    const SizedBox (width: TSizes.spaceBtwItems),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Coding with T', style: Theme
                              .of(context)
                              .textTheme
                              .titleLarge,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1),
                          const Text('support@codingwitht.com',
                              overflow: TextOverflow.ellipsis, maxLines: 1),
                        ],
                      ), // Column
                    ) // Expanded
                  ],
              ), // Row
            ],
          ), // Column
        ), // TRoundedContainer
        const SizedBox (height: TSizes.spaceBtwSections),

        // Contact Info
        SizedBox(
          width: double.infinity,
          child: TRoundedContainer(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Contact Person' , style:  Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: TSizes.spaceBtwSections),
                Text('Aashish Gupta' , style: Theme.of(context).textTheme.titleSmall,),
                const SizedBox(height: TSizes.spaceBtwItems / 2),
                Text('ag21105@gmail.com' , style:  Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: TSizes.spaceBtwSections / 2),
                Text('+91 9076008283' , style: Theme.of(context).textTheme.titleSmall,),
              ],
            ),
          ),

        ),
        const SizedBox(height: TSizes.spaceBtwSections),

        // Contact Info
        SizedBox(
          width: double.infinity,
          child: TRoundedContainer(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Shipping Address' , style:  Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: TSizes.spaceBtwSections),
                Text('Aashish Gupta' , style: Theme.of(context).textTheme.titleSmall,),
                const SizedBox(height: TSizes.spaceBtwItems / 2),
                Text('61 Bridge Street, Kurla(west), Mumbai' , style:  Theme.of(context).textTheme.titleSmall,),
              ],
            ),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),

        // Contact info: Adjust this address as per your needs
        SizedBox(
          width: double.infinity,
          child: TRoundedContainer(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Billing Address' , style:  Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: TSizes.spaceBtwSections),
                Text('Aashish Gupta' , style: Theme.of(context).textTheme.titleSmall,),
                const SizedBox(height: TSizes.spaceBtwItems / 2),
                Text('61 Bridge Street, Kurla(west), Mumbai' , style:  Theme.of(context).textTheme.titleSmall),
              ],
            ),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
      ],
    );
  }
}
