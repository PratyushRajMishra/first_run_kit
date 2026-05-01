## 1.0.0

- Initial stable release of `first_run_kit`.
- Added first-run detection using `SharedPreferences`.
- Added multi-step flow support with `OnboardingStep`, `PermissionStep`, and `CustomStep`.
- Added `FlowController` with `next`, `back`, `skip`, and progress state.
- Added safe storage wrapper with `safeClear()` preserving `first_run` key.
- Added customizable UI configuration via `FirstRunConfig`.
- Added example app demonstrating onboarding + permission + custom step flow.
