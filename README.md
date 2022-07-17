# interpolate package

Sometimes you need to map value from one range to another. This is where you should use interpolate functions which approximates values between points in the output range and lets you map value inside the input range to corresponded approximation in the output range. It also supports few types of Extrapolation to enable mapping outside the range.

## Usage

```dart
final double scale = interpolate(
  value: _scrollController.offset,
  inputRange: [
     itemWidth * (index - 2),
     itemWidth * (index - 1),
     itemWidth * index,
     itemWidth * (index + 1),
     itemWidth * (index + 2),
  ],
  outputRange: [0.8, 0.8, 1.0, 0.8, 0.8],
  extrapolate: Extrapolate.extend,
);
```

## inputRange, outputRange

- The `inputRange` is the range of the input values.
- The `outputRange` is the range of the output values. 
- The output value is calculated by interpolating between the two values in the input range.
- The `inputRange` and `outputRange` must have the same length.

## Extrapolate

- The `extrapolate` argument determines how the input value is extrapolated
beyond the input range.
- If `extrapolate` is `Extrapolate.identity`, the `inputRange` values are assumed to be increasing and the output value is clamped to the range.
- If `extrapolate` is `Extrapolate.extend`, the `inputRange` values are assumed to be increasing and the output value is extended beyond the range.
- If `extrapolate` is `Extrapolate.clamp`, the `inputRange` values are assumed to be increasing and the output value is clamped to the range.

## Credits

- [@Nghi-NV](https://github.com/Nghi-NV)