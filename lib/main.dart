import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myadmin/myweb.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyWeb(url: "https://apps.tafalo.com/",),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController maUngDung;
  httpClientGetCodeSite() async {
    var httpclient = http.Client();
   /* var response = await httpclient.post(
      '', body: {'appid': maUngDung.value.text}
    );
    Map jsonRes = jsonDecode(response.body);
    */
    var objson = {"ok": true, "data": "https://noihoidonganh.com"};
    Map jsonRes = jsonDecode(JsonEncoder().convert(objson));
    if(jsonRes["ok"]){
      var url = jsonRes["data"];
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => new MyWeb(url: url,))
        );
    } else {
      print('Hiển thị thông báo');

    }
    

  }
  @override
  Widget build(BuildContext context) {  
    return Scaffold(      
      body: Center(      
        child: Column(         
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Mã ứng dụng:',
            ),
            TextField(
              controller: this.maUngDung,
              decoration: InputDecoration(hintText: "Nhập mã ứng dụng", border: InputBorder.none),
            ),
            RaisedButton(onPressed: httpClientGetCodeSite, child: Text("Nhập"),)
          ],
        ),
      ),
    );
  }
}
