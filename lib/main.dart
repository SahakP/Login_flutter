import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mongodb_realm/flutter_mongo_realm.dart';
import 'package:localization/localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snap_chat_copy/screen/start_page/start_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final tokenPref = await SharedPreferences.getInstance();
  // tokenPref.getString('realmToken');

  await RealmApp.init('application-0-tbwaj');

  //await RealmApp().login(Credentials.anonymous());

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocalJsonLocalization.delegate.directories = ['i18n'];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Snap_Copy',
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('ru', 'RU'),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        LocalJsonLocalization.delegate,
      ],
      home: const StartPage(),
    );
  }
}
