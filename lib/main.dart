import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer/hidden_drawer_menu.dart';
import 'package:ordhowlong/screen_journey.dart';
import 'package:ordhowlong/screen_settings.dart';
import 'package:ordhowlong/screen_quotes.dart';
import 'package:ordhowlong/screen_about.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static MaterialColor primaryColor = Colors.blue;
  static Color primaryLightColor = Colors.blue[100];
  //static Color accentColor = Colors.blueAccent;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
        primarySwatch: MyApp.primaryColor,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<ScreenHiddenDrawer> drawer = new List();

  ItemHiddenMenu createItemHiddenMenu(String name) {
    return new ItemHiddenMenu(
          name: name,
          baseStyle: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.w600,
              fontSize: 28.0
          ),
          colorLineSelected: MyApp.primaryColor,
        );
  }

  @override
  void initState() {
    drawer.add(new ScreenHiddenDrawer(createItemHiddenMenu(ScreenJourney.TITLE), ScreenJourney()));
    drawer.add(new ScreenHiddenDrawer(createItemHiddenMenu(ScreenQuotes.TITLE), ScreenQuotes()));
    drawer.add(new ScreenHiddenDrawer(createItemHiddenMenu(ScreenSettings.TITLE), ScreenSettings()));
    drawer.add(new ScreenHiddenDrawer(createItemHiddenMenu(ScreenAbout.TITLE), ScreenAbout()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
        backgroundColorMenu: Colors.lightBlue[900],
        backgroundColorAppBar: MyApp.primaryColor,
        screens: drawer,
        typeOpen: TypeOpen.FROM_LEFT,
        enableScaleAnimin: true,
        enableCornerAnimin: true,
        slidePercent: 50.0,
        verticalScalePercent: 85.0,
        contentCornerRadius: 20.0,
        //    iconMenuAppBar: Icon(Icons.menu),
        //    backgroundContent: DecorationImage((image: ExactAssetImage('assets/bg_news.jpg'),fit: BoxFit.cover),
        //    whithAutoTittleName: true,
        //    styleAutoTittleName: TextStyle(color: Colors.red),
        //    actionsAppBar: <Widget>[],
        //    backgroundColorContent: Colors.blue,
        //    elevationAppBar: 4.0,
        //    tittleAppBar: Center(child: Icon(Icons.ac_unit),),
        //    enableShadowItensMenu: true,
        //    backgroundMenu: DecorationImage(image: ExactAssetImage('assets/bg_news.jpg'),fit: BoxFit.cover),
    );
  }
}
