import 'package:flutter_test/flutter_test.dart';

import 'package:interpolate/interpolate.dart';

void main() {
  test('output value with extrapolate is extend', () {
    final inputs = [0.0, 1.0];
    final outputs = [0.0, 100.0];
    const value = 0.5;

    final valueOut = interpolate(
      value,
      inputRange: inputs,
      outputRange: outputs,
      extrapolate: Extrapolate.extend,
    );

    expect(valueOut, closeTo(50.0, 0.00001));
  });
}
