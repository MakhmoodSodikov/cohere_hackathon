class GeneratedResponse {
  final String id;
  final String text;
  final String prompt;

  GeneratedResponse(
      {required this.id, required this.text, required this.prompt});

  factory GeneratedResponse.fromJson(Map<String, dynamic> json) {
    final text = (((json['generations'] as List).first) as Map<String, dynamic>)
        .values
        .first;
    return GeneratedResponse(
        id: json['id'], text: text, prompt: json['prompt']);
  }
}
