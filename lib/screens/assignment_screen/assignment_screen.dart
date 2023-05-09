import 'package:telesaglikk/MongoDb.dart';
import 'package:telesaglikk/constants.dart';
import 'package:telesaglikk/screens/assignment_screen/data/assignment_data.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'widgets/assignment_widgets.dart';

class AssignmentScreen extends StatelessWidget {
  const AssignmentScreen({Key? key}) : super(key: key);
  static String routeName = 'AssignmentScreen';

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
          future: MongoDataBase.myappointmentsorgu("22356"),
          builder: (context,AsyncSnapshot snapshot){
            final myappointments = snapshot.data;
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }else{
              if(snapshot.hasData){
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
                                margin: EdgeInsets.only(bottom: kDefaultPadding),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(kDefaultPadding),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(kDefaultPadding),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: kTextLightColor,
                                              blurRadius: 2.0,
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 40.w,
                                              height: 4.h,
                                              decoration: BoxDecoration(
                                                color: kSecondaryColor.withOpacity(0.4),
                                                borderRadius:
                                                BorderRadius.circular(kDefaultPadding),
                                              ),
                                              child: FutureBuilder(
                                                future: MongoDataBase.doctorappointmentsorgu(appointment["doctorId"]),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    final doctorName = snapshot.data;
                                                    return Text(
                                                      doctorName!,
                                                      style: TextStyle(color: Colors.black, fontSize: 13),
                                                    );
                                                  } else if (snapshot.hasError) {
                                                    return Text('Bir hata oluştu');
                                                  } else {
                                                    return CircularProgressIndicator();
                                                  }
                                                },
                                              )
                                            ),
                                            kHalfSizedBox,
                                            Text("Hasta: ${appointment["patientFirstName"]} ${appointment["patientLastName"]}"/*"null "*/,
                                              //snapshot.data[index].patientId,
                                              style: Theme.of(context).textTheme.subtitle2!.copyWith(
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
                                              title: "Randevu Tarihi:" ,
                                              statusValue: appointment["date"]/*"null "*/,
                                            ),

                                            kHalfSizedBox,
                                            AssignmentDetailRow(
                                              title: 'Randevu Saati',
                                              statusValue: appointment["hour"]/*"null "*/,
                                            ),
                                            kHalfSizedBox,
                                            //use condition here to display button
                                            if ( appointment["accepted"] == '1')
                                            //then show button
                                              AssignmentButton(
                                                onPress: () {
                                                  //submit here
                                                },
                                                title: 'TUŞ',
                                              ),
                                          ],
                                        )

                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                );
              }else{
                return Center(
                  child: Text("Data has not found"),
                );
              }
            }
          },

        ),
      ),
    );
  }
}