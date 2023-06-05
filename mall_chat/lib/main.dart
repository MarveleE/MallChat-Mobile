import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mall_chat/Feature/Home/home_main_view.dart';
import 'package:mall_chat/Feature/TabBar/tab_bar_view.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  Provider.debugCheckInvalidValueType = null;
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "SFMono",
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontFeatures: [FontFeature.disable("smcp")]),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Navigator(
        onGenerateRoute: (settings) {
          return CupertinoPageRoute(builder: (context) {
            return const Scaffold(
              body: SizedBox.expand(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    HomeChatView(),
                    HomeTabBarView(),
                  ],
                ),
              ),
            );
          });
        },
      ),
    );
  }
}
