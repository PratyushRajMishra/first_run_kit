# first_run_kit - Complete First Launch Experience for Flutter

`first_run_kit` is a production-ready package for building a polished first launch experience in Flutter apps.

It helps you implement **flutter onboarding**, **first launch** detection, a customizable **onboarding flow**, and permission requests with **permission handler flutter** support, including modern **intro screens flutter** patterns.

## Features

- First launch detection using `SharedPreferences`
- Multi-step onboarding flow (onboarding, permission, custom steps)
- Built-in permission handling via `permission_handler`
- Custom step support for any widget
- Fully customizable UI and transitions
- Safe storage utilities with `safeClear()` preserving `first_run`

## Installation

Add dependency:

```yaml
dependencies:
  first_run_kit: ^1.0.1
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
    primaryColor: Colors.teal,
    backgroundColor: Colors.white,
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
  onFinish: (_) => const HomeScreen(),
)
```

## Screenshots

Demo GIF (recommended mobile aspect ratio):

![first_run_kit Demo](https://raw.githubusercontent.com/PratyushRajMishra/first_run_kit/main/assets/readme/first_run_kit_demo.gif)

You can replace this with your own capture at:

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
