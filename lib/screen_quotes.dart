import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ordhowlong/main.dart';

class ScreenQuotes extends StatefulWidget {
  static const String TITLE = 'Quotes';

  ScreenQuotesState createState() => ScreenQuotesState();
}

class ScreenQuotesState extends State<ScreenQuotes> {
  static const String URL = 'https://api.rss2json.com/v1/api.json?rss_url=https%3A%2F%2Fwww.brainyquote.com%2Flink%2Fquotebr.rss';
  List<String> quotes = new List<String>()..add("");

  @override
  void initState() {
    super.initState();
    loadQuote();
  }

  void loadQuote() async {
    // download page
    http.Client _client = new http.Client();
    final req = await _client.get(Uri.parse(URL));
    final content = req.body;
    //print(content);

    // parse quotes
    var parsedJson = json.decode(content);
    var items = parsedJson['items'];
    quotes = items.map<String>((node) {
      return (node['description'] +
          '\n\n– ' +
          node['title']).toString();
    }).toList();

    // force refresh
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: MyApp.primaryColor,
        constraints: BoxConstraints.expand(),
        child: CarouselSlider(
          scrollDirection: Axis.vertical,
          items: quotes.map((String i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(color: MyApp.primaryColor),
                  child: Text(
                    '$i',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w900,
                        height: 1.2),
                  ),
                );
              },
            );
          }).toList(),
        ));
  }
}
