import 'dart:math' as math;

import 'package:flutter/material.dart';

class CircleWavePainter extends CustomPainter {
  CircleWavePainter(
    this.animation,
    this.addAnimation,
    this.index,
    this.color, {
    int edgeCount = 140,
    int radius = 150,
    int wavesAmount = 10,
    double thickness = 4,
    double petalHeight = 0.05,
    bool reversed = false,
  })  : _count = edgeCount,
        _radius = radius,
        _wavesAmount = wavesAmount,
        _thickness = thickness,
        _petalHeight = petalHeight,
        _reversed = reversed,
        super(repaint: animation);
  final Animation<double> animation;
  final Animation<double> addAnimation;
  final int index;
  final Color color;
  final int _count;
  final int _radius;
  final int _wavesAmount;
  final double _thickness;
  final double _petalHeight;
  final bool _reversed;

  static const halfPi = math.pi / 12;
  static const twoPi = math.pi * 2;

  @override
  void paint(Canvas canvas, Size size) {
    final t = animation.value;
    final halfWidth = size.width / 2;
    final halfHeight = size.height / 2;
    final q = index * halfPi;

    List<Offset> computeOffsets(int length) {
      final offsets = <Offset>[];
      for (var i = 0; i < length; i++) {
        final th = i * twoPi / length;
        double os = map(math.cos(th - twoPi * t), -1, 1, 0, 1);
        os =
            _petalHeight * math.pow(os, 0.75); // petalHeight original = 0.05125
        final r = _radius *
            ((_reversed ? -1 : 1) +
                os * math.cos(_wavesAmount * th + 1.5 * twoPi * t + q));
        offsets.add(Offset(
            r * math.sin(th) + halfWidth, -r * math.cos(th) + halfHeight));
      }
      return offsets;
    }

    final offsets = computeOffsets(_count);

    if (_count > 1 && addAnimation.value < 1) {
      final t = addAnimation.value;
      final oldOffsets = computeOffsets(_count - 1);
      for (var i = 0; i < _count - 1; i++) {
        offsets[i] = Offset.lerp(oldOffsets[i], offsets[i], t)!;
      }
      offsets[_count - 1] = Offset.lerp(
        oldOffsets[_count - 2],
        offsets[_count - 1],
        t,
      )!;
    }

    final path = Path()..addPolygon(offsets, true);
    canvas.drawPath(
      path,
      Paint()
        ..blendMode = BlendMode.lighten
        ..color = color
        ..strokeWidth = _thickness
        ..style = PaintingStyle.stroke,
    );
  }

  double map(
      double x, double minIn, double maxIn, double minOut, double maxOut) {
    return (x - minIn) * (maxOut - minOut) / (maxIn - minIn) + minOut;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class CircleWavePainterReversed extends CustomPainter {
  CircleWavePainterReversed(
    this.animation,
    this.addAnimation,
    this.index,
    this.color, {
    int? edgeCount,
    int? radius,
    int? wavesAmount,
    double? thickness,
  })  : _count = edgeCount ?? 140,
        _radius = radius ?? 160,
        _wavesAmount = wavesAmount ?? 10,
        _thickness = thickness ?? 4,
        super(repaint: animation);
  final Animation<double> animation;
  final Animation<double> addAnimation;
  final int index;
  final Color color;
  final int _count;
  final int _radius;
  final int _wavesAmount;
  final double _thickness;

  static const halfPi = math.pi / 12;
  static const twoPi = math.pi * 2;

  @override
  void paint(Canvas canvas, Size size) {
    final t = animation.value;
    final halfWidth = size.width / 2;
    final halfHeight = size.height / 2;
    final q = index * halfPi;

    List<Offset> computeOffsets(int length) {
      final offsets = <Offset>[];
      for (var i = 0; i < length; i++) {
        final th = i * twoPi / length;
        double os = map(math.cos(th - twoPi * t), -1, 1, 0, 1);
        os = 0.05125 * math.pow(os, 0.75);
        final r = _radius *
            (1 + os * math.cos(_wavesAmount * th + 1.5 * twoPi * t + q));
        offsets.add(Offset(
            r * math.sin(th) + halfWidth, -r * math.cos(th) + halfHeight));
      }
      return offsets;
    }

    final offsets = computeOffsets(_count);

    if (_count > 1 && addAnimation.value < 1) {
      final t = addAnimation.value;
      final oldOffsets = computeOffsets(_count - 1);
      for (var i = 0; i < _count - 1; i++) {
        offsets[i] = Offset.lerp(oldOffsets[i], offsets[i], t)!;
      }
      offsets[_count - 1] = Offset.lerp(
        oldOffsets[_count - 2],
        offsets[_count - 1],
        t,
      )!;
    }

    final path = Path()..addPolygon(offsets, true);
    canvas.drawPath(
      path,
      Paint()
        ..blendMode = BlendMode.lighten
        ..color = color
        ..strokeWidth = _thickness
        ..style = PaintingStyle.stroke,
    );
  }

  double map(
      double x, double minIn, double maxIn, double minOut, double maxOut) {
    return (x - minIn) * (maxOut - minOut) / (maxIn - minIn) + minOut;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
