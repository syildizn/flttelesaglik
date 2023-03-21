import 'dart:ui';

import 'package:telesaglikk/screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  //route name for our screen
  static String routeName = 'SplashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
/*
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //we use future to go from one screen to other via duration time
    Future.delayed(Duration(seconds: 5), (){
      //no return when user is on login screen and press back, it will not return the
      //user to the splash screen
      Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
    });
  }
  @override
  Widget build(BuildContext context) {
    //scaffold color set to primary color in main in our text theme
    return Scaffold(
      //its a row with a column
      //backgroundColor: Colors.cyan[#18ffff],

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backround.jpg'),
            fit: BoxFit.cover,
          ),
        ),

        child: Center(


          child: Row(

            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Text('TELE', style: Theme.of(context).textTheme.headline5,),
                  Text(
                    'TELE',
                    style: Theme.of(context).textTheme.headline5?.copyWith(color: Colors.cyan),
                  ),
                  Text(
                    'SAGLIK',
                    style: Theme.of(context).textTheme.headline5?.copyWith(color: Colors.black),
                  )
                  ,
                ],
              ),
              Image.asset(
                'assets/images/logoxx.png',
                //25% of height & 50% of width
                height: 25.h,
                width: 50.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //we use future to go from one screen to other via duration time
    Future.delayed(Duration(seconds: 10), (){
      //no return when user is on login screen and press back, it will not return the
      //user to the splash screen
      Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Arka plan resmi
          Image.asset(
            'assets/images/backround.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          // Bulanık arka plan
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0.5),
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          // Sayfa içeriği
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'TELE',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.copyWith(color: Colors.cyan),
                    ),
                    Text(
                      'SAGLIK',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.copyWith(color: Colors.cyan),
                    ),
                  ],
                ),
                Image.asset(
                  'assets/images/logoxx.png',
                  //25% of height & 50% of width
                  height: 25.h,
                  width: 50.w,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
