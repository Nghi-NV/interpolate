import 'package:interpolate/interpolate.dart';

void main() {
  final inputs = [0.0, 1.0];
  final outputs = [0.0, 100.0];
  const value = 0.5;

  final valueOutput = interpolate(
    value,
    inputRange: inputs,
    outputRange: outputs,
    extrapolate: Extrapolate.extend,
  );

  print(valueOutput);
}
