import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_shop_app/providers/user_provider.dart';
import 'package:firebase_shop_app/responsive/mobile_screen_layout.dart';
import 'package:firebase_shop_app/responsive/responsive_layout.dart';
import 'package:firebase_shop_app/responsive/web_screen_layout.dart';
import 'package:firebase_shop_app/screens/login_screen.dart';
import 'package:firebase_shop_app/utils/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialise app based on platform- web or mobile
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyANmR7WNleHPYmXrq9P2Iq5rnd6YHPdhXc",
        appId: "1:602488159694:web:24c4c1e94c9b6277fdbf9f",
        messagingSenderId: "602488159694",
        projectId: "flutter-shop-app-c72a7",
        storageBucket: "flutter-shop-app-c72a7.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram Clone',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              print("1");
              // Checking if the snapshot has any data or not (スナップショットがデータを持っている場合)
              if (snapshot.hasData) {
                print("2");
                // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                print("3");
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            print("4");
            // means connection to future hasnt been made yet
            if (snapshot.connectionState == ConnectionState.waiting) {
              print("5");
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            print("6");
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
