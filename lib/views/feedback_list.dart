import 'package:flutter/material.dart';
import '../service/sheet_api.dart';
import '../model/form.dart';

class FeedbackListScreen extends StatelessWidget {
  const FeedbackListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feedback Responses',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FeedbackListPage(title: "Responses"),
    );
  }
}

class FeedbackListPage extends StatefulWidget {
  final String title;

  const FeedbackListPage({super.key, required this.title});

  @override
  State<FeedbackListPage> createState() => _FeedbackListPageState();
}

class _FeedbackListPageState extends State<FeedbackListPage> {
  List<FeedbackForm> feedbackItems = [];

  @override
  void initState() {
    super.initState();

    SheetAPI().getFeedbackList().then((items) {
      setState(() {
        feedbackItems = items;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView.builder(
        itemCount: feedbackItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Row(
              children: <Widget>[
                Icon(Icons.person),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "${feedbackItems[index].name} (${feedbackItems[index].email})",
                  ),
                ),
              ],
            ),
            subtitle: Row(
              children: <Widget>[
                Icon(Icons.message),
                SizedBox(width: 8),
                Expanded(child: Text(feedbackItems[index].feedback)),
              ],
            ),
          );
        },
      ),
    );
  }
}
