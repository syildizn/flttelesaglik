import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:telesaglikk/MongoDb.dart';
import 'package:telesaglikk/constants.dart';
import 'package:telesaglikk/models/students_model.dart';
import 'package:telesaglikk/screens/appointment_screen/appointment_page.dart';
import 'package:telesaglikk/screens/doctors_page/doctorProfile_page.dart';

import '../../models/doctors_model.dart';

class DoctorsPage extends StatefulWidget {
  static String routeName = 'DoctorPage';
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DoctorPageState();
  }
}

class _DoctorPageState extends State<DoctorsPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: homepagefont,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: kBkrColor,
            size: 25,
          ),
          backgroundColor: homepagefont,
          title: Text("Doktorlar",
              textScaleFactor: 1,
              style: GoogleFonts.sourceSansPro(
                  textStyle: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
                color: kBkrColor,
              ))),
        ),
        body: SafeArea(
          child: FutureBuilder(
              future: MongoDataBase.getData(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData) {
                    var totaldata = snapshot.data.length;
                    print("Total data: $totaldata");
                    // return ListView.builder(
                    //     itemCount: snapshot.data.length,
                    //     itemBuilder: (context,index){
                    //         //return doctorCard(Student.fromJson(snapshot.data[index]));
                    //           return DoctorCard(onPress: () {}, color: Colors.white, colortext: Colors.black, doctor: Student.fromJson(snapshot.data[index]));
                    //       }
                    //     );
                    return ListView.builder(
                      itemCount: (totaldata / 2).ceil(),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Expanded(
                                child: DoctorCard(
                                  onPress: () {
                                    DoctorProfilePage.imageUrl = 'assets/images/doctoro.png';
                                    AppointmentPage.doctor = Doctor.fromJson(
                                        snapshot.data[index * 2]);
                                    DoctorProfilePage.doctor = Doctor.fromJson(
                                        snapshot.data[index * 2]);
                                    Navigator.pushNamed(

                                        context, DoctorProfilePage.routeName);
                                  },
                                  color: Colors.white,
                                  colortext: Colors.black,
                                  doctor: Doctor.fromJson(
                                      snapshot.data[index * 2]),
                                  icon: 'assets/images/doctoro.png',
                                ),
                              ),
                              kWidthSizedBox,
                              (index * 2 + 1 < totaldata)
                                  ? Expanded(
                                      child: DoctorCard(
                                        onPress: () {
                                          DoctorProfilePage.imageUrl = 'assets/images/doctoro.png';
                                          AppointmentPage.doctor = Doctor.fromJson(
                                              snapshot.data[index * 2 + 1]);
                                          DoctorProfilePage.doctor = Doctor.fromJson(
                                              snapshot.data[index * 2 + 1]);
                                          Navigator.pushNamed(
                                              context, DoctorProfilePage.routeName);
                                        },
                                        color: Colors.white,
                                        colortext: Colors.black,
                                        doctor: Doctor.fromJson(
                                            snapshot.data[index * 2 + 1]),
                                        icon: 'assets/images/doctoro.png',
                                      ),
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text("No data available "),
                    );
                  }
                }
              }),
        ));
  }

  }



  class DoctorCard extends StatelessWidget {
    const DoctorCard({
      Key? key,
      required this.onPress,
      required this.icon,
      //required this.title,
      required this.color,
      required this.colortext,
      required this.doctor,
    }) : super(key: key);
    final VoidCallback onPress;
    final String icon;
    //final String title;
    final Color color;
    final Color colortext;
    final Doctor doctor;

    @override
    Widget build(BuildContext context) {
      return InkWell(
        onTap: onPress,
        child: Container(
          margin: EdgeInsets.only(top: 1.h),
          width: 40.w,
          height: 30.h,
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
              Container(
              height: SizerUtil.deviceType == DeviceType.tablet ? 24.w : 26.w,
              width: SizerUtil.deviceType == DeviceType.tablet ? 24.w : 26.w,

                child:CircleAvatar(
                  backgroundColor: kSecondaryColor,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(icon),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              // SvgPicture.asset(
              //   icon,
              //   height: SizerUtil.deviceType == DeviceType.tablet ? 30.sp : 40.sp,
              //   width: SizerUtil.deviceType == DeviceType.tablet ? 30.sp : 40.sp,
              //   color: colortext,
              // ),
              // Text(
              //   title,
              //   textAlign: TextAlign.left,
              //   style: Theme.of(context).textTheme.subtitle2?.copyWith(color: colortext, fontSize: 22, fontWeight: FontWeight.bold),
              // ),
              Text(
                "${doctor.firstName} ${doctor.lastName}",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                    color: colortext, fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                "${doctor.department}",
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                    color: colortext, fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    }
  }
