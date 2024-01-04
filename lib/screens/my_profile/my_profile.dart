import 'package:flutter_svg/svg.dart';
import 'package:telesaglikk/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../MongoDb.dart';
import '../assignment_screen/assignment_screen.dart';
import '../general_screen/general_screen.dart';
import '../home_screen/home_screen.dart';

class MyProfileScreen extends StatelessWidget {
  //const MyProfileScreen({Key? key}) : super(key: key);
  static String routeName = 'MyProfileScreen';
  String? firstName = MongoDataBase.sfirstName;
  String? lastName = MongoDataBase.slastName;
  String? department = MongoDataBase.sdepartment;
  String? email = MongoDataBase.semail;
  String? studentno = MongoDataBase.sstudentno;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app bar theme for tablet
      appBar: AppBar(
        backgroundColor: kBkrColor,
        title: Text('Profilim'),
        actions: [
          InkWell(
            onTap: () {
              //send report to school management, in case if you want some changes to your profile
            },
            child: Container(
              padding: EdgeInsets.only(right: kDefaultPadding / 2),
              child: Row(
                children: [
                  Icon(Icons.report_gmailerrorred_outlined),
                  kHalfWidthSizedBox,
                  Text(
                    'Rapor',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: homepagefont,
        child: Column(
          children: [
            Container(
              width: 100.w,
              height: SizerUtil.deviceType == DeviceType.tablet ? 19.h : 15.h,
              decoration: BoxDecoration(
                color: kBkrColor,
                borderRadius: kBottomBorderRadius,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius:
                        SizerUtil.deviceType == DeviceType.tablet ? 12.w : 13.w,
                    backgroundColor: kSecondaryColor,
                    backgroundImage: AssetImage('assets/images/studdent.jpg'),
                  ),
                  kWidthSizedBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'TeleSağlık',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text('Platformu',
                          style:
                              Theme.of(context).textTheme.subtitle2?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  )),
                    ],
                  )
                ],
              ),
            ),
            sizedBox,
            sizedBox,
            ProfileDetailColumn(
              title: 'Email',
              value: '$email',
            ),
            ProfileDetailColumn(
              title: 'İsim Soyisim',
              value: '$firstName $lastName',
            ),
            ProfileDetailColumn(
              title: 'Bölüm',
              value: '$department',
            ),
            ProfileDetailColumn(
              title: 'Öğrenci No',
              value: '$studentno',
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: kDefaultPadding * 2,
          right: kDefaultPadding * 2,
          bottom: kDefaultPadding,
        ),
        height: 70,
        decoration: BoxDecoration(
            color: homepagefont, //.withOpacity(0.40),Colors.white,
            boxShadow: [
              /* BoxShadow(
              offset: Offset(0,-10),
              blurRadius: 35,
              color: kBkrColor.withOpacity(0.38),
            )*/
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, HomeScreen.routeName, (route) => false);
              },
              icon: SvgPicture.asset(
                'assets/icons/homei.svg',
                width: 50,
                height: 50,
              ),
            ), //Icon(Icons.home_outlined),),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AssignmentScreen.routeName);
              },
              icon: SvgPicture.asset(
                'assets/icons/conferance.svg',
                width: 50,
                height: 50,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, GeneralScreen.routeName);
              },
              icon: SvgPicture.asset(
                'assets/icons/icecream.svg',
                width: 50,
                height: 50,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, MyProfileScreen.routeName);
              },
              icon: SvgPicture.asset(
                'assets/icons/profilo.svg',
                width: 50,
                height: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileDetailColumn extends StatelessWidget {
  const ProfileDetailColumn(
      {Key? key, required this.title, required this.value})
      : super(key: key);
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(alignment: Alignment.topRight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: kTextBlackColor,
                          fontSize: 18,
                        ),
                  ),
                ),
                kHalfSizedBox,
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12,bottom: 12),
                  child: Text(value,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.black45, fontSize: 16,fontWeight:  FontWeight.bold)),
                ),

              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                Icons.lock_outline,
                size: 10.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
