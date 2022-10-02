import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sa3_liquid/liquid/plasma/plasma.dart';
import 'package:video_club/animation/animated_wave.dart';
import 'package:video_club/home/home_page.dart';
import 'package:video_club/launch/launch_cubit.dart';
import 'package:video_club/launch/launch_states.dart';
import 'package:video_club/launch/scale_route.dart';
import 'package:video_club/models/Result.dart';

import '../home/home_cubit.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({Key? key, required this.username, required this.cubit})
      : super(key: key);
  final String username;
  final LaunchCubit cubit;

  @override
  State<LaunchPage> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController addPointController;
  late Animation<double> addPointAnimation;
  double _circleWidth = 200;
  double _circleHeight = 200;
  int _animationDuration = 1000;
  late Animation<double> size;
  late Timer _periodicTimer;
  String showText = 'Welcome!';
  final String doneText = 'Done!';
  final streamController = StreamController<String>();
  int _counter = 0;
  Result? result;

  List<String> texts = [
    'Data is being processed',
    'Please wait...',
    'Processing...',
    'Processing...',
    'Processing...',
    'Hey, you here?',
    'Just a sec...',
  ];

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      upperBound: 2,
      duration: const Duration(seconds: 10),
    )..repeat();
    size = Tween<double>(begin: 200.0, end: 800.0).animate(controller);
    addPointController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    addPointAnimation =
        addPointController.drive(CurveTween(curve: Curves.ease));

    // context.read<LaunchCubit>().getResult(username: widget.username);
    _periodicTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        showText = texts[_counter];
        _counter++;
        if (_counter == texts.length) _counter = 0;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    _periodicTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LaunchCubit, LaunchState>(builder: (context, state) {
        // if (state is LoadedState)
        //   Navigator.pushReplacement(
        //       context,
        //       ScaleRoute(
        //           page: BlocProvider(
        //               create: (_) => HomeCubit(),
        //               child: HomePage(result: state.result))));
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xff232020),
              ),
            ),
            Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    tileMode: TileMode.mirror,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xff232020),
                      Color(0xff222248),
                    ],
                    stops: [
                      0,
                      1,
                    ],
                  ),
                  backgroundBlendMode: BlendMode.srcOver,
                ),
                child: Container(
                  child: const PlasmaRenderer(
                    type: PlasmaType.infinity,
                    particles: 10,
                    color: Color(0x227223e4),
                    blur: 0.51,
                    size: 1.02,
                    speed: 1.32,
                    offset: 1.96,
                    blendMode: BlendMode.plus,
                    particleType: ParticleType.atlas,
                    variation1: 0.08,
                    variation2: 0,
                    variation3: 0,
                    rotation: -0.76,
                    fps: 18,
                  ),
                )),
            Center(
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x8131108D),
                        blurRadius: 10,
                        spreadRadius: 20)
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(_circleWidth)),
                  child: AnimatedContainer(
                    width: _circleWidth,
                    height: _circleHeight,
                    duration: Duration(milliseconds: _animationDuration),
                    child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                          gradient: LinearGradient(
                            tileMode: TileMode.mirror,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0x81050110),
                              Color(0xff2b2b5d),
                            ],
                            stops: [
                              0,
                              1,
                            ],
                          ),
                          backgroundBlendMode: BlendMode.srcOut,
                        ),
                        child: const PlasmaRenderer(
                          type: PlasmaType.circle,
                          particles: 37,
                          color: Color(0x504118c3),
                          blur: 0.61,
                          size: 1.14,
                          speed: 4.59,
                          offset: 1.66,
                          blendMode: BlendMode.screen,
                          particleType: ParticleType.atlas,
                          variation1: 0.14,
                          variation2: 0.11,
                          variation3: 0.24,
                          rotation: -1.58,
                        )),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                print('onTap');
              },
              child: Center(
                child: SizedBox(
                  width: 140,
                  child: Text(
                    showText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color:
                            Theme.of(context).backgroundColor.withOpacity(0.5)),
                  ),
                ),
              ),
            ),
            for (int i = 0; i < 3; i++)
              Positioned.fill(
                child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeIn,
                  builder: (_, double opacity, __) {
                    return CustomPaint(
                      painter: CircleWavePainter(
                          controller, addPointAnimation, i, Color(0xff4336bd),
                          radius: 99,
                          thickness: 3,
                          wavesAmount: 7,
                          petalHeight: 0.06,
                          reversed: true),
                    );
                  },
                ),
              ),
            for (int i = 0; i < 3; i++)
              Positioned.fill(
                child: TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeIn,
                  builder: (_, double opacity, __) {
                    return CustomPaint(
                      painter: CircleWavePainter(
                          controller, addPointAnimation, i, Colors.deepPurple,
                          radius: 100,
                          thickness: 5,
                          wavesAmount: 7,
                          petalHeight: 0.05),
                    );
                  },
                ),
              ),
            GestureDetector(
              onTap: () async {
                final res = await getResult(username: widget.username);
                if (res != null)
                  Navigator.pushReplacement(
                      context,
                      ScaleRoute(
                          page: BlocProvider(
                              create: (_) => HomeCubit(),
                              child: HomePage(result: res))));
              },
              child: Center(
                child: Container(
                  height: 400,
                  width: 400,
                  color: Colors.transparent,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: SafeArea(
                child: Image.asset(
                  'assets/images/icon.jpg',
                  scale: 7,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Future<Result?> getResult({required String username}) async {
    try {
      final String response = await rootBundle
          .loadString('lib/data/${username.toLowerCase()}_data.json');
      final data = await json.decode(response);
      final result = Result.fromJson(data);
      return result;
    } catch (e) {
      print('Error while getting results: $e');
    }
    return null;
  }
}
