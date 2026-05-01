import 'package:permission_handler/permission_handler.dart';

import 'first_run_step.dart';
import 'step_type.dart';

/// A step that requests a runtime permission.
class PermissionStep extends FirstRunStep {
  /// Creates a permission request step.
  const PermissionStep({
    required this.permission,
    required this.title,
    required this.description,
    this.rationale,
    this.requestButtonText = 'Allow',
  }) : super(StepType.permission);

  /// Convenience factory for camera permission.
  factory PermissionStep.camera({
    String title = 'Camera Access',
    String description = 'Allow camera permission to scan and capture content.',
    String? rationale,
    String requestButtonText = 'Allow Camera',
  }) {
    return PermissionStep(
      permission: Permission.camera,
      title: title,
      description: description,
      rationale: rationale,
      requestButtonText: requestButtonText,
    );
  }

  /// Convenience factory for microphone permission.
  factory PermissionStep.microphone({
    String title = 'Microphone Access',
    String description = 'Allow microphone permission for voice features.',
    String? rationale,
    String requestButtonText = 'Allow Microphone',
  }) {
    return PermissionStep(
      permission: Permission.microphone,
      title: title,
      description: description,
      rationale: rationale,
      requestButtonText: requestButtonText,
    );
  }

  /// Convenience factory for photos permission.
  factory PermissionStep.photos({
    String title = 'Photos Access',
    String description = 'Allow photos permission to import and save media.',
    String? rationale,
    String requestButtonText = 'Allow Photos',
  }) {
    return PermissionStep(
      permission: Permission.photos,
      title: title,
      description: description,
      rationale: rationale,
      requestButtonText: requestButtonText,
    );
  }

  /// Permission to request.
  final Permission permission;

  /// Heading shown before requesting permission.
  final String title;

  /// Description of why permission is needed.
  final String description;

  /// Optional extra rationale text shown to the user.
  final String? rationale;

  /// Label for the permission request button.
  final String requestButtonText;
}
