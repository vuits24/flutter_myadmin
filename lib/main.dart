import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';
import 'package:myadmin/myweb.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Upgrader().clearSavedSettings();
    final appcastURL =
        'https://raw.githubusercontent.com/vuits24/flutter_myadmin/main/appcast.xml';
    final cfg = AppcastConfiguration(url: appcastURL, supportedOS: ['android']);

    return MaterialApp(
      title: 'Admin demo',
      theme: ThemeData(       
        primarySwatch: Colors.blue,       
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: UpgradeAlert(
        appcastConfig: cfg,
        debugLogging: true,        
        child:MyWeb(
        url: "https://apps.tafalo.com/",
        ) ,
        ) ,
    );
  }
}
