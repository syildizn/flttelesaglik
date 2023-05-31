import 'dart:ui';

import 'package:google_fonts/google_fonts.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telesaglikk/MongoDb.dart';
import 'package:telesaglikk/constants.dart';
import 'package:telesaglikk/models/students_model.dart';
import 'package:telesaglikk/screens/about_screen/about_screen.dart';
import 'package:telesaglikk/screens/assignment_screen/assignment_screen.dart';
import 'package:telesaglikk/screens/datesheet_screen/datesheet_screen.dart';
import 'package:telesaglikk/screens/doctors_page/doctors_page.dart';

import 'package:telesaglikk/screens/general_screen/general_screen.dart';
import 'package:telesaglikk/screens/my_profile/my_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import '../login_screen/login_screen.dart';
import 'widgets/student_data.dart';
import 'package:telesaglikk/MongoDb.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  //const HomeScreen({Key? key}) : super(key: key);
  static String routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? firstName = MongoDataBase.sfirstName;
  String? lastName = MongoDataBase.slastName;
  String? department = MongoDataBase.sdepartment;
  String? email = MongoDataBase.semail;
  String? studentno = MongoDataBase.sstudentno ;





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: homepagefont,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Image.asset('assets/images/bakircayiconlogo.png'),
        ),
        title: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Text("Telesağlık",textScaleFactor: 1,style: GoogleFonts.sourceSansPro(textStyle:
          TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            color: kBkrColor,))),
        ) ,
        // actions: [ StudentPicture(picAddress: 'assets/images/unknown.jpg', onPress:(){
        // // go to profile detail screen here
        // Navigator.pushNamed(
        // context, MyProfileScreen.routeName);
        // })],

      ),
      backgroundColor: homepagefont,

      body: Column(
        children: [
          //we will divide the screen into two parts
          //fixed height for first half
          /*Container(
            width: 100.w,
            height: 10.h,
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /*Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StudentName(
                          studentName: 'Öğrenci X',
                        ),
                        kHalfSizedBox,
                        StudentClass(
                            studentClass: 'Biyomedikal Mühendisliği'),
                        kHalfSizedBox,
                        StudentYear(studentYear: '2022-2023'),
                      ],
                    ),
                    kHalfSizedBox,
                    StudentPicture(
                        picAddress: 'assets/images/unknown.jpg',
                        onPress: () {
                          // go to profile detail screen here
                          Navigator.pushNamed(
                              context, MyProfileScreen.routeName);
                        }),
                  ],
                ),*/
                sizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    StudentDataCard(
                      onPress: () {
                        //go to attendance screen
                      },
                      title: 'Sağlık Kayıtlarım',
                      value: '6 Adet',
                    ),
                    StudentDataCard(
                      onPress: () {
                        //go to fee due screen
                        Navigator.pushNamed(context, FeeScreen.routeName);
                      },
                      title: 'Görüşme Kayıtlarım',
                      value: '3 Adet',
                    ),
                  ],
                )
              ],
            ),
          ),*/

          //other will use all the remaining height of screen
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10.0,),
                Text("Menü",style: TextStyle(fontSize: 25.0,
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.normal,
                  color: kBkrColor,),),
              ],
            ),
            Container(
                width: 90.w,
                decoration: BoxDecoration(
                  color: homepagefont,
                  //borderRadius: kTopBorderRadius,
                ),
                child: SingleChildScrollView(
                  //for padding

                  scrollDirection: Axis.horizontal,
                  //physics: BouncingScrollPhysics(),
                   child: Column(
                    children: [

                      Row(

                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          kWidthSizedBox,

                          HomeCard(

                            onPress: () {
                              Navigator.pushNamed(
                                  context, DoctorsPage.routeName);
                            },
                            icon: 'assets/icons/doctorw.svg',
                            title: 'Doktorlar',
                            color: Colors.white,
                            //colortext:  homecard1,
                          ),
                          kWidthSizedBox,
                          HomeCard(
                            onPress: () {
                              //go to assignment screen here
                              // Navigator.pushNamed(
                              //     context, AssignmentScreen.routeName);
                              Navigator.pushNamed(context, GeneralScreen.routeName);
                            },
                            icon: 'assets/icons/health.svg',
                            title: 'Sağlık\nKayıtlarım',
                            color: Colors.white,
                            //colortext:  homecard2,
                          ),
                          kWidthSizedBox,
                          HomeCard(
                                  onPress: () {
                                    Navigator.pushNamed(context, GeneralScreen.routeName);
                                  },
                                  icon: 'assets/icons/meetingy.svg',
                                  title: 'Geçmiş\nGörüşmelerim',
                                  color: Colors.white,
                                  //colortext:  homecard3,
                                ),
                          kWidthSizedBox,
                                HomeCard(
                                  onPress: () {
                                    Navigator.pushNamed(context, GeneralScreen.routeName);
                                  },
                                  icon: 'assets/icons/passwordc.svg',
                                  title: 'Şifreni\nDeğiştir',
                                  color:  Colors.white,
                                  //colortext: homecard4,
                                ),
                          kWidthSizedBox,
                          HomeCard(
                            onPress: () {
                              Navigator.pushNamed(context, GeneralScreen.routeName);
                            },
                            icon: 'assets/icons/infox.svg',
                            title: 'İstatistikler',
                            color:  Colors.white,
                            //colortext: homecard5,
                          ),
                          kWidthSizedBox,
                          HomeCard(
                            onPress: () {
                              Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
                            },
                            icon: 'assets/icons/exitk.svg',
                            title: 'Çıkış',
                            color:  Colors.white,
                            //colortext: homecard6,
                          ),
                        ],
                      ),
                      sizedBox,


                    ],
                  ),
                ),
              ),
          sizedBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 10.0,),
              Text("Hastalıklar",style: TextStyle(fontSize: 25.0,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
                color: kBkrColor,),),
            ],
          ),




          Container(
            width: 90.w,
            decoration: BoxDecoration(
              color: homepagefont,
              //borderRadius: kTopBorderRadius,
            ),
            child: SingleChildScrollView(
              //for padding

              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [

                  sizedBox,

                  sizedBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StudentDataCard(
                        onPress: () {
                          //go to attendance screen
                          Navigator.pushNamed(
                              context, DateSheetScreen.routeName);
                        },
                        //title: 'Sağlık Kayıtlarım',
                        value: 'Nöroloji',
                        icon: 'assets/icons/neurology.svg',
                      ),
                      kWidthSizedBox,
                      StudentDataCard(
                        onPress: () {
                          //go to attendance screen
                          Navigator.pushNamed(context, GeneralScreen.routeName);
                        },
                        //title: 'Sağlık Kayıtlarım',
                        value: 'Psikoloji',
                        icon: 'assets/icons/psychology.svg',
                      ),
                      kWidthSizedBox,
                      StudentDataCard(
                        onPress: () {
                          //go to attendance screen
                          Navigator.pushNamed(context, GeneralScreen.routeName);
                        },
                        //title: 'Sağlık Kayıtlarım',
                        value: 'Kardiyoloji',
                        icon: 'assets/icons/cardiology.svg',
                      ),
                      kWidthSizedBox,
                      StudentDataCard(
                        onPress: () {
                          //go to fee due screen
                          Navigator.pushNamed(context, GeneralScreen.routeName);
                        },
                        //title: 'Görüşme Kayıtlarım',
                        value: 'Dahiliye',
                        icon: 'assets/icons/internaldisease.svg',
                      ),
                    ],
                  )


                ],
              ),
            ),
          ),
          sizedBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 10.0,),
              Text("Hakkımızda",style: TextStyle(fontSize: 25.0,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal,
                color: kBkrColor,),),
            ],
          ),
          sizedBox,
          Container(
            width: 90.w,
            decoration: BoxDecoration(
              color: homepagefont,
              //borderRadius: kTopBorderRadius,
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, AboutScreen.routeName);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 1.h),
                    width: 90.w,
                    height: 15.h,
                    decoration: BoxDecoration(

                      color: Colors.white,
                      borderRadius: BorderRadius.circular(kDefaultPadding / 2),
                      //       boxShadow: [
                      //       BoxShadow(
                      //       offset: Offset(0,-10),
                      //   blurRadius: 35,
                      //   color: Colors.black12.withOpacity(0.17),
                      // )]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/telesaglikk.svg',
                          height: 81,//SizerUtil.deviceType == DeviceType.tablet ? 30.sp : 40.sp,
                          width: 85,//SizerUtil.deviceType == DeviceType.tablet ? 30.sp : 40.sp,
                          //color: null,
                        ),
                        Text(
                          "Telesağlık Nedir",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: kTextLightColor,fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),


                )
              ],
            ),
          )



        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: kDefaultPadding*2,
          right: kDefaultPadding*2,
          bottom: kDefaultPadding,

        ),
        height: 70,
        decoration: BoxDecoration(
          color: homepagefont,//.withOpacity(0.40),Colors.white,
          boxShadow: [
           /* BoxShadow(
              offset: Offset(0,-10),
              blurRadius: 35,
              color: kBkrColor.withOpacity(0.38),
            )*/
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(onPressed: () {}, icon:SvgPicture.asset(
              'assets/icons/homei.svg',
              width: 50,
              height: 50,
            ), ), //Icon(Icons.home_outlined),),
            IconButton(onPressed: () {
              Navigator.pushNamed(
                  context, AssignmentScreen.routeName);
            }, icon: SvgPicture.asset(
              'assets/icons/conferance.svg',
              width: 50,
              height: 50,
            ),),
            IconButton(onPressed: () {
              Navigator.pushNamed(context, GeneralScreen.routeName);
            }, icon: SvgPicture.asset(
              'assets/icons/icecream.svg',
              width: 50,
              height: 50,
            ),),
            IconButton(onPressed: () {
              Navigator.pushNamed(
                  context, MyProfileScreen.routeName);
            }, icon: SvgPicture.asset(
              'assets/icons/profilo.svg',
              width: 50,
              height: 50,
            ),),
          ],
        ),
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  const HomeCard(
      {Key? key,
        required this.onPress,
        required this.icon,
        required this.title,
        required this.color,
        //required this.colortext
      })
      : super(key: key);
  final VoidCallback onPress;
  final String icon;
  final String title;
  final Color color;
  //final Color colortext;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.only(top: 1.h),
        width: 40.w,
        height: 20.h,
        decoration: BoxDecoration(

          color: color,
          borderRadius: BorderRadius.circular(kDefaultPadding / 2),
      //       boxShadow: [
      //       BoxShadow(
      //       offset: Offset(0,-10),
      //   blurRadius: 35,
      //   color: Colors.black12.withOpacity(0.17),
      // )]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              height: SizerUtil.deviceType == DeviceType.tablet ? 30.sp : 40.sp,
              width: SizerUtil.deviceType == DeviceType.tablet ? 30.sp : 40.sp,
              //color: null,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: kTextLightColor,fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}