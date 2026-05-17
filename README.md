# first_run_kit

A production-ready Flutter package for building a polished first-launch experience with onboarding, permission flows, and safe first-run detection.

## Demo Video

![first_run_kit Demo](assets/readme/first_run_kit_demo_v2.gif)

## Why first_run_kit

- Detects first launch reliably using `SharedPreferences`
- Supports multi-step flows with onboarding, permission, and custom steps
- Handles permissions through `permission_handler`
- Provides modern default UI with easy theming
- Exposes flow analytics through `onFlowEvent`
- Includes safe storage reset utilities

## Installation

```yaml
dependencies:
  first_run_kit: ^1.1.2
```

```bash
flutter pub get
```

## Quick Start

```dart
FirstRunWrapper(
  steps: [
    OnboardingStep(
      title: 'Welcome',
      description: 'Let us quickly show you around.',
    ),
    PermissionStep.camera(),
    CustomStep(widget: MyCustomStepWidget()),
  ],
  onFinish: (_) => const HomeScreen(),
)
```

## Advanced Example

```dart
FirstRunWrapper(
  steps: [
    const OnboardingStep(
      title: 'Fast setup',
      description: 'A short guided setup for best experience.',
    ),
    PermissionStep.microphone(),
  ],
  config: FirstRunConfig(
    primaryColor: const Color(0xFF0F7BFF),
    backgroundColor: const Color(0xFFF3F8FF),
    surfaceColor: Colors.white,
    progressColor: const Color(0xFF0F7BFF),
    progressBackgroundColor: const Color(0xFFD7E8FF),
    successColor: const Color(0xFF00A86B),
    warningColor: const Color(0xFFF39C12),
    errorColor: const Color(0xFFE53935),
    cardBorderRadius: 24,
    layout: FirstRunLayout.centered,
    transitionBuilder: (child, animation) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.15, 0),
          end: Offset.zero,
        ).animate(animation),
        child: FadeTransition(opacity: animation, child: child),
      );
    },
    buttonBuilder: (context, label, onPressed) {
      return ElevatedButton(
        onPressed: onPressed,
        child: Text(label),
      );
    },
  ),
  onPermissionResult: (status) {
    // optional analytics or logging
  },
  onFlowEvent: (event) {
    // send to analytics: event.type.name, event.stepIndex, event.totalSteps
  },
  onFinish: (_) => const HomeScreen(),
)
```

## Best Practices

- Keep onboarding concise (2 to 4 focused steps)
- Explain permission value before requesting permission
- Use `CustomStep` for app-specific setup content
- Track completion events for analytics
- Use `FirstRunManager().resetFirstRun()` only for debug or QA

## Important Note

Do not manually clear or overwrite the `first_run` key unless you intentionally want to show onboarding again.

If you need to clear app preferences, use `StorageService.safeClear()` so `first_run` is preserved.

## Example App

A runnable demo is included in `example/`, showing onboarding + permission + custom step flow.

## License

MIT
