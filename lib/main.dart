import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/core/config/service_locator.dart';
import 'package:notes_app/features/view/pages/login_page.dart';
import 'package:notes_app/features/view/pages/notes_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  await Supabase.initialize(
    url: 'https://crrlokxjonnbomvswsbg.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNycmxva3hqb25uYm9tdnN3c2JnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjEzMzM3MjgsImV4cCI6MjAzNjkwOTcyOH0.9QC5UJtka2pha0eo-0ab11OK1FF931YYUo81UaM9hjk',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: (core.get<SharedPreferences>().getString('email') == null)
            ? LoginPage()
            : NotesPage(),
      ),
    );
  }
}
