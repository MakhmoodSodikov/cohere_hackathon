import 'package:flutter/material.dart';
import 'package:video_club/account/account_page.dart';
import 'package:video_club/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Club',
      color: AppColors.primaryColor,
      theme: ThemeData(
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          }),
          primarySwatch: Colors.deepPurple),
      home: AccountPage(),
    );
  }
}
