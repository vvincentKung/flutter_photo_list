import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_list/controller/main_controller.dart';
import 'package:photo_list/model/photo_payload.dart';
import 'package:photo_list/util/global_key.dart';
import 'package:photo_list/view/home.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'view/detail.dart';

void main() {
  final client = http.Client();
  runApp(MyApp(client));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  late http.Client _client;
  MyApp(http.Client client){
    this._client = client;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo List',
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
        primarySwatch: Colors.amber,
      ),
      // navigatorKey: navigatorKey,
      home: const MyHomePage(),
      routes: {
        DetailPage.routeName: (context) => const DetailPage()
      },
    );
  }
}
