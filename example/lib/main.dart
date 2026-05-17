import 'package:first_run_kit/first_run_kit.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    const brand = Color(0xFF0A7AFF);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Astra Budget',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: brand),
        scaffoldBackgroundColor: const Color(0xFFF4F8FF),
      ),
      home: FirstRunWrapper(
        config: const FirstRunConfig(
          layout: FirstRunLayout.centered,
          primaryColor: brand,
          backgroundColor: Color(0xFFEFF5FF),
          surfaceColor: Colors.white,
          progressColor: brand,
          progressBackgroundColor: Color(0xFFD5E6FF),
          successColor: Color(0xFF0F9D58),
          warningColor: Color(0xFFF39C12),
          errorColor: Color(0xFFE53935),
          cardBorderRadius: 26,
        ),
        steps: [
          const OnboardingStep(
            title: 'Welcome to Astra Budget',
            description:
                'A modern personal finance app to plan, save, and grow steadily.',
            image: _HeroOrb(icon: Icons.auto_graph_rounded),
          ),
          const OnboardingStep(
            title: 'Money Clarity, Daily',
            description:
                'Visual insights and weekly goals help you stay in control.',
            image: _HeroOrb(icon: Icons.insights_rounded),
          ),
          const OnboardingStep(
            title: 'Smart Spending Categories',
            description:
                'Auto-categorize expenses to understand where your money goes.',
            image: _HeroOrb(icon: Icons.pie_chart_rounded),
          ),
          const OnboardingStep(
            title: 'Shared Budget Spaces',
            description:
                'Create shared spaces for family, roommates, or travel plans.',
            image: _HeroOrb(icon: Icons.groups_rounded),
          ),
          PermissionStep.camera(
            title: 'Scan Bills Instantly',
            description:
                'Enable camera access to scan receipts and pay bills faster.',
            rationale: 'You can disable it anytime from settings.',
          ),
          PermissionStep.microphone(
            title: 'Voice Notes & Smart Search',
            description: 'Enable microphone to log expenses faster by voice.',
            rationale: 'You can disable it anytime from settings.',
          ),
          PermissionStep.photos(
            title: 'Attach Receipts',
            description:
                'Allow photos access to attach bill screenshots and invoices.',
            rationale: 'You can disable it anytime from settings.',
          ),
          const CustomStep(widget: _GoLiveStep()),
        ],
        onFlowEvent: (event) {
          debugPrint(
            '[first_run_kit] ${event.type.name} step ${event.stepIndex + 1}/${event.totalSteps}',
          );
        },
        onFinish: (_) => const HomeScreen(),
      ),
    );
  }
}

class _HeroOrb extends StatelessWidget {
  const _HeroOrb({required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0A7AFF), Color(0xFF37B4FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(36),
        boxShadow: const [
          BoxShadow(
            color: Color(0x330A7AFF),
            blurRadius: 24,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Icon(icon, color: Colors.white, size: 58),
    );
  }
}

class _GoLiveStep extends StatelessWidget {
  const _GoLiveStep();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.rocket_launch_rounded, size: 58),
            SizedBox(height: 12),
            Text(
              'Setup complete. Your finance cockpit is ready.',
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
      appBar: AppBar(
        title: const Text('Astra Budget'),
        actions: [
          IconButton(
            tooltip: 'Replay onboarding',
            onPressed: () async {
              await FirstRunManager().resetFirstRun();
              if (context.mounted) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute<void>(builder: (_) => const ExampleApp()),
                );
              }
            },
            icon: const Icon(Icons.replay_rounded),
          ),
        ],
      ),
      body: Stack(
        children: [
          const _Atmosphere(),
          ListView(
            padding: const EdgeInsets.all(16),
            children: const [
              _HeaderCard(),
              SizedBox(height: 12),
              _ActionGrid(),
              SizedBox(height: 12),
              _InsightCard(),
            ],
          ),
        ],
      ),
    );
  }
}

class _Atmosphere extends StatelessWidget {
  const _Atmosphere();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Align(
        alignment: Alignment.topRight,
        child: Container(
          width: 260,
          height: 260,
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              colors: [Color(0x220A7AFF), Colors.transparent],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0A7AFF), Color(0xFF3D8BFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Total Balance', style: TextStyle(color: Colors.white70)),
          SizedBox(height: 6),
          Text(
            '\$12,420.85',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 32,
            ),
          ),
          SizedBox(height: 6),
          Text('+8.4% this month', style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

class _ActionGrid extends StatelessWidget {
  const _ActionGrid();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: _ActionCard(icon: Icons.send_rounded, label: 'Transfer')),
        SizedBox(width: 10),
        Expanded(child: _ActionCard(icon: Icons.account_tree_rounded, label: 'Budget')),
        SizedBox(width: 10),
        Expanded(child: _ActionCard(icon: Icons.savings_rounded, label: 'Savings')),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Column(
          children: [
            Icon(icon, size: 26),
            const SizedBox(height: 8),
            Text(label),
          ],
        ),
      ),
    );
  }
}

class _InsightCard extends StatelessWidget {
  const _InsightCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Weekly Insights', style: TextStyle(fontWeight: FontWeight.w700)),
            SizedBox(height: 10),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.trending_up_rounded, color: Color(0xFF0F9D58)),
              title: Text('Food spending down 12%'),
              subtitle: Text('Great consistency this week'),
            ),
            Divider(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.calendar_month_rounded, color: Color(0xFF0A7AFF)),
              title: Text('Upcoming bill reminder'),
              subtitle: Text('Electricity bill due tomorrow'),
            ),
          ],
        ),
      ),
    );
  }
}
