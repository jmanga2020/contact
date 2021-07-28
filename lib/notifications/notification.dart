import 'package:onesignal_flutter/onesignal_flutter.dart';

class CloudNotifications {
  //onesignal push notification service

  ///initializes pushNotifications eachtime the app is visited
  static Future<void> initNotifications(
      {bool debug = false,
      Function onNotificationReceived,
      Function onNotificationOpened}) async {
    if (debug) {
      OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    }

    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      event.complete(event.notification);
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      onNotificationOpened(result);
    });

    OneSignal.shared.disablePush(false);

    await OneSignal.shared.setAppId('16dba901-a018-46a6-82f9-d20e389ac466');
  }

  ///get a subscribed user token called after acceptance
  static Future<String> getSubscriberId() async {
    String _id;
    await OneSignal.shared.getDeviceState().then((value) {
      _id = value.userId;
      //  value.subscriptionStatus.userId;
    });
    return _id;
  }

  ///allows a service to send notifications[call this on log out with FALSE]
  static Future<void> subscribeUser(bool enableNotification) async {
    await OneSignal.shared.consentGranted(enableNotification);
  }

  ///set a playedId[custom] of a user each time in signIn & Up
  static Future<void> setUserNotificationId(String iD) async {
    await OneSignal.shared.setExternalUserId(iD);
  }

  ///removes custom user ID when[LoggedOut]
  static Future<void> removeUserNotificationId(String iD) async {
    await OneSignal.shared.removeExternalUserId();
  }

  ///called when a user has accepted to be notified[call this on log out with FALSE]
  static Future<void> acceptNotification({bool accepted = true}) async {
    await OneSignal.shared.setRequiresUserPrivacyConsent(accepted);
  }

  ///send notifications to specific user(s)
  static Future<void> sendNotification(
      {List<String> userIds, String body, String title, String sub}) async {
    await OneSignal.shared.postNotification(OSCreateNotification(
        playerIds: userIds, subtitle: sub, content: body, heading: title));
  }

  ///set todo notification
  static Future<void> setTodoNotification(
      {List<String> userId,
      String sub,
      DateTime sendAfter,
      String body,
      String title}) async {
    await OneSignal.shared.postNotification(OSCreateNotification(
        playerIds: userId,
        subtitle: sub,
        sendAfter: sendAfter,
        content: body,
        heading: title,
        androidSound: 'alert'));
  }

  ///set a user tag for later cloud segment called after success subscription
  static Future<void> setUserTagSubscription(
      {Map<String, dynamic> tags}) async {
    await OneSignal.shared.sendTags(tags);
  }

  ///delete tags
  static Future<void> deleteUserTagSubscription({List<String> tags}) async {
    await OneSignal.shared.deleteTags(tags);
  }
}
