import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:neigbor_connect/firebase_options.dart';
import 'package:neigbor_connect/main_layout.dart';
import 'screens/create_event.dart';
import 'splash_screen.dart';
import 'package:neigbor_connect/screens/home_page.dart';
import 'package:neigbor_connect/screens/resident_registration.dart';
import 'screens/login_page.dart';
import 'screens/otp_page.dart';
import 'screens/chat_page.dart';
import 'screens/create_group_page.dart';
import 'screens/verification_page.dart';
import 'screens/activities_page.dart';
import 'screens/post_page.dart';

Future<void> main() async {
  runApp(const MyApp());

  WidgetsFlutterBinding.ensureInitialized();

   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        useMaterial3: true,
      ),

      initialRoute: "/",

      routes: {
        "/": (context) => const SplashScreen(),
        "/login": (context) => const LoginPage(),
        "/resident": (context) => const ResidentRegistration(),
        "/home": (context) => const MainLayout(),
        "/post": (context) => const PostPage(),
        "/otp": (context) => const OtpPage(),
        "/activity": (context) => const ActivitiesPage(),
        "/chat": (context) => const ChatPage(),
        "/create_group": (context) => const CreateGroupPage(),
        "/verification": (context) => const VerificationPage(),
        "/create_event": (context) => const CreateEventPage(),
      },

      // home: const LoginPage(),
    );
  }
}


