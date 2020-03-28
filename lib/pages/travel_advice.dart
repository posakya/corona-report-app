import 'package:WHOFlutter/model/detailmodelclass.dart';
import 'package:WHOFlutter/pages/slider_class.dart';
import 'package:flutter/material.dart';
import 'package:WHOFlutter/carousel_page.dart';

//class TravelAdvice extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return CarouselView([
//      CarouselSlide(
//        context,
//        message: "WHO continues to advise against the application of travel or trade restrictions to countries experiencing COVID-19 outbreaks…"
//      ),
//      CarouselSlide(
//        context,
//        message: "It is prudent for travellers who are sick to delay or avoid travel to affected areas, in particular for elderly travellers and people with chronic diseases or underlying health conditions…"
//      ),
//      CarouselSlide(
//        context,
//        message: "“Affected areas” are considered those countries, provinces, territories or cities experiencing ongoing transmission of COVID-19, in contrast to areas reporting only imported cases…"
//      ),
//      CarouselSlide(
//        context,
//        message: "General recommendations for all travellers include…"
//      ),
//      CarouselSlide(
//        context,
//        titleWidget: EmojiHeader("🧼"),
//        message: "Wash your hands frequently"
//      ),
//      CarouselSlide(
//        context,
//        titleWidget: EmojiHeader("👄"),
//        message: "Avoid touching your eyes, mouth and nose"
//      ),
//      CarouselSlide(
//        context,
//        titleWidget: EmojiHeader("💪"),
//        message: "Cover your mouth and nose with your bent elbow or tissue when you cough or sneeze"
//      ),
//      CarouselSlide(
//        context,
//        titleWidget: EmojiHeader("↔️"),
//        message: "Stay more than 1 meter (3 feet) away from a person who is sick"
//      ),
//      CarouselSlide(
//        context,
//        titleWidget: EmojiHeader("🍗"),
//        message: "Follow proper food hygiene practices"
//      ),
//      CarouselSlide(
//        context,
//        titleWidget: EmojiHeader("😷"),
//        message: "Only wear a mask if you are ill with COVID-19 symptoms (especially coughing) or looking after someone who may have COVID-19"
//      ),
//      CarouselSlide(
//        context,
//        message: "Travellers returning from affected areas should:",
//      ),
//      CarouselSlide(
//        context,
//        titleWidget: EmojiHeader("🌡"),
//        message: "Self-monitor for symptoms for 14 days and follow national protocols of receiving countries. Some countries may require returning travellers to enter quarantine",
//      ),
//      CarouselSlide(
//        context,
//        titleWidget: EmojiHeader("🌡️"),
//        message: "Thermal scanners CAN detect if people have a fever but CANNOT detect whether or not someone has the coronavirus",
//      ),
//      CarouselSlide(
//        context,
//        titleWidget: EmojiHeader("🤒"),
//        message: "If symptoms occur, such as fever, or cough or difficulty breathing, travellers are advised to contact local health care providers, preferably by phone, and inform them of their symptoms and their travel history",
//      ),
//    ]);
//  }
//}

class TravelAdvice extends StatefulWidget {
  @override
  _TravelAdviceState createState() => _TravelAdviceState();
}

class _TravelAdviceState extends State<TravelAdvice> {


  List titles = [
    "WHO continues to advise against the application of travel or trade restrictions to countries experiencing COVID-19 outbreaks…",
    "It is prudent for travellers who are sick to delay or avoid travel to affected areas, in particular for elderly travellers and people with chronic diseases or underlying health conditions…",
    "“Affected areas” are considered those countries, provinces, territories or cities experiencing ongoing transmission of COVID-19, in contrast to areas reporting only imported cases…",
    "General recommendations for all travellers include…",
    "Wash your hands frequently",
    "Avoid touching your eyes, mouth and nose",
    "Cover your mouth and nose with your bent elbow or tissue when you cough or sneeze",
    "Stay more than 1 meter (3 feet) away from a person who is sick",
    "Follow proper food hygiene practices",
    "Only wear a mask if you are ill with COVID-19 symptoms (especially coughing) or looking after someone who may have COVID-19",
    "Travellers returning from affected areas should:",
    "self-monitor for symptoms for 14 days and follow national protocols of receiving countries. Some countries may require returning travellers to enter quarantine",
    "Thermal scanners CAN detect if people have a fever but CANNOT detect whether or not someone has the coronavirus",
    "If symptoms occur, such as fever, or cough or difficulty breathing, travellers are advised to contact local health care providers, preferably by phone, and inform them of their symptoms and their travel history"
  ];

  List emojis = [
    EmojiHeader(""),
    EmojiHeader(""),
    EmojiHeader(""),
    EmojiHeader(""),
    EmojiHeader("🧼"),
    EmojiHeader("👄"),
    EmojiHeader("💪"),
    EmojiHeader("↔️"),
    EmojiHeader("🍗"),
    EmojiHeader("😷"),
    EmojiHeader(""),
    EmojiHeader("🌡"),
    EmojiHeader("🌡️"),
    EmojiHeader("🤒")
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
            appBar: AppBar(title: Text("Travel Advice",textAlign: TextAlign.center,),
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

