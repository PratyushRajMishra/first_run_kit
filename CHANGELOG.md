## 1.1.3

- Fixed pub.dev demo rendering by switching README demo image to an absolute GitHub raw URL.
- Added a fresh demo asset filename (`first_run_kit_demo_v3.gif`) to avoid stale cache.

## 1.1.2

- Made README more professional and concise for package users.
- Switched demo embed to package-local `assets/readme/first_run_kit_demo_v2.gif` for consistent rendering on pub.dev and GitHub.

## 1.1.1

- Replaced README demo media with the latest recording converted from `first_run.webm`.
- Keeps demo playback compatible with both GitHub README and pub.dev via GIF embed.

## 1.1.0

- Bumped package version for latest release.
- Updated README to present the demo as an auto-playing demo video (GIF) compatible with both GitHub and pub.dev.
- Included latest package and example updates in this release.

## 1.0.2

- Updated README demo media link to absolute GitHub raw URL for reliable rendering on pub.dev.
- Kept onboarding, permission flow, and first-run APIs unchanged (documentation-focused release).

## 1.0.1

- Improved onboarding progress header UI for a cleaner modern look.
- Added ready-to-use demo GIF in `assets/readme/first_run_kit_demo.gif`.
- Updated README with embedded demo preview and usage guidance.
- Updated `permission_handler` to `^12.0.1` for latest dependency compatibility.

## 1.0.0

- Initial stable release of `first_run_kit`.
- Added first-run detection using `SharedPreferences`.
- Added multi-step flow support with `OnboardingStep`, `PermissionStep`, and `CustomStep`.
- Added `FlowController` with `next`, `back`, `skip`, and progress state.
- Added safe storage wrapper with `safeClear()` preserving `first_run` key.
- Added customizable UI configuration via `FirstRunConfig`.
- Added example app demonstrating onboarding + permission + custom step flow.
