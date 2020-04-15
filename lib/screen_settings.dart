import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:ordhowlong/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

// https://medium.com/enappd/building-a-flutter-datetime-picker-in-just-15-minutes-6a4b13d6a6d1

class ScreenSettings extends StatefulWidget {
  static const String TITLE = 'Settings';

  ScreenSettingsState createState() => ScreenSettingsState();
}

/*
class DateTimePicker extends StatefulWidget {
  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScreenSettings(),
    );
  }
}
*/

class ScreenSettingsState extends State<ScreenSettings> {
  String _enlistment = "Not set";
  String _orddate = "Not set";

  @override
  void initState() {
    super.initState();
    recallSettings();
  }

  void recallSettings() async {
    print("screen_settings.dart: recallSettings()");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _enlistment = prefs.getString("enlistment") ?? "Not set";
    _orddate = prefs.getString("orddate") ?? "Not set";
    setState(() {});
  }
  void updateSettings() async {
    print("screen_settings.dart: updateSettings()");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("enlistment", _enlistment);
    prefs.setString("orddate", _orddate);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
                child: createSettingItems(),
            ),
        ),
    );
  }


  Column createSettingItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          "Enlisted on:\n",
          textAlign: TextAlign.start,
          style: TextStyle(
              color: MyApp.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 18.0),
        ),
        RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          elevation: 4.0,
          onPressed: () {
            DatePicker.showDatePicker(context,
                theme: DatePickerTheme(
                  containerHeight: 210.0,
                ),
                showTitleActions: true,
                minTime: DateTime(2010, 1, 1),
                maxTime: DateTime(2030, 12, 31),
                onConfirm: (date) {
                  _enlistment = '${date.year}/${date.month}/${date.day}';
                  setState(() {});
                  updateSettings();
                }, currentTime: DateTime.now(), locale: LocaleType.en);
          },
          child: createTimeButton(" $_enlistment"),
          color: Colors.white,
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          "ORD on:\n",
          style: TextStyle(
              color: MyApp.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 18.0),
        ),
        RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          elevation: 4.0,
          onPressed: () {
            DatePicker.showDatePicker(context,
                theme: DatePickerTheme(
                  containerHeight: 210.0,
                ),
                showTitleActions: true,
                minTime: DateTime(DateTime.now().year-10, 1, 1),
                maxTime: DateTime(DateTime.now().year+10, 12, 31),
                onConfirm: (date) {
                  _orddate = '${date.year}/${date.month}/${date.day}';
                  setState(() {});
                  updateSettings();
                }, currentTime: DateTime.now(), locale: LocaleType.en);
            setState(() {});
          },
          child: createTimeButton(" $_orddate"),
          color: Colors.white,
        )
      ],
    );
  }

  Container createTimeButton(String text) {
    return Container(
      alignment: Alignment.center,
      height: 50.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.today,
                      size: 18.0,
                      color: MyApp.primaryColor,
                    ),
                    Text(
                      text,
                      style: TextStyle(
                          color: MyApp.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ],
                ),
              )
            ],
          ),
          Text(
            "  Change",
            style: TextStyle(
                color: MyApp.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18.0),
          ),
        ],
      ),
    );
  }

}
