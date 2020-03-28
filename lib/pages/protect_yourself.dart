import 'package:WHOFlutter/pages/slider_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:WHOFlutter/model/detailmodelclass.dart';

import 'emojiheader.dart';

class ProtectYourself extends StatefulWidget {
  @override
  _ProtectYourselfState createState() => _ProtectYourselfState();
}

class _ProtectYourselfState extends State<ProtectYourself> {

  List titles = [
    "Wash your hand often with soap and running water frequently",
    "Avoid touching your eyes, mouth, and nose",
    "Cover your mouth and nose with your bent elbow or tissue when you cough or sneeze",
    "Avoid crowded places",
    "Stay at home if you feel unwell - even with a slight fever and cough",
    "If you have a fever, cough and difficulty breathing, seek medical care early but call by phone first!",
    "Stay aware of the latest information from WHO"
  ];

  List emojis = [
    EmojiHeader("🧼"),
    EmojiHeader("👄"),
    EmojiHeader("💪"),
    EmojiHeader("🚷"),
    EmojiHeader("🏠"),
    EmojiHeader("🤒"),
    EmojiHeader("ℹ️")
  ];

  List<Protect> protectList = [];

  @override
  void initState() {

    super.initState();

    for (int i = 0; i<titles.length; i++){

      Protect protect = Protect();
      protect.title = titles[i];
      protect.emoji = emojis[i];

      protectList.add(protect);

    }

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(title: Text("Protect Your Self",textAlign: TextAlign.center,),
              leading: IconButton(
                tooltip: 'Previous choice',
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Center(child: CustomSlider(protectList))
        )
    );
  }

}

