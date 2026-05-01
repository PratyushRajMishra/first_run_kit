import 'package:first_run_kit/first_run_kit.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'first_run_kit demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: FirstRunWrapper(
        steps: [
          const OnboardingStep(
            title: 'Welcome to FirstRunKit',
            description: 'Create a modern first-launch experience in minutes.',
            image: Icon(Icons.auto_awesome, size: 120),
          ),
          PermissionStep.camera(
            title: 'Camera Permission',
            description: 'We use camera for QR scanning and profile capture.',
            rationale: 'You can skip now and enable it later from settings.',
          ),
          const CustomStep(widget: _TipCard()),
        ],
        config: const FirstRunConfig(layout: FirstRunLayout.centered),
        onFinish: (_) => const HomeScreen(),
      ),
    );
  }
}

class _TipCard extends StatelessWidget {
  const _TipCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.lightbulb_outline, size: 72),
            SizedBox(height: 12),
            Text(
              'Pro tip: keep onboarding concise and focused on user value.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await FirstRunManager().resetFirstRun();
            if (context.mounted) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute<void>(builder: (_) => const ExampleApp()),
              );
            }
          },
          child: const Text('Reset First Run For Demo'),
        ),
      ),
    );
  }
}
