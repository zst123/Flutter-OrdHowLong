import 'package:flutter/material.dart';
import 'package:wave_progress_widget/wave_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ordhowlong/main.dart';
import 'package:intl/intl.dart';
import 'package:wave_slider/wave_slider.dart';

class ScreenJourney extends StatefulWidget {
  static const String TITLE = 'Journey';
  ScreenJourneyState createState() => ScreenJourneyState();
}

class ScreenJourneyState extends State<ScreenJourney> {
  var _progress = 50.0;
  var _progressDate = "";
  var _progressCount = "";
  DateTime enlistment;
  DateTime ord;

  @override
  void initState() {
    super.initState();
    recallSettings();
  }

  void recallSettings() async {
    print("screen_journey.dart: recallSettings()");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var _enlistment = prefs.getString("enlistment") ?? "";
    var _orddate = prefs.getString("orddate") ?? "";

    if (_enlistment.isEmpty || _orddate.isEmpty) {
      return;
    }

    // parse dates
    final enlistment_date = _enlistment.split('/').map(int.parse).toList();
    final ord_date = _orddate.split('/').map(int.parse).toList();
    enlistment = DateTime(enlistment_date[0], enlistment_date[1], enlistment_date[2]);
    ord = DateTime(ord_date[0], ord_date[1], ord_date[2]);

    // calculate
    todayDay();
  }

  void updateCurrentDate() {
    final total = ord.difference(enlistment).inDays;
    final currentDate = enlistment.add(Duration(days: (total * _progress / 100.0).round()));
    _progressDate = new DateFormat("dd MMM yyyy").format(currentDate);

    final days = ord.difference(currentDate).inDays;
    final weeks = (days/7).floor();
    _progressCount = "$days DAYS LEFT\n$weeks WEEKS LEFT";
  }

  void addOneDay() {
    final total = ord.difference(enlistment).inDays;
    _progress += 100.0 / total;
    if (_progress > 100.0) {
      _progress = 100.0;
    }
    setState(() {});
    updateCurrentDate();
  }

  void todayDay() {
    final current = DateTime.now().difference(enlistment).inDays;
    final total = ord.difference(enlistment).inDays;
    _progress = current / total * 100;

    setState(() {});
    updateCurrentDate();
  }

  void subtractOneDay() {
    final total = ord.difference(enlistment).inDays;
    _progress -= 100.0 / total;
    if (_progress < 0.0) {
      _progress = 0.0;
    }
    setState(() {});
    updateCurrentDate();
  }


  @override
  Widget build(BuildContext context) {
    return new Container(
        //color: MyApp.primaryColor,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 30.0),
            Text(
              '${_progress.toStringAsFixed(2)}%',
              style: TextStyle(
                  color: MyApp.primaryColor, fontSize: 60.0,
                  fontWeight: FontWeight.bold, height: 1
              ),
            ),
            SizedBox(height: 10.0),
            WaveProgress(200.0, MyApp.primaryColor, MyApp.primaryColor, _progress),
            Container(
              margin: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 30.0, right: 30.0),
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: MyApp.primaryColor,
                  inactiveTrackColor: MyApp.primaryLightColor,
                  trackShape: RoundedRectSliderTrackShape(),
                  trackHeight: 6.0,
                  thumbColor: MyApp.primaryColor,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                  overlayColor: MyApp.primaryColor.withAlpha(32),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                ),
                child: Slider(
                  //displayTrackball: false,
                  min: 0.0,
                  max: 100.0,
                  value: _progress,
                  divisions: 1000, // step of 0.1
                  onChanged: (value) {
                    setState(() {
                      _progress = value;
                      updateCurrentDate();
                    });
                  },
                )
              ),
            ),
            Text(
              '${_progressDate}',
              style: TextStyle(
                  color: MyApp.primaryColor, fontSize: 30.0,
                  fontWeight: FontWeight.w900, height: 1
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              '${_progressCount}',
              style: TextStyle(
                  color: MyApp.primaryColor, fontSize: 16.0,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w900, height: 1.2
              ),
            ),
            SizedBox(height: 25.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new RawMaterialButton(
                  onPressed: () {
                    subtractOneDay();
                  },
                  child: new Icon(
                    Icons.arrow_back_ios,
                    color: MyApp.primaryColor,
                    size: 35.0,
                  ),
                  shape: new CircleBorder(),
                  fillColor: Colors.white,
                  elevation: 5.0,
                  padding: const EdgeInsets.all(15.0),
                ),
                new RawMaterialButton(
                  onPressed: () {
                    todayDay();
                  },
                  child: new Icon(
                    Icons.today,
                    color: MyApp.primaryColor,
                    size: 35.0,
                  ),
                  shape: new CircleBorder(),
                  fillColor: Colors.white,
                  elevation: 5.0,
                  padding: const EdgeInsets.all(15.0),
                ),
                new RawMaterialButton(
                  onPressed: () {
                    addOneDay();
                  },
                  child: new Icon(
                    Icons.arrow_forward_ios,
                    color: MyApp.primaryColor,
                    size: 35.0,
                  ),
                  shape: new CircleBorder(),
                  fillColor: Colors.white,
                  elevation: 5.0,
                  padding: const EdgeInsets.all(15.0),
                ),
              ]
            ),
          ],
        ),
    );

  }
}