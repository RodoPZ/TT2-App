import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class NotificationPlugin{
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetails() async{
    return const NotificationDetails(
      android: AndroidNotificationDetails(
          'channel id',
          'channel name',
          channelDescription: 'channel description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker'),
    );
  }

  static Future init({bool initScheduled = false}) async{
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettings = InitializationSettings(android: android);

    ///When closed
    final details = await _notifications.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp){
      onNotifications.add(details.payload);
    }

    await _notifications.initialize(
        initializationSettings,
        onSelectNotification: (payload) async {
          onNotifications.add(payload);
        },
    );

    if(initScheduled){
      tz.initializeTimeZones();
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }
  }

  static Future showNotification({
    required int id,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate,
  }) async{
    final now = tz.TZDateTime.now(tz.local);
    _notifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate.isBefore(now) ? scheduledDate.add(Duration(days: 1)) : scheduledDate, tz.local),
      await _notificationDetails(),
      payload: payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future showDailyNotification({
    required id,
    String? title,
    String? body,
    String? payload,
    required int horas,
    required int minutos,
  }) async => _notifications.zonedSchedule(
        id, // choose for each notification an index that is unique
        title,
        body,
        _scheduleDaily(Time(horas,minutos)),
        await _notificationDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );

  static void showWeeklyNotification({
    required int id,
    String? title,
    String? body,
    String? payload,

    required int horas,
    required int minutos,
    required List<int> days,
  }) async {
    final scheduledDates =
    _scheduleWeekly(Time(horas, minutos), days: days);

    for (int i = 0; i < scheduledDates.length; i++) {
      final scheduledDate = scheduledDates[i];
      _notifications.zonedSchedule(
        id + i, // choose for each notification an index that is unique
        title,
        body,
        scheduledDate,
        await _notificationDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      );
    }
  }

  static tz.TZDateTime _scheduleDaily(Time time){
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate = tz.TZDateTime(tz.local,now.year,now.month,now.day,time.hour,time.minute,time.second);
    return scheduledDate.isBefore(now) ? scheduledDate.add(Duration(days: 1)) : scheduledDate;
  }

  static List<tz.TZDateTime> _scheduleWeekly(Time time,
      {required List<int> days}) {
    return days.map((day) {
      tz.TZDateTime scheduledDate = _scheduleDaily(time);

      while (day != scheduledDate.weekday) {
        scheduledDate = scheduledDate.add(Duration(days: 1));
      }
      return scheduledDate;
    }).toList();
  }

  static Future<void> RetrieveNotifications() async {
    final List<PendingNotificationRequest> pendingNotificationRequests = await _notifications
        .pendingNotificationRequests();
    for (var notification in pendingNotificationRequests){
      print(notification.body);
    }
  }

  static Future<void> CancelAllContifications() async {
    await _notifications.cancelAll();
  }
}