import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_recovery/screens/main/main_screen.dart';
import 'package:pro_recovery/screens/profile/profile_screen.dart';
import 'package:pro_recovery/screens/settings/settings_screen.dart';
import 'package:pro_recovery/screens/splash/splash_screen.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:pro_recovery/bloc/auth_cubit.dart';
import 'package:pro_recovery/screens/chat_screen.dart';
import 'package:pro_recovery/screens/create_post_screen.dart';
import 'package:pro_recovery/screens/posts_screen.dart';
import 'package:pro_recovery/screens/sign_in_screen.dart';
import 'package:pro_recovery/screens/sign_up_screen.dart';

import 'constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await SentryFlutter.init(
    (options) {
      options.dsn = 'https://example@sentry.io/add-your-dsn-here';
    },
    // Init your App.
    appRunner: () => runApp(const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Checks authState
  Widget _buildHomeScreen() {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          FirebaseFirestore.instance
              .collection("users")
              .doc(snapshot.data!.uid)
              .get()
              .then((value) {
            var userType = (value.data())!["type"];
            if (userType == "patient") {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const ProfileScreen(),
                ),
              );
            } else if (userType == "specialist") {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const MainScreen(),
                ),
              );
            }
          });

          return const CircularProgressIndicator();
        } else {
          return SplashScreen();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pro Recovery',
        theme: ThemeData(
          primaryColor: primaryColor,
          scaffoldBackgroundColor: backgroundColor,
          textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom()),
          textTheme: Theme.of(context).textTheme.apply(displayColor: textColor),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: TextButton.styleFrom(
              padding: EdgeInsets.all(defaultPadding),
              backgroundColor: primaryColor,
              minimumSize: Size(double.infinity, 10),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor.withOpacity(0.5),
              ),
            ),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: textColor),
            textTheme:
                Theme.of(context).textTheme.apply(displayColor: textColor),
          ),
        ),
        home: _buildHomeScreen(),
        routes: {
          SignUpScreen.routeName: (context) => const SignUpScreen(),
          SignInScreen.routeName: (context) => const SignInScreen(),
          PostsScreen.routeName: (context) => const PostsScreen(),
          CreatePostScreen.routeName: (context) => const CreatePostScreen(),
          ChatScreen.routeName: (context) => const ChatScreen(),
        },
      ),
    );
  }
}
