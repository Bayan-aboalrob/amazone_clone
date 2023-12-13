import 'package:amazone_clone/layout/screen_layout.dart';
import 'package:amazone_clone/providers/user_details_provider.dart';
import 'package:amazone_clone/screens/sign_in_screen.dart';
import 'package:amazone_clone/utils/color_themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCyyv81KROtn8Evzo4KHaiCU8g_Nk5dQwE",
          authDomain: "eclone-5f883.firebaseapp.com",
          databaseURL: "https://eclone-5f883-default-rtdb.asia-southeast1.firebasedatabase.app",
          projectId: "eclone-5f883",
          storageBucket: "eclone-5f883.appspot.com",
          messagingSenderId: "1075264789537",
          appId: "1:1075264789537:web:296456ab3dfe7c5ccb5760",
          measurementId: "G-F4RSCJ723P"
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const AmazonClone());
}
class AmazonClone extends StatelessWidget {
  const AmazonClone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserDetailsProvider())],
      child: MaterialApp(
        title: "Amazon",
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: backgroundColor,
        ),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, AsyncSnapshot<User?> user) {
              if (user.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                );
              } else if (user.hasData) {
                return const ScreenLayout();
              } else {
                return const SignInScreen();
              }
            }),
      ),
    );
  }
}
