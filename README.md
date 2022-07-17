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

## Credits

- [@Nghi-NV](https://github.com/Nghi-NV)