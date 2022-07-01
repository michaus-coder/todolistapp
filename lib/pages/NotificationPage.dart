import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Allow Notifications"),
              content: Text("Our Apps would like to send you notifications"),
              actions: [
                TextButton(
                  onPressed: () {
                    AwesomeNotifications()
                        .requestPermissionToSendNotifications()
                        .then((_) => Navigator.pop(context));
                  },
                  child: Text(
                    "Allow",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Dont Allow",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          );
        } else {
          print("Notification allowed");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
      ),
      body: Container(
        child: Column(
          children: [
            Builder(builder: (context) {
              return ElevatedButton(
                  onPressed: () {
                    AwesomeNotifications().createNotification(
                      content: NotificationContent(
                          id: 10,
                          channelKey: 'basic_channel',
                          title: 'Simple Notification',
                          body: 'Simple body'),
                      schedule: NotificationInterval(
                          interval: 10,
                          timeZone: 'Asia/Jakarta',
                          preciseAlarm: true),
                    );
                  },
                  child: Text("Notification Test Button"));
            })
          ],
        ),
      ),
    );
  }
}
