import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_9/models/note.dart';
import 'package:flutter_application_9/pages/homePage.dart';
import 'package:hive_flutter/adapters.dart';

void main(List<String> args) async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter("Notes");
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<Note>("notes");
  await Hive.openBox<String>("categories");
  runApp(EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('tr', 'TR')],
      path: 'assets/languages',
      fallbackLocale: const Locale('en', 'US'),
      child: const App()
    ),);
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: UniqueKey(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.deviceLocale,
      title: "Notes",
      
      theme: ThemeData(
          
          primarySwatch: Colors.purple,
          floatingActionButtonTheme:
              const FloatingActionButtonThemeData(backgroundColor: Colors.orange)),
      home: const HomePage(),
    );
  }
}
