class SummaryItem {
  final String text;
  final DateTime date;

  SummaryItem({required this.text, required this.date});

  Map<String, dynamic> toJson() => {
    'text': text,
    'date': date.toIso8601String(),
  };

  factory SummaryItem.fromJson(Map<String, dynamic> json) {
    return SummaryItem(text: json['text'], date: DateTime.parse(json['date']));
  }
}
