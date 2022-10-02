import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_club/launch/launch_states.dart';
import 'package:video_club/models/Result.dart';

class LaunchCubit extends Cubit<LaunchState> {
  LaunchCubit() : super(InitState());

  String? _contentsCollection;

  getResult({required String username}) async {
    emit(LoadingState());
    try {
      final String response = await rootBundle
          .loadString('lib/data/${username.toLowerCase()}_data.json');
      final data = await json.decode(response);
      print('DATA: $data');
      final result = Result.fromJson(data);
      print('Result: $result');
      emit(LoadedState(result: result));
    } catch (e) {
      print('Error while getting results: $e');
    }
  }
}

class Content {
  String username;
  String content;

  Content({required this.username, required this.content});

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(username: json['username'], content: json['content']);
  }
}
