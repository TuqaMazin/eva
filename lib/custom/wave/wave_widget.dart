import 'dart:async';
import 'dart:math';

import 'package:flutter/widgets.dart';

import 'config.dart';

class WaveWidget extends StatefulWidget {
  final Config config;
  final Size size;
  final double waveAmplitude;
  final double wavePhase;
  final double waveFrequency;
  final double heightPercentage;
  final int? duration;
  final Color? backgroundColor;
  final DecorationImage? backgroundImage;
  final bool isLoop;
  final double viewCenter;

  const WaveWidget({
    super.key,
    required this.config,
    required this.size,
    this.waveAmplitude = 20.0,
    this.wavePhase = 10.0,
    this.waveFrequency = 1.6,
    this.heightPercentage = 0.2,
    this.duration = 6000,
    this.backgroundColor,
    this.backgroundImage,
    this.isLoop = true,
    required this.viewCenter,
  });

  @override
  State<StatefulWidget> createState() => _WaveWidgetState();
}

class _WaveWidgetState extends State<WaveWidget> with TickerProviderStateMixin {
  late List<AnimationController> _waveControllers;
  late List<Animation<double>> _wavePhaseValues;

  final List<double> _waveAmplitudes = [];
  Map<Animation<double>, AnimationController>? valueList;
  Timer? _endAnimationTimer;

  _initAnimations() {
    if (widget.config.colorMode == ColorMode.custom) {
      _waveControllers =
          (widget.config as CustomConfig).durations!.map((duration) {
        _waveAmplitudes.add(widget.waveAmplitude + 10);
        return AnimationController(
            vsync: this, duration: Duration(milliseconds: duration));
      }).toList();

      _wavePhaseValues = _waveControllers.map((controller) {
        CurvedAnimation curve =
            CurvedAnimation(parent: controller, curve: Curves.easeInOut);
        Animation<double> value = Tween(
          begin: widget.wavePhase,
          end: 360 + widget.wavePhase,
        ).animate(
          curve,
        );
        value.addStatusListener((status) {
          switch (status) {
            case AnimationStatus.completed:
              controller.reverse();
              break;
            case AnimationStatus.dismissed:
              controller.forward();
              break;
            default:
              break;
          }
        });
        controller.forward();
        return value;
      }).toList();

      /// If isLoop is false, stop the animation after the specified duration.
      if (!widget.isLoop) {
        _endAnimationTimer =
            Timer(Duration(milliseconds: widget.duration!), () {
          for (AnimationController waveController in _waveControllers) {
            waveController.stop();
          }
        });
      }
    }
  }

  _buildPaints() {
    List<Widget> paints = [];
    if (widget.config.colorMode == ColorMode.custom) {
      List<Color>? colors = (widget.config as CustomConfig).colors;
      List<List<Color>>? gradients = (widget.config as CustomConfig).gradients;
      Alignment? begin = (widget.config as CustomConfig).gradientBegin;
      Alignment? end = (widget.config as CustomConfig).gradientEnd;
      for (int i = 0; i < _wavePhaseValues.length; i++) {
        paints.add(
          CustomPaint(
            painter: _CustomWavePainter(
                color: colors == null ? null : colors[i],
                gradient: gradients == null ? null : gradients[i],
                gradientBegin: begin,
                gradientEnd: end,
                heightPercentage:
                    (widget.config as CustomConfig).heightPercentages![i],
                repaint: _waveControllers[i],
                waveFrequency: widget.waveFrequency,
                wavePhaseValue: _wavePhaseValues[i],
                waveAmplitude: _waveAmplitudes[i],
                blur: (widget.config as CustomConfig).blur,
                viewCenter: widget.viewCenter),
            size: widget.size,
          ),
        );
      }
    }
    return paints;
  }

  _disposeAnimations() {
    for (var controller in _waveControllers) {
      controller.dispose();
    }
  }

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  @override
  void dispose() {
    _disposeAnimations();
    _endAnimationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        image: widget.backgroundImage,
      ),
      child: Stack(
        children: _buildPaints(),
      ),
    );
  }
}

/// Meta data of layer
class Layer {
  final Color? color;
  final List<Color>? gradient;
  final MaskFilter? blur;
  final Path? path;
  final double? amplitude;
  final double? phase;

  Layer({
    this.color,
    this.gradient,
    this.blur,
    this.path,
    this.amplitude,
    this.phase,
  });
}

class _CustomWavePainter extends CustomPainter {
  final Color? color;
  final List<Color>? gradient;
  final Alignment? gradientBegin;
  final Alignment? gradientEnd;
  final MaskFilter? blur;
  final double? viewCenter;

  double? waveAmplitude;

  Animation<double>? wavePhaseValue;

  double? waveFrequency;

  double? heightPercentage;

  double _tempA = 0.0;
  double _tempB = 0.0;
  double viewWidth = 0.0;
  final Paint _paint = Paint();

  _CustomWavePainter(
      {this.color,
      this.gradient,
      this.gradientBegin,
      this.gradientEnd,
      this.blur,
      this.viewCenter,
      this.heightPercentage,
      this.waveFrequency,
      this.wavePhaseValue,
      this.waveAmplitude,
      super.repaint});

  _setPaths(double viewCenterY, Size size, Canvas canvas) {
    Layer layer = Layer(
      path: Path(),
      color: color,
      gradient: gradient,
      blur: blur,
      amplitude: (-1.6 + 0.8) * waveAmplitude!,
      phase: wavePhaseValue!.value * 2 + 30,
    );

    layer.path!.reset();
    layer.path!.moveTo(
        0.0,
        viewCenterY +
            layer.amplitude! * _getSinY(layer.phase!, waveFrequency!, -1));
    for (int i = 1; i < size.width + 1; i++) {
      layer.path!.lineTo(
          i.toDouble(),
          viewCenterY +
              layer.amplitude! * _getSinY(layer.phase!, waveFrequency!, i));
    }

    layer.path!.lineTo(size.width, size.height);
    layer.path!.lineTo(0.0, size.height);
    layer.path!.close();
    if (layer.color != null) {
      _paint.color = layer.color!;
    }
    if (layer.gradient != null) {
      var rect = Offset.zero &
          Size(size.width, size.height - viewCenterY * heightPercentage!);
      _paint.shader = LinearGradient(
              begin: gradientBegin == null
                  ? Alignment.bottomCenter
                  : gradientBegin!,
              end: gradientEnd == null ? Alignment.topCenter : gradientEnd!,
              colors: layer.gradient!)
          .createShader(rect);
    }
    if (layer.blur != null) {
      _paint.maskFilter = layer.blur;
    }

    _paint.style = PaintingStyle.fill;
    canvas.drawPath(layer.path!, _paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    double viewCenterY = size.height - viewCenter!;
    viewWidth = size.width;
    _setPaths(viewCenterY, size, canvas);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  double _getSinY(
      double startradius, double waveFrequency, int currentposition) {
    if (_tempA == 0) {
      _tempA = pi / viewWidth;
    }
    if (_tempB == 0) {
      _tempB = 2 * pi / 360.0;
    }

    return (sin(
        _tempA * waveFrequency * (currentposition + 1) + startradius * _tempB));
  }
}
