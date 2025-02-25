import 'package:flutter/material.dart';
import 'package:flutter_read_inbox/src/read_inbox.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ReadInbox readInbox = ReadInbox();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('SMS Messages')),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: readInbox.readInboxData(
              url: "https://jsonplaceholder.typicode.com/posts"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No messages found"));
            } else {
              List<Map<String, dynamic>> messages = snapshot.data!;
              return ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  var message = messages[index];
                  return ListTile(
                    leading: Icon(Icons.message, color: Colors.blue),
                    title: Text(message['address'] ?? "Unknown"),
                    subtitle: Text(message['body'] ?? "No message"),
                    trailing: Text(message['date'] ?? ""),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
