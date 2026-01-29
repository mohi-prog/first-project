class SummaryItem {
  final String inputText;
  final String summaryText;
  final DateTime date;

  SummaryItem({
    required this.inputText,
    required this.summaryText,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
    'inputText': inputText,
    'summaryText': summaryText,
    'date': date.toIso8601String(),
  };

  factory SummaryItem.fromJson(Map<String, dynamic> json) {
    return SummaryItem(
      inputText: json['inputText'],
      summaryText: json['summaryText'],
      date: DateTime.parse(json['date']),
    );
  }
}
