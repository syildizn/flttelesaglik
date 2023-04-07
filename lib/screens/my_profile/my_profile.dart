import 'package:telesaglikk/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../MongoDb.dart';

class MyProfileScreen extends StatelessWidget {
  //const MyProfileScreen({Key? key}) : super(key: key);
  static String routeName = 'MyProfileScreen';
  String? firstName = MongoDataBase.sfirstName;
  String? lastName = MongoDataBase.slastName;
  String? department = MongoDataBase.sdepartment;
  String? email = MongoDataBase.semail;
  String? studentno = MongoDataBase.sstudentno ;

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
        color: kOtherColor,
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
                    backgroundImage:
                    AssetImage('assets/images/unknown.jpg'),
                  ),
                  kWidthSizedBox,

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$firstName $lastName',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text('$department',
                          style: Theme.of(context).textTheme.subtitle2?.copyWith(
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  )
                ],
              ),
            ),
            sizedBox,
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     ProfileDetailRow(
            //         title: 'Registration Number', value: '2020-ASDF-2021'),
            //     ProfileDetailRow(title: 'Academic Year', value: '2020-2021'),
            //   ],
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ProfileDetailRow(title: 'Öğrenci No', value: '$studentno'),
                ProfileDetailRow(title: 'Öğrenci Bilgisi 1', value: 'Null'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ProfileDetailRow(
                    title: 'Sınıfı', value: '2. Sınıf'),
                ProfileDetailRow(title: 'Doğum Tarihi', value: '6 Şubat 2003'),
              ],
            ),
            sizedBox,
            ProfileDetailColumn(
              title: 'Email',
              value: '$email',
            ),
            ProfileDetailColumn(
              title: 'Öğrenci Bilgisi 2',
              value: 'Null',
            ),
            ProfileDetailColumn(
              title: 'Öğrenci Bilgisi 3',
              value: 'Null',
            ),
            ProfileDetailColumn(
              title: 'Öğrenci Bilgisi 4',
              value: 'Null',
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileDetailRow extends StatelessWidget {
  const ProfileDetailRow({Key? key, required this.title, required this.value})
      : super(key: key);
  final String title;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: Colors.black,
                  fontSize: SizerUtil.deviceType == DeviceType.tablet
                      ? 7.sp
                      : 9.sp,
                ),
              ),
              kHalfSizedBox,
              Text(value, style: Theme.of(context).textTheme.caption?.copyWith(
                color: Colors.black,
                fontSize: 11.5,
              )),
              kHalfSizedBox,
              SizedBox(
                width: 35.w,
                child: Divider(
                  thickness: 1.0,
                ),
              ),
            ],
          ),
          Icon(
            Icons.lock_outline,
            size: 10.sp,
          ),
        ],
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
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: kTextBlackColor,
                  fontSize: SizerUtil.deviceType == DeviceType.tablet
                      ? 7.sp
                      : 11.sp,
                ),
              ),
              kHalfSizedBox,
              Text(value, style: Theme.of(context).textTheme.caption?.copyWith(
                color: Colors.black,
                fontSize: 11.5,)),
              kHalfSizedBox,
              SizedBox(
                width: 92.w,
                child: Divider(
                  thickness: 1.0,
                ),
              )
            ],
          ),
          Icon(
            Icons.lock_outline,
            size: 10.sp,
          ),
        ],
      ),
    );
  }
}