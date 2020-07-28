import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

class Auth {
  final String apiKey = "B73C9433-A251-40A5-B60C-A8EA5D35E79F";
  final String apiURL = "https://ehix.ehiconnect.com/ws2/pin.asmx";

  verifyDevice() async {
    var success;
    var errorcode;
    var message;
    var requestBody = """ 
<?xml version="1.0" encoding="utf-8"?>
<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">
  <soap12:Body>
    <VerifyDevice_1_2_2 xmlns="http://emr.ehiconnect.com/">
      <sApikey>$apiKey</sApikey>
      <sDeviceId>123456</sDeviceId>
      <sAppVersion>"1.0.0"</sAppVersion>
      <sRegisterId>123456</sRegisterId> 
    </VerifyDevice_1_2_2>
  </soap12:Body>
</soap12:Envelope>""";

    try {
      http.Response response = await http.post(
        apiURL,
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "Host": "ehix.ehiconnect.com",
          "SOAPAction": "http://emr.ehiconnect.com/VerifyDevice_1_2_2"
        },
        body: utf8.encode(requestBody),
      );

      if (response.statusCode == 200) {
        var document = XmlDocument.parse(response.body);
        //print(document.toXmlString(pretty: true, indent: '\t'));

        success = document.findAllElements('success').first.children.first;
        errorcode = document.findAllElements('errorcode').first.children.first;
        message = document.findAllElements('message').first.children.first;
        print('Success: $success, Errorcode: $errorcode, Message: $message');
      }
    } catch (e) {
      print(e);
    }
  }
}
