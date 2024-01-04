import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:telesaglikk/MongoDb.dart';
import 'package:telesaglikk/constants.dart';
import 'package:telesaglikk/screens/assignment_screen/data/assignment_data.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
//import 'package:url_launcher/url_launcher.dart';
import '../general_screen/general_screen.dart';
import '../home_screen/home_screen.dart';
import '../my_profile/my_profile.dart';
import 'widgets/assignment_widgets.dart';

class AssignmentScreen extends StatelessWidget {
  const AssignmentScreen({Key? key}) : super(key: key);
  static String routeName = 'AssignmentScreen';

  static String? doctorName;
  static String? patientNo = MongoDataBase.sstudentno;

  final String websiteURL =
      "https://www.google.com/"; //"https://meet.jit.si/emreturanMauroIcardi1234567890";

  void _launchURL(String link) async {
    print("öğrenci no: $patientNo");
    print("tuşa basıldı");
    //await InAppWebView.openWithSystemBrowser(websiteURL);
    await InAppBrowser.openWithSystemBrowser(url: Uri.parse(link));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homepagefont,
      appBar: AppBar(
        backgroundColor: kBkrColor,
        title: Text('Randevularım'),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: MongoDataBase.myappointmentsorgu(patientNo!),
          builder: (context, AsyncSnapshot snapshot) {
            final myappointments = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: homepagefont,
                          borderRadius: kTopBorderRadius,
                        ),
                        child: ListView.builder(
                            padding: EdgeInsets.all(kDefaultPadding),
                            itemCount: myappointments.length,
                            itemBuilder: (context, int index) {
                              final appointment = myappointments[index];

                              return Container(
                                margin:
                                    EdgeInsets.only(bottom: kDefaultPadding),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        padding:
                                            EdgeInsets.all(kDefaultPadding),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              kDefaultPadding),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: kTextLightColor,
                                              blurRadius: 2.0,
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                width: 60.w,
                                                height: 5.5.h,
                                                decoration: BoxDecoration(
                                                  color: kSecondaryColor
                                                      .withOpacity(0.4),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          kDefaultPadding),
                                                ),
                                                child: FutureBuilder(
                                                  future: MongoDataBase
                                                      .doctorappointmentsorgu(
                                                          appointment[
                                                              "doctorId"]),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      doctorName =
                                                          snapshot.data;
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          "Doktor:$doctorName",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 13),
                                                        ),
                                                      );
                                                    } else if (snapshot
                                                        .hasError) {
                                                      return Text(
                                                          'Bir hata oluştu');
                                                    } else {
                                                      return CircularProgressIndicator();
                                                    }
                                                  },
                                                )),
                                            kHalfSizedBox,
                                            Text(
                                              "Hasta: ${appointment["patientFirstName"]} ${appointment["patientLastName"]}" /*"null "*/,
                                              //snapshot.data[index].patientId,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(
                                                    color: kTextBlackColor,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                            ),
                                            kHalfSizedBox,
                                            // AssignmentDetailRow(
                                            //   title: 'Randevu Günü',
                                            //   data: snapshot.data[index].date,
                                            // ),
                                            kHalfSizedBox,
                                            AssignmentDetailRow(
                                              title: "Randevu Tarihi:",
                                              statusValue: appointment[
                                                  "date"] /*"null "*/,
                                            ),

                                            kHalfSizedBox,
                                            AssignmentDetailRow(
                                              title: 'Randevu Saati',
                                              statusValue: appointment[
                                                  "hour"] /*"null "*/,
                                            ),
                                            kHalfSizedBox,
                                            //use condition here to display button
                                            if (appointment["accepted"] == '1')
                                              //then show button
                                              AssignmentButton(
                                                onPress: () {
                                                  //submit here
                                                  final String mahmut =
                                                      "${appointment["_id"].$oid}";
                                                  final String tahta =
                                                      "https://meet.jit.si/$mahmut";
                                                  print("link: $tahta");
                                                  print(" tuşa basıldı");
                                                  _launchURL(tahta);
                                                },
                                                title: 'TUŞ',
                                              ),
                                          ],
                                        )),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Text("Data has not found"),
                );
              }
            }
          },
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
