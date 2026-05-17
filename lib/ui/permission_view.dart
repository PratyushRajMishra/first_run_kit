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
  Color? _messageColor;

  Future<void> _requestPermission() async {
    if (_isRequesting) return;

    setState(() {
      _isRequesting = true;
      _message = null;
      _messageColor = null;
    });

    try {
      final status = await widget.step.permission.request();
      widget.onRequestFinished(status);

      setState(() {
        if (status.isGranted) {
          _message = 'Permission granted.';
          _messageColor = Colors.green;
        } else if (status.isPermanentlyDenied) {
          _message =
              'Permission permanently denied. Open app settings to allow it.';
          _messageColor = Colors.red;
        } else {
          _message = 'Permission denied. You can continue and enable it later.';
          _messageColor = Colors.orange;
        }
      });
    } catch (_) {
      setState(() {
        _message =
            'Could not request permission on this device. You can continue.';
        _messageColor = Colors.orange;
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
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final surface = config.surfaceColor ?? colorScheme.surfaceContainerLow;
    final onSurface = config.onSurfaceColor ?? colorScheme.onSurface;
    final successColor = config.successColor ?? colorScheme.primary;
    final warningColor = config.warningColor ?? Colors.orange;
    final errorColor = config.errorColor ?? colorScheme.error;

    Color resolveMessageColor() {
      if (_messageColor == Colors.green) return successColor;
      if (_messageColor == Colors.red) return errorColor;
      return warningColor;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(config.cardBorderRadius),
        border: Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.45)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.step.title,
            textAlign: TextAlign.center,
            style:
                config.titleStyle ??
                textTheme.headlineSmall?.copyWith(
                  color: onSurface,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            widget.step.description,
            textAlign: TextAlign.center,
            style:
                config.descriptionStyle ??
                textTheme.bodyLarge?.copyWith(color: onSurface.withValues(alpha: 0.85)),
          ),
          if ((widget.step.rationale ?? '').isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              widget.step.rationale!,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: onSurface.withValues(alpha: 0.75),
              ),
            ),
          ],
          const SizedBox(height: 8),
          const SizedBox(height: 16),
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
              style: textTheme.bodySmall?.copyWith(color: resolveMessageColor()),
            ),
          ],
        ],
      ),
    );
  }
}
