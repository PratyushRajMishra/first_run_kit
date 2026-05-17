# first_run_kit - Complete First Launch Experience for Flutter

`first_run_kit` is a production-ready package for building a polished first launch experience in Flutter apps.

It helps you implement **flutter onboarding**, **first launch** detection, a customizable **onboarding flow**, and permission requests with **permission handler flutter** support, including modern **intro screens flutter** patterns.

## Features

- First launch detection using `SharedPreferences`
- Multi-step onboarding flow (onboarding, permission, custom steps)
- Built-in permission handling via `permission_handler`
- Custom step support for any widget
- Fully customizable UI and transitions
- Professional default card-based UI
- Easy color theming for background, cards, progress, and feedback states
- Structured flow analytics via `onFlowEvent` (started, next, back, skipped, completed)
- Safe storage utilities with `safeClear()` preserving `first_run`

## Installation

Add dependency:

```yaml
dependencies:
  first_run_kit: ^1.1.1
```

Then run:

```bash
flutter pub get
```

## Usage

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

## Advanced Usage

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

## Demo Video

This demo animation auto-plays on both GitHub README and pub.dev:

![first_run_kit Demo Video](https://raw.githubusercontent.com/PratyushRajMishra/first_run_kit/main/assets/readme/first_run_kit_demo.gif)

You can replace this demo file with your own capture at:

- `assets/readme/first_run_kit_demo.gif` (source file)

## Best Practices

- Keep onboarding concise (2 to 4 focused steps)
- Explain permission value before requesting permission
- Use `CustomStep` for business-specific setup content
- Track completion events for analytics
- Use `FirstRunManager().resetFirstRun()` only for debug tools or QA

## Warning

Do not manually clear or overwrite the `first_run` key unless you intentionally want to show onboarding again.

If you need to clear app preferences, use `StorageService.safeClear()` so `first_run` is preserved and first-run behavior remains predictable.

## Example App

A runnable demo is included in [`example/`](example), showing onboarding + permission + custom step flow.

## License

MIT
