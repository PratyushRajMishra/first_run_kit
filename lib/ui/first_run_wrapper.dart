import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../controller/flow_controller.dart';
import '../core/first_run_manager.dart';
import '../models/first_run_step.dart';
import '../widgets/navigation_buttons.dart';
import '../widgets/progress_indicator.dart';
import '../widgets/step_builder.dart';
import 'first_run_theme.dart';

/// Main plug-and-play widget for first-launch onboarding flow.
class FirstRunWrapper extends StatefulWidget {
  /// Creates a first-run wrapper.
  const FirstRunWrapper({
    super.key,
    required this.steps,
    required this.onFinish,
    this.config = const FirstRunConfig(),
    this.manager,
    this.onPermissionResult,
  });

  /// Ordered list of steps to show during first launch.
  final List<FirstRunStep> steps;

  /// Builder for the post-onboarding screen.
  final WidgetBuilder onFinish;

  /// Visual and layout configuration for the flow.
  final FirstRunConfig config;

  /// Optional custom first-run manager instance.
  final FirstRunManager? manager;

  /// Optional callback for permission request outcomes.
  final ValueChanged<PermissionStatus>? onPermissionResult;

  @override
  State<FirstRunWrapper> createState() => _FirstRunWrapperState();
}

class _FirstRunWrapperState extends State<FirstRunWrapper> {
  late final FirstRunManager _manager;
  late final FlowController _controller;
  late Future<bool> _isFirstRunFuture;
  bool _completed = false;

  @override
  void initState() {
    super.initState();
    _manager = widget.manager ?? FirstRunManager();
    _controller = FlowController(stepCount: widget.steps.length);
    _isFirstRunFuture = _manager.isFirstRun();
  }

  Future<void> _completeFlow() async {
    if (_completed) return;
    _completed = true;
    await _manager.markFirstRunComplete();
    if (mounted) setState(() {});
  }

  Widget _flowBody() {
    if (widget.steps.isEmpty) {
      _completeFlow();
      return const SizedBox.shrink();
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final currentStep = widget.steps[_controller.currentIndex];
        final transitionBuilder =
            widget.config.transitionBuilder ??
            (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            };

        final body = Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FirstRunProgressIndicator(
              currentIndex: _controller.currentIndex,
              total: widget.steps.length,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: transitionBuilder,
                child: KeyedSubtree(
                  key: ValueKey(_controller.currentIndex),
                  child: StepBuilder(
                    step: currentStep,
                    onPermissionResult: (status) {
                      widget.onPermissionResult?.call(status);
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            NavigationButtons(
              controller: _controller,
              onComplete: _completeFlow,
            ),
          ],
        );

        if (widget.config.layout == FirstRunLayout.fullScreen) {
          return body;
        }

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: body,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FirstRunThemeScope(
      config: widget.config,
      child: FutureBuilder<bool>(
        future: _isFirstRunFuture,
        builder: (context, snapshot) {
          if (_completed) {
            return widget.onFinish(context);
          }

          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          final isFirstRun = snapshot.data ?? true;
          if (!isFirstRun) {
            return widget.onFinish(context);
          }

          return ColoredBox(
            color:
                widget.config.backgroundColor ??
                Theme.of(context).scaffoldBackgroundColor,
            child: SafeArea(
              child: Padding(
                padding: widget.config.padding,
                child: _flowBody(),
              ),
            ),
          );
        },
      ),
    );
  }
}
