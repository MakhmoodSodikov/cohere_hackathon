import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sa3_liquid/liquid/plasma/plasma.dart';
import 'package:video_club/home/home_cubit.dart';
import 'package:video_club/home/home_states.dart';
import 'package:video_club/models/Result.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.result}) : super(key: key);

  final Result result;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late HomeCubit _homeCubit;

  late AnimationController controller;
  late AnimationController addPointController;
  late Animation<double> addPointAnimation;
  int _counter = 1;
  bool showLiquid = false;
  List<String> titles = [
    'Username',
    'Hashtags',
    'Urls',
    'Current Mood',
    'Summary',
    'Emojis',
  ];

  late Map<int, String> resultMap;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      upperBound: 2,
      duration: const Duration(seconds: 10),
    )..repeat();
    addPointController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    addPointAnimation =
        addPointController.drive(CurveTween(curve: Curves.ease));

    resultMap = {
      0: widget.result.username,
      1: widget.result.hashtags,
      2: widget.result.urls,
      3: widget.result.mood,
      4: widget.result.summary,
      5: widget.result.emojis,
    };
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _generatedText() {
    _homeCubit.generateTextWithPrompt('none');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
        _homeCubit = context.read<HomeCubit>();
        return Center(
          child: Stack(
            children: [
              Container(
                color: Colors.black,
              ),
              Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      tileMode: TileMode.mirror,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xff232020),
                        Color(0xff2b2b5d),
                      ],
                      stops: [
                        0,
                        1,
                      ],
                    ),
                    backgroundBlendMode: BlendMode.srcOver,
                  ),
                  child: const PlasmaRenderer(
                    type: PlasmaType.infinity,
                    particles: 14,
                    color: Color(0x447223e4),
                    blur: 0.51,
                    size: 1.02,
                    speed: 4.32,
                    offset: 1.96,
                    blendMode: BlendMode.darken,
                    particleType: ParticleType.atlas,
                    variation1: 0.08,
                    variation2: 0,
                    variation3: 0,
                    rotation: -0.76,
                    fps: 18,
                  )),
              SafeArea(
                child: ListView(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  physics: BouncingScrollPhysics(),
                  children: <Widget>[
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 24),
                      child: Text(
                        'Your Tweets Info',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 32,
                            color: Theme.of(context).backgroundColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: titles.length,
                        itemBuilder: (context, index) {
                          return _listTile(
                              titles[index], resultMap.values.elementAt(index));
                        },
                        separatorBuilder: (context, index) =>
                            index != titles.length
                                ? Divider(
                                    thickness: 0.2,
                                    color: Theme.of(context).backgroundColor,
                                  )
                                : SizedBox(),
                      ),
                    ),
                    SizedBox(
                      height: 26,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _listTile(String title, String result) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Theme.of(context).backgroundColor,
                fontSize: 18,
                fontWeight: FontWeight.w800),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  result,
                  style: TextStyle(
                      fontFamily: 'SF',
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 15.4,
                      fontWeight: FontWeight.w800),
                ),
              ),
              IconButton(
                  onPressed: () =>
                      Clipboard.setData(ClipboardData(text: result)),
                  icon: Icon(
                    Icons.copy_all_rounded,
                    color: Colors.white.withOpacity(0.5),
                    size: 22,
                  ))
            ],
          ),
        ],
      ),
    );
  }

  _stringToList(String) {}
}
