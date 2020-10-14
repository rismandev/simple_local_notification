import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid = AndroidInitializationSettings(
      'app_icon',
    );
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: onSelectNotification,
    );
  }

  Future onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) {
        return new AlertDialog(
          title: Text("PayLoad"),
          content: Text("Payload : $payload"),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Github : rismandev'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomButton(
              text: 'Show Notification Custom Sound',
              onPressed: _showNotificationWithSound,
            ),
            SizedBox(height: 20),
            CustomButton(
              text: 'Show Notification Without Sound',
              onPressed: _showNotificationWithoutSound,
              textColor: Colors.white,
              background: Colors.purple,
            ),
            SizedBox(height: 20),
            CustomButton(
              text: 'Show Notification Default Sound',
              onPressed: _showNotificationWithDefaultSound,
              textColor: Colors.white,
              background: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  // Method 1
  Future _showNotificationWithSound() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'notification_with_sound',
      'notification_with_sound Name',
      'notification_with_sound Description',
      sound: RawResourceAndroidNotificationSound("slow_spring_board"),
      importance: Importance.max,
      priority: Priority.high,
    );
    var iOSPlatformChannelSpecifics =
        new IOSNotificationDetails(sound: "slow_spring_board.aiff");
    var platformChannelSpecifics = new NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      'Title Notification',
      'Description Notification',
      platformChannelSpecifics,
      payload: 'Custom_Sound',
    );
  }

  // Method 2
  Future _showNotificationWithDefaultSound() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'notification_default_sound',
      'notification_default_sound Name',
      'notification_default_sound Description',
      importance: Importance.max,
      priority: Priority.high,
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      'Title Notification',
      'Description Notification',
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  // Method 3
  Future _showNotificationWithoutSound() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'notification_without_sound',
      'notification_without_sound Name',
      'notification_without_sound Description',
      playSound: false,
      importance: Importance.max,
      priority: Priority.high,
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails(
      presentSound: false,
    );
    var platformChannelSpecifics = new NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      'Title Notification',
      'Description Notification',
      platformChannelSpecifics,
      payload: 'No_Sound',
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color background;
  final Color textColor;

  const CustomButton({
    Key key,
    @required this.text,
    this.onPressed,
    this.background,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: RaisedButton(
        padding: EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: this.background ?? Colors.red,
        onPressed: this.onPressed,
        child: Text(
          this.text ?? 'Button',
          style: TextStyle(
            color: this.textColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
