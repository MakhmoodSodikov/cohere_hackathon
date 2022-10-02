import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sa3_liquid/liquid/plasma/plasma.dart';
import 'package:video_club/account/account_cubit.dart';
import 'package:video_club/account/account_states.dart';
import 'package:video_club/account/account_text_field.dart';
import 'package:video_club/launch/launch_cubit.dart';
import 'package:video_club/launch/launch_page.dart';

import 'enter_exit_effect.dart';

class AccountPage extends StatelessWidget {
  AccountPage({Key? key}) : super(key: key);
  TextEditingController controller = TextEditingController();
  List<String> usernames = [
    'eminem',
    'trump',
    'billieeilish',
    'elonmusk',
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: BlocProvider(
                create: (_) => AccountCubit(),
                child: BlocBuilder<AccountCubit, AccountState>(
                    builder: (context, state) {
                  final cubit = context.read<AccountCubit>();
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Image.asset(
                          'assets/images/icon.jpg',
                          scale: 5,
                        ),
                      ),
                      Expanded(
                        child: AccountTextField(
                          enabled: true,
                          onButtonTap: (username) async {
                            final userExists =
                                await cubit.verifyTwitterAccount(username);
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (usernames.contains(username.toLowerCase()))
                              Navigator.push(
                                  context,
                                  EnterExitRoute(
                                      exitPage: AccountPage(),
                                      enterPage: BlocProvider(
                                        create: (_) => LaunchCubit(),
                                        child: LaunchPage(
                                          username: username,
                                          cubit: LaunchCubit(),
                                        ),
                                      )));
                          },
                          isLoading: state is LoadingState,
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
