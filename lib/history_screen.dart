import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'summary_item.dart';
import 'summary_detail_page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<SummaryItem> items = [];
  final String resultText = '';

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList('history') ?? [];

    setState(() {
      items = list.map((e) => SummaryItem.fromJson(jsonDecode(e))).toList();
    });
  }

  Future<void> _deleteItem(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList('history') ?? [];

    list.removeAt(index);
    await prefs.setStringList('history', list);

    setState(() {
      items.removeAt(index);
    });
  }

  Future<void> _clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('history');

    setState(() {
      items.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'History',
          style: TextStyle(
            color: Colors.blue,
            fontFamily: 'Jersey',
            fontSize: 30,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete_forever,
              color: Colors.blue,
              size: 40,
            ),
            onPressed: _clearHistory,
          ),
        ],
      ),
      body: items.isEmpty
          ? const Center(child: Text('Keine Einträge'))
          : ListView.builder(
              itemCount: items.length,

              itemBuilder: (context, i) {
                final item = items[i];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(
                      item.summaryText,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(item.date.toLocal().toString()),
                    onLongPress: () => _deleteItem(i),

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SummaryDetailPage(
                            item: item,
                            resultText: resultText,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
