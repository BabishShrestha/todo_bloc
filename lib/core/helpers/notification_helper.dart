import 'dart:developer';
import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../features/todo/pages/todo_notification_page.dart';
import '../models/task_model.dart';

class NotificationHelper {
  final WidgetRef ref;
  NotificationHelper({required this.ref});

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  String? selectedNotificationPayload;
  final BehaviorSubject<String?> selectNotificationSubject =
      BehaviorSubject<String?>();

  initializeNotification() async {
    requestDevicePermissions();
    _configureSelectNotificationSubject();

    await _configureLocalTimeZone();
    final DarwinInitializationSettings initializationSettingsIos =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('calender');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: initializationSettingsIos,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (data) async {
      if (data != null) {
        log('notification payload: ${data.payload}');
      }
      selectNotificationSubject.add(data.payload);
    });
  }

  void requestDevicePermissions() {
    if (Platform.isIOS) {
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestPermission();
    }
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    const String timeZoneName = "Asia/Shanghai";
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    showDialog(
        context: ref.context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text(title ?? ""),
              content: Text(body ?? ""),
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                CupertinoDialogAction(
                  child: const Text('View'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  scheduleNotification(
      int days, int hours, int minutes, int seconds, Task task) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        task.id ?? 0,
        task.title,
        task.desc,
        tz.TZDateTime.now(tz.local).add(Duration(
            days: days, hours: hours, minutes: minutes, seconds: seconds)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
          'channel id',
          'channel name',
        )),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload:
            "${task.title}|${task.desc}|${task.date}|${task.startTime}|${task.endTime}");
  }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String? payload) async {
      final title = payload!.split('|')[0];

      final body = payload.split('|')[1];
      showDialog(
        context: ref.context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(title),
          content: Text(
            body,
            textAlign: TextAlign.justify,
            maxLines: 4,
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Close'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              child: const Text('View'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            NotificationPage(payload: payload)));
              },
            )
          ],
        ),
      );
    });
  }
}
