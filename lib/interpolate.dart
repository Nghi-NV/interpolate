/// Created by nghinv on Sun Jul 17 2022

library interpolate;

enum Extrapolate {
  /// Will extend the range linearly.
  extend,

  /// Will clamp the input value to the range.
  clamp,

  /// Will return the input value if the input value is out of range.
  identity,
}

/// A function that interpolates between numbers.
///
/// The [inputRange] is the range of the input values, and [outputRange] is the
/// range of the output values. The output value is calculated by interpolating
/// between the two values in the input range.
///
/// The [inputRange] and [outputRange] must have the same length.
///
/// The [extrapolate] argument determines how the input value is extrapolated
/// beyond the input range.
///
/// If [extrapolate] is [Extrapolate.identity], the [inputRange] values are
/// assumed to be increasing and the output value is clamped to the range.
///
/// If [extrapolate] is [Extrapolate.extend], the [inputRange] values are
/// assumed to be increasing and the output value is extended beyond the range.
///
/// If [extrapolate] is [Extrapolate.clamp], the [inputRange] values are
/// assumed to be increasing and the output value is clamped to the range.
///
/// Example:
///
/// ```dart
/// final double scale = interpolate(
///   value: _scrollController.offset,
///   inputRange: [
///      itemWidth * (index - 2),
///      itemWidth * (index - 1),
///      itemWidth * index,
///      itemWidth * (index + 1),
///      itemWidth * (index + 2),
///   ],
///   outputRange: [0.8, 0.8, 1.0, 0.8, 0.8],
///   extrapolate: Extrapolate.extend,
/// );
/// ```
///
double interpolate(
  double value, {
  required List<double> inputRange,
  required List<double> outputRange,
  Extrapolate? extrapolate,
  Extrapolate? extrapolateLeft,
  Extrapolate? extrapolateRight,
}) {
  assert(inputRange.length >= 2);
  assert(inputRange.length == outputRange.length);
  assert(inputRange.isNotEmpty);

  if (value < inputRange.first) {
    if (_getExtrapolate(extrapolate, left: extrapolateLeft) ==
        Extrapolate.identity) {
      return value;
    }

    if (_getExtrapolate(extrapolate, left: extrapolateLeft) ==
        Extrapolate.clamp) {
      return outputRange.first;
    }

    if (inputRange[1] - inputRange[0] == 0) {
      return outputRange[0];
    }

    return outputRange[0] +
        (value - inputRange[0]) /
            (inputRange[1] - inputRange[0]) *
            (outputRange[1] - outputRange[0]);
  }

  if (value > inputRange.last) {
    if (_getExtrapolate(extrapolate, right: extrapolateRight) ==
        Extrapolate.identity) {
      return value;
    }

    if (_getExtrapolate(extrapolate, right: extrapolateRight) ==
        Extrapolate.clamp) {
      return outputRange.last;
    }

    if (outputRange[outputRange.length - 1] -
            outputRange[outputRange.length - 2] ==
        0) {
      return outputRange[outputRange.length - 1];
    }

    return outputRange[outputRange.length - 1] +
        (value - inputRange[inputRange.length - 1]) /
            (inputRange[inputRange.length - 1] -
                inputRange[inputRange.length - 2]) *
            (outputRange[outputRange.length - 1] -
                outputRange[outputRange.length - 2]);
  }

  for (int i = 0; i < inputRange.length - 1; i++) {
    if (inputRange[i] <= value && value < inputRange[i + 1]) {
      if (outputRange[i + 1] - outputRange[i] == 0) {
        return outputRange[i];
      }

      return outputRange[i] +
          (value - inputRange[i]) /
              (inputRange[i + 1] - inputRange[i]) *
              (outputRange[i + 1] - outputRange[i]);
    }
  }

  return 0.0;
}

Extrapolate _getExtrapolate(
  Extrapolate? extrapolate, {
  Extrapolate? left,
  Extrapolate? right,
}) {
  if (extrapolate != null) {
    return extrapolate;
  }

  if (left != null) {
    return left;
  }

  if (right != null) {
    return right;
  }

  return Extrapolate.extend;
}
