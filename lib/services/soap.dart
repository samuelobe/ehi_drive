import 'dart:io';
import 'dart:convert';

import 'package:ehidrive/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:device_info/device_info.dart';

class SOAP {
  final String apiKey = "B73C9433-A251-40A5-B60C-A8EA5D35E79F";
  final String apiURL = "https://ehix.ehiconnect.com/ws2/pin.asmx";
  final String deviceType = Platform.isIOS ? "iOS" : "Android";

  Future<String> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

  String _createRequestBody(String body) {
    var requestBody = """ 
<?xml version="1.0" encoding="utf-8"?>
<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">
  <soap12:Body>
    $body
  </soap12:Body>
</soap12:Envelope>""";

    return requestBody;
  }

  Map<String, String> _createHeaders(String soapAction) {
    var headers = {
      "Content-Type": "text/xml; charset=utf-8",
      "Host": "ehix.ehiconnect.com",
      "SOAPAction": soapAction
    };

    return headers;
  }

  Future<http.Response> postVerifyDevice() async {
    String deviceID = await _getId();
    http.Response response;
    var body = """ 
<VerifyDevice_1_2_2 xmlns="http://emr.ehiconnect.com/">
  <sApikey>$apiKey</sApikey>
  <sDeviceId>$deviceID</sDeviceId>
  <sAppVersion>"1.0.0"</sAppVersion>
  <sRegisterId>123456</sRegisterId> 
</VerifyDevice_1_2_2>""";

    var requestBody = _createRequestBody(body);
    var headers =
        _createHeaders('http://emr.ehiconnect.com/VerifyDevice_1_2_2');

    response = await http.post(
      apiURL,
      headers: headers,
      body: utf8.encode(requestBody),
    );

    print(deviceID);

    return response;
  }

  Future<http.Response> postRegisterDevice(
      {@required String pin, @required String userID}) async {
    var deviceID = await _getId();
    http.Response response;
    var body = """
<RegisterDevice xmlns="http://emr.ehiconnect.com/">
  <sApikey>$apiKey</sApikey>
  <sUserId>$userID</sUserId>
  <sDeviceId>$deviceID</sDeviceId>
  <sRegisterId>123456</sRegisterId>
  <sPin>$pin</sPin>
</RegisterDevice>""";

    var requestBody = _createRequestBody(body);
    var headers = _createHeaders("http://emr.ehiconnect.com/RegisterDevice");

    response = await http.post(
      apiURL,
      headers: headers,
      body: utf8.encode(requestBody),
    );

    return response;
  }

  Future<http.Response> postVerifyUser({@required User user}) async {
    String username = user.username;
    String password = user.password;
    String deviceID = await _getId();
    String systemData = "$deviceID-$deviceType-1.0.0";
    var body = """
<VerifyUser xmlns="http://emr.ehiconnect.com/">
  <sApikey>$apiKey</sApikey>
  <sUserId>$username</sUserId>
  <sPassword>$password</sPassword>
  <sDeviceId>$deviceID</sDeviceId>
  <sSysData>$systemData</sSysData>
</VerifyUser>""";

    var requestBody = _createRequestBody(body);
    var headers = _createHeaders("http://emr.ehiconnect.com/VerifyUser");

    http.Response response = await http.post(
      apiURL,
      headers: headers,
      body: utf8.encode(requestBody),
    );
    print(deviceID);
    return response;
  }
}
