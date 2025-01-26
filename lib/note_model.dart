class Note {
  final String text;
  final DateTime createdAt;

  Note({
    required this.text,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      text: json['text'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
