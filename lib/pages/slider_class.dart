import 'package:WHOFlutter/animate/text_animation.dart';
import 'package:WHOFlutter/model/detailmodelclass.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../constants.dart';


class CustomSlider extends StatefulWidget {
  final List<Protect> protectList;

  CustomSlider(this.protectList);

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {

  CarouselSlider carouselSlider;
  int _current = 0;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return getMessage();
  }

  Widget getMessage(){
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 50),
        child: Column(
          children: <Widget>[
            CarouselSlider(
              height: MediaQuery.of(context).size.height * 0.7,
              initialPage: 0,
              enlargeCenterPage: true,
              autoPlay: true,
              reverse: false,
              enableInfiniteScroll: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 2000),
              pauseAutoPlayOnTouch: Duration(seconds: 4),
              scrollDirection: Axis.horizontal,
              onPageChanged: (index) {
                setState(() {
                  _current = index;
                });
              },
              items: widget.protectList.map((item) {
                return Builder(
                  builder: (BuildContext context) {
                    double scale = contentScale(context);
                    var screenHeight = MediaQuery.of(context).size.height;
                    return Container(
                      padding: EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Spacer(flex: 1),
                            item.emoji == null
                                ? Container(
                              height: 0,
                            )
                                : Container(
                                height: screenHeight * 0.35,
                                child: item.emoji ?? Container()),
                            Spacer(flex: 1),
                            SlideFadeTransition(
                              delayStart: Duration(milliseconds: 800),
                              child:  Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  item.title,
                                  textScaleFactor: scale * 1.1,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Spacer(flex: 2),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: map<Widget>(widget.protectList, (index, url) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index ? Color.fromRGBO(0, 0, 0, 0.9) : Color.fromRGBO(0, 0, 0, 0.4)
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}