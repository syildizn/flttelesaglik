import 'package:telesaglikk/constants.dart';
import 'package:telesaglikk/screens/assignment_screen/assignment_screen.dart';
import 'package:telesaglikk/screens/datesheet_screen/datesheet_screen.dart';
import 'package:telesaglikk/screens/fee_screen/fee_screen.dart';
import 'package:telesaglikk/screens/my_profile/my_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'widgets/student_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routeName = 'HomeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBkrColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {  },
          icon: Icon(Icons.menu),),
        title: Text("Merhaba Mahmut",textScaleFactor: 0.75,) ,
        actions: [ StudentPicture(picAddress: 'assets/images/unknown.jpg', onPress:(){
        // go to profile detail screen here
        Navigator.pushNamed(
        context, MyProfileScreen.routeName);
        })],

      ),
      backgroundColor: Colors.white,

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
                    /*StudentDataCard(
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
                    ),*/
                  ],
                )
              ],
            ),
          ),*/

          //other will use all the remaining height of screen
          Expanded(
            child: Container(
              width: 100.w,
              decoration: BoxDecoration(
                color: Colors.black12,
                //borderRadius: kTopBorderRadius,
              ),
              child: SingleChildScrollView(
                //for padding
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    sizedBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        HomeCard(

                          onPress: () {},
                          icon: 'assets/icons/ask.svg',
                          title: 'Doktorlar',
                          color: homecard1,
                          colortext: Colors.white,
                        ),
                        HomeCard(
                          onPress: () {
                            //go to assignment screen here
                            Navigator.pushNamed(
                                context, AssignmentScreen.routeName);
                          },
                          icon: 'assets/icons/resume.svg',
                          title: 'Sağlık\nKayıtlarım',
                          color: homecard2,
                          colortext: Colors.white,
                        ),
                      ],
                    ),
                    sizedBox,
                    /*Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                          onPress: () {},
                          icon: 'assets/icons/holiday.svg',
                          title: 'Holidays',
                        ),
                        HomeCard(
                          onPress: () {},
                          icon: 'assets/icons/timetable.svg',
                          title: 'Time Table',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                          onPress: () {},
                          icon: 'assets/icons/result.svg',
                          title: 'Result',
                        ),
                        HomeCard(
                          onPress: () {
                            Navigator.pushNamed(
                                context, DateSheetScreen.routeName);
                          },
                          icon: 'assets/icons/datesheet.svg',
                          title: 'DateSheet',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        HomeCard(
                          onPress: () {},
                          icon: 'assets/icons/ask.svg',
                          title: 'Ask',
                        ),
                        HomeCard(
                          onPress: () {},
                          icon: 'assets/icons/gallery.svg',
                          title: 'Gallery',
                        ),
                      ],
                    ),*/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        HomeCard(
                          onPress: () {},
                          icon: 'assets/icons/assignment.svg',
                          title: 'Geçmiş\nGörüşmelerim',
                          color: homecard3,
                          colortext: Colors.white,
                        ),
                        HomeCard(
                          onPress: () {},
                          icon: 'assets/icons/lock.svg',
                          title: 'Şifreni\nDeğiştir',
                          color: homecard4,
                          colortext: Colors.white,
                        ),
                      ],
                    ),
                    sizedBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        HomeCard(
                          onPress: () {},
                          icon: 'assets/icons/datesheet.svg',
                          title: 'İstatistikler',
                          color: homecard5,
                          colortext: Colors.white,
                        ),
                        HomeCard(
                          onPress: () {},
                          icon: 'assets/icons/logout.svg',
                          title: 'Çıkış',
                          color: homecard6,
                          colortext: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
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
          color: Colors.white,//.withOpacity(0.40),Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0,-10),
              blurRadius: 35,
              color: kBkrColor.withOpacity(0.38),
            )
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(onPressed: () {}, icon: Icon(Icons.home_outlined),),
            IconButton(onPressed: () {}, icon: Icon(Icons.folder_shared_outlined),),
            IconButton(onPressed: () {}, icon: Icon(Icons.forest_outlined ),),
            IconButton(onPressed: () {}, icon: Icon(Icons.perm_identity_rounded),),
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
        required this.colortext
      })
      : super(key: key);
  final VoidCallback onPress;
  final String icon;
  final String title;
  final Color color;
  final Color colortext;

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
            boxShadow: [
            BoxShadow(
            offset: Offset(0,-10),
        blurRadius: 35,
        color: kBkrColor.withOpacity(0.25),
      )]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              height: SizerUtil.deviceType == DeviceType.tablet ? 30.sp : 40.sp,
              width: SizerUtil.deviceType == DeviceType.tablet ? 30.sp : 40.sp,
              color: colortext,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle2?.copyWith(color: colortext, fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}