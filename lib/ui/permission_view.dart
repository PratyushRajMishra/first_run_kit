import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/permission_step.dart';
import 'first_run_theme.dart';

/// Default UI renderer for [PermissionStep].
class PermissionView extends StatefulWidget {
  /// Creates a permission view.
  const PermissionView({
    super.key,
    required this.step,
    required this.onRequestFinished,
  });

  /// Permission step data.
  final PermissionStep step;

  /// Called after permission request completes.
  final ValueChanged<PermissionStatus> onRequestFinished;

  @override
  State<PermissionView> createState() => _PermissionViewState();
}

class _PermissionViewState extends State<PermissionView> {
  bool _isRequesting = false;
  String? _message;

  Future<void> _requestPermission() async {
    if (_isRequesting) return;

    setState(() {
      _isRequesting = true;
      _message = null;
    });

    try {
      final status = await widget.step.permission.request();
      widget.onRequestFinished(status);

      setState(() {
        if (status.isGranted) {
          _message = 'Permission granted.';
        } else if (status.isPermanentlyDenied) {
          _message =
              'Permission permanently denied. Open app settings to allow it.';
        } else {
          _message = 'Permission denied. You can continue and enable it later.';
        }
      });
    } catch (_) {
      setState(() {
        _message =
            'Could not request permission on this device. You can continue.';
      });
    } finally {
      setState(() {
        _isRequesting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final config = FirstRunThemeScope.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.step.title,
          textAlign: TextAlign.center,
          style: config.titleStyle ?? textTheme.headlineSmall,
        ),
        const SizedBox(height: 12),
        Text(
          widget.step.description,
          textAlign: TextAlign.center,
          style: config.descriptionStyle ?? textTheme.bodyLarge,
        ),
        if ((widget.step.rationale ?? '').isNotEmpty) ...[
          const SizedBox(height: 8),
          Text(
            widget.step.rationale!,
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium,
          ),
        ],
        const SizedBox(height: 24),
        config.buildNextButton(
          context,
          _isRequesting ? 'Requesting...' : widget.step.requestButtonText,
          _isRequesting ? () {} : _requestPermission,
        ),
        if ((_message ?? '').isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(
            _message!,
            textAlign: TextAlign.center,
            style: textTheme.bodySmall,
          ),
        ],
      ],
    );
  }
}
