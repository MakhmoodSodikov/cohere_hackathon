class Result {
  final String username;
  final String summary;
  final String urls;
  final String hashtags;
  final String emojis;
  final String mood;
  Result({
    required this.username,
    required this.summary,
    required this.urls,
    required this.hashtags,
    required this.emojis,
    required this.mood,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      username: json['username'],
      hashtags: json['hashtags'],
      summary: json['summary'],
      urls: json['urls'],
      emojis: json['emojis'],
      mood: json['mood'],
    );
  }
}
