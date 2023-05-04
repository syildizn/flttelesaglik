

import 'package:telesaglikk/screens/appointment_screen/appointment_page.dart';
import 'package:telesaglikk/screens/doctors_page/doctorProfile_page.dart';
import 'package:telesaglikk/screens/doctors_page/doctors_page.dart';
import 'package:telesaglikk/screens/login_screen/login_screen.dart';
import 'package:telesaglikk/screens/resetpassword_screen/resetpassword_screen.dart';
import 'package:telesaglikk/screens/signup_screen/signup_screen.dart';
import 'package:telesaglikk/screens/splash_screen/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'screens/assignment_screen/assignment_screen.dart';
import 'screens/datesheet_screen/datesheet_screen.dart';
import 'screens/fee_screen/fee_screen.dart';
import 'screens/home_screen/home_screen.dart';
import 'screens/my_profile/my_profile.dart';

Map<String, WidgetBuilder> routes = {
  //all screens will be registered here like manifest in android
  SplashScreen.routeName: (context) => SplashScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  MyProfileScreen.routeName: (context) => MyProfileScreen(),
  FeeScreen.routeName: (context) => FeeScreen(),
  AssignmentScreen.routeName: (context) => AssignmentScreen(),
  DateSheetScreen.routeName: (context) => DateSheetScreen(),
  SignupScreen.routeName: (context) => SignupScreen(),
  RessetpasswordScreen.routeName: (context)=> RessetpasswordScreen(),
  DoctorsPage.routeName : (context)=> DoctorsPage(),
  DoctorProfilePage.routeName :(context)=> DoctorProfilePage(),
  AppointmentPage.routeName : (context)=> AppointmentPage(),
};