import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<Map<String, String>> notifications = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://nowcasting.bmkg.go.id/cap/xml/id/newsflash.xml'));

    if (response.statusCode == 200) {
      final responseBody = response.body;
      final document = xml.XmlDocument.parse(responseBody);
      final items = document.findAllElements('data');

      List<Map<String, String>> tempNotifications = [];

      for (var item in items) {
        final headline = item.findElements('headline').single.text;
        final dateUpdate = item.findElements('date_update').single.text;
        final description = item.findElements('description').single.text;

        tempNotifications.add({
          'headline': headline,
          'date_update': dateUpdate,
          'description': description,
        });
      }

      setState(() {
        notifications = tempNotifications;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Card(
              elevation: 2.0,
              child: ListTile(
                leading: const Icon(Icons.warning),
                title: Text(notification['headline'] ?? ''),
                subtitle: Text(notification['date_update'] ?? ''),
                onTap: () {
                  _showNotificationDialog(context, notification['headline'] ?? '', notification['description'] ?? '');
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void _showNotificationDialog(BuildContext context, String headline ,String description) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(headline),
          content: SingleChildScrollView(
            child: Text(description),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
