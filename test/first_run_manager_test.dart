import 'package:first_run_kit/first_run_kit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('first run constants are stable', () {
    expect(FirstRunConstants.firstRunKey, 'first_run');
    expect(FirstRunConstants.defaultFirstRunValue, isTrue);
  });

  test('flow controller navigation works', () {
    final controller = FlowController(stepCount: 3);

    expect(controller.currentIndex, 0);
    expect(controller.isFirstStep, isTrue);

    controller.next();
    expect(controller.currentIndex, 1);

    controller.back();
    expect(controller.currentIndex, 0);

    controller.skip();
    expect(controller.currentIndex, 2);
    expect(controller.isLastStep, isTrue);
  });
}
