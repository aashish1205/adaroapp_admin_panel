import 'package:flutter/material.dart';
import 'package:get/get.dart';


class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Screen'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Simple Navigation: Default Flutter Navigatior VS GetX Navigation',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SecondScreen(),
                    ),
                  );
                },
                child: const Text('Default Navigation'),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () => Get.to(() => const SecondScreen()),
                child: const Text('GetX Navigation'),
              ),
            ),

            /// Named Navigation
            const SizedBox(height: 50),
            const Divider(),
            const Text(
              'Named Navigation: Flutter Navigator VS GetX Named Navigation',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/second-screen');
                },
                child: const Text('Default Name Navigation'),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: 250,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed('/second-screen');
                },
                child: const Text('GetX Named Navigation'),
              ),
            ),
            const SizedBox(height: 50),
            const Divider(),

            /// Pass Data
            const Text(
              'Pass Data between screens . GetX',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(
                    '/second-screen',
                    arguments: 'GetX is fun with Adaro',
                  );
                },
                child: const Text('GetX Pass Data'),
              ),
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed('/second-screen?device=phone&id=3546name=Enzo');
                },
                child: const Text('Pass Data in URL'),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed('/second-screen/1234');
                },
                child: const Text('Pass data in url'),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 400,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(
                    '/second-screen?device=phone&id=3546name=Enzo',
                    arguments: 'GetX is  fun with adaro',
                  );
                },
                child: const Text('Pass Data in the URL with arguments'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Screen'), centerTitle: true),

      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(Get.arguments ?? ''),

            Text('Device = ${Get.parameters['device'] ?? ''} '),
            Text('ID = ${Get.parameters['id'] ?? ''} '),
            Text('Name = ${Get.parameters['name'] ?? ''} '),

            Text('Name = ${Get.parameters['userId'] ?? ''} '),
          ],
        ),
      ),
    );
  }
}