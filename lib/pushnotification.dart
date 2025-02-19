import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'dart:convert';

class PushNotificationServiceStaffs {
  static Future<String> getAccessToken(serviceAccountJson) async {
    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging",
      'https://www.googleapis.com/auth/cloud-platform',
    ];

    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );

    // Get the access token
    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
      client,
    );

    client.close();
    print("this is token ${credentials.accessToken.data}");
    return credentials.accessToken.data;
  }

  static sendNotificationToSelected(
    String deviceToken,
    String title,
    String body,
    String serverKey,
    String projectKeyController
  ) async {
    try {
      String endpointFirebaseCloudMessaging =
          'https://fcm.googleapis.com/v1/projects/$projectKeyController/messages:send';

      final Map<String, dynamic> message = {
        'message': {
          'token': deviceToken,
          'notification': {'title': title, 'body': body},
          'data': {'tripID': "tripID"}
        }
      };

      final http.Response response = await http.post(
        Uri.parse(endpointFirebaseCloudMessaging),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $serverKey'
        },
        body: jsonEncode(message),
      );
      print(response.body);
      if (response.statusCode == 200) {
        print("Notification sent successfully.");
      } else {
        print("Failed to send notification.");
      }
    } catch (e) {
      print(e);
    }
  }
}
