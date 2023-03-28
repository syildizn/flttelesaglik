import 'package:telesaglikk/routes.dart';
import 'package:telesaglikk/screens/splash_screen/splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:telesaglikk/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //it requires 3 parameters
    //context, orientation, device
    //it always requires, see plugin documentation
    return Sizer(builder: (context, orientation, device){
      return MaterialApp(
        debugShowCheckedModeBanner: false,

        title: 'Tele Sağlık',

        theme: CustomTheme(
        ).baseTheme,
        //initial route is splash screen
        //mean first screen
        initialRoute: SplashScreen.routeName,
        //define the routes file here in order to access the routes any where all over the app
        routes: routes,
      );
    });
  }
}