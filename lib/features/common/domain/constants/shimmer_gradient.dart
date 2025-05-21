import 'package:flutter/material.dart';

const shimmerGradientLight = LinearGradient(
  colors: [
    Color(0xFFEBEBF4),
    Color(0xFFF4F4F4),
    Color(0xFFEBEBF4),
  ],
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);

const shimmerGradientDark = LinearGradient(
  colors: [
    Color(0xFF181818),
    Color(0xFF222121),
    Color(0xFF181818),
  ],
  stops: [
    0.0,
    0.35,
    1.0,
  ],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  tileMode: TileMode.clamp,
);
