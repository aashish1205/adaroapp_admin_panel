import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/validators/validation.dart';

class SettingsForm extends StatelessWidget {
  const SettingsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // App Settings
        TRoundedContainer(
          padding: const EdgeInsets.symmetric(vertical: TSizes.lg, horizontal: TSizes.md),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('App Settings' , style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: TSizes.spaceBtwSections),

                // App Name
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'App Name',
                    label: Text('App Name'),
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),

                // Email and Phone
                Row(
                  children: [
                    // First Name
                    Expanded(child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Tax %',
                        label: Text('Tax Rate(%)'),
                        prefixIcon: Icon(Iconsax.tag),
                      ),
                    )
                    ),
                    const SizedBox(width: TSizes.spaceBtwItems),

                    Expanded(child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Shipping Cost',
                        label: Text('Shipping Cost (\₹)'),
                        prefixIcon: Icon(Iconsax.ship),
                      ),
                    )
                    ),
                    const SizedBox(width: TSizes.spaceBtwItems),
                    // Last Name
                    Expanded(child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Free Shipping After (\₹)',
                        label: Text('Free Shipping Threshold (\₹)'),
                        prefixIcon: Icon(Iconsax.ship),
                      ),

                    )
                    )
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwSections * 2),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: () {}, child: const Text('Update App Settings')),
                ),



              ],
            ),
          ),
        )
      ],
    );
  }
}
