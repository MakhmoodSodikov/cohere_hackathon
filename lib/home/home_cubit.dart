import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:video_club/constants.dart';
import 'package:video_club/home/home_states.dart';
import 'package:video_club/models/GeneratedResponse.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(InitState());
  String promptText = 'You look like';

  generateTextWithPrompt(String? text) async {
    text = promptText;
    emit(LoadingState());
    String body = jsonEncode(<String, dynamic>{
      'prompt': text,
      'model': 'xlarge',
      "max_tokens": 20,
      "temperature": 0.9,
      "k": 0,
      "p": 0.75,
      "frequency_penalty": 0,
      "presence_penalty": 0,
      "return_likelihoods": 'NONE'
    });
    final headers = <String, String>{
      'Authorization': 'BEARER $apiKey',
      'Content-Type': 'application/json',
      'Cohere-Version': '2021-11-08',
    };

    final response = await http.post(
      Uri.parse('https://api.cohere.ai/generate'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final generatedText =
          GeneratedResponse.fromJson(jsonDecode(response.body)).text;
      emit(LoadedState(generatedText: generatedText));
    } else {
      print(response.statusCode);
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to get generated text.');
    }
  }
}
