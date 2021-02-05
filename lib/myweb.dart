import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class MyWeb extends StatefulWidget {
  MyWeb({Key key, this.url}) : super(key: key);
  final String url;
  @override
  _MyWebState createState() => _MyWebState();
}

class _MyWebState extends State<MyWeb> {
  WebViewPlusController _controller;

  JavascriptChannel _javascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'tfl.mobile',
        onMessageReceived: (JavascriptMessage msg) {
          print(msg.message);
          // Map mymap = jsonDecode(msg.message);
          // switch (mymap["type"]) {
          //   case "init":
          //     this._controller.loadUrl(mymap["data"]);
          //     break;
          //   case "exec":
          //     this._controller.evaluateJavascript(mymap["data"]);
          //     break;
          //   default:
          //     this._controller.evaluateJavascript(mymap["data"]);
          // }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WillPopScope(
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 25.0, 0, 0),
              child: WebViewPlus(
                initialUrl: widget.url,
                onWebViewCreated: (controller) {
                  this._controller = controller;
                },
                javascriptChannels: Set.from([
                  JavascriptChannel(
                      name: 'tflMobile',
                      onMessageReceived: (JavascriptMessage message) {
                        var msg = message.message;
                        try {
                          var jsonMsg = json.decode(msg);
                          if (jsonMsg is Map) {
                            var typeMsg = jsonMsg["type"] as String;
                            switch (typeMsg) {
                              case "init":
                                if (jsonMsg["data"] is List) {
                                  var dtMsg = jsonMsg["data"] as List;
                                  if (dtMsg.length > 0) {
                                    this._controller.loadUrl(dtMsg[0].trim());
                                  }
                                } else if (jsonMsg["data"] is String) {
                                  var dtMsg = jsonMsg["data"] as String;
                                  if (dtMsg.isNotEmpty) {
                                    this._controller.loadUrl(dtMsg.trim());
                                  }
                                }

                                break;
                              default:
                            }
                          }
                        } catch (e) {
                          print(e.toString());
                        }

                        print(message.message);
                      })
                ]),
                javascriptMode: JavascriptMode.unrestricted,
              ),
            ),
            onWillPop: () async {
              var canGoBack = await this._controller.canGoBack();
              if (canGoBack) {
                this._controller.goBack();
                return false;
              }
              return true;
            }));
  }
}
