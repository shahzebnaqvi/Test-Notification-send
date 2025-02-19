import 'package:flutter/material.dart';
import 'package:sendnotificaion/pushnotification.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NotificationScreen(),
    );
  }
}

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final TextEditingController serverJsonController = TextEditingController();

  final TextEditingController serverKeyController = TextEditingController();
  final TextEditingController projectKeyController = TextEditingController();

  final TextEditingController tokenController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  void sendNotification() {
    String token = tokenController.text;
    String title = titleController.text;
    String body = bodyController.text;

    PushNotificationServiceStaffs.sendNotificationToSelected(token, title, body,
        serverKeyController.text, projectKeyController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Notification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(  keyboardType: TextInputType.multiline,
          minLines: 3,maxLines: 20,
                controller: serverJsonController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Server Json',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final String serverKey =
                      await PushNotificationServiceStaffs.getAccessToken(
                          serverJsonController.text);
                  serverKeyController.text = serverKey;
                },
                child: Text('Get Server Key'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: serverKeyController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Server Key',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: projectKeyController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Project Key',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: tokenController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Token',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: bodyController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Body',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: sendNotification,
                child: Text('Send Notification'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
