import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:telesaglikk/MongoDb.dart';
import 'package:telesaglikk/constants.dart';
import 'package:telesaglikk/models/students_model.dart';

class DoctorProfilePage extends StatefulWidget {
  static String routeName = 'DoctorProfilePage';
  static String? imageUrl;

  static Student? doctor;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    print(doctor?.firstName);
    return _DoctorProfilePageState();
  }
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  late Student doctor;
  late String? imageUrl;

  @override
  void initState() {
    super.initState();
    doctor = DoctorProfilePage.doctor!;
    imageUrl = DoctorProfilePage.imageUrl;
    print(imageUrl);
  }

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
        title: Text("${doctor.firstName} ${doctor.lastName}",
            textScaleFactor: 1,
            style: GoogleFonts.sourceSansPro(
                textStyle: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              color: kBkrColor,
            ))),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.34,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imageUrl!),
                fit: BoxFit.cover,
              ),
            ),
            // child: Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     CircleAvatar(
            //       radius: 50,
            //       backgroundImage: AssetImage(imageUrl!),
            //     ),
            //     SizedBox(height: 16),
            //     Text(
            //       "${doctor.firstName} ${doctor.lastName}",
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 24,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ],
            // ),
          ),
          sizedBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text('Sesli Arama'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Görüntülü Arama'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('Mesajlaşma'),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Kalp Damar Cerrahı",
                  style: TextStyle(color: Colors.black),
                ),
                sizedBox,
                Text(
                  "Hakkında ",
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
                SizedBox(height: 7),
                Text(
                  "Dr. Mehmet Yılmaz, İstanbul Üniversitesi Tıp Fakültesi'nden"
                  " mezun olduktan sonra Duke Üniversitesi'nde kardiyovasküler"
                  " cerrahi eğitimi aldı. Türkiye'ye dönüp bir özel hastanede"
                  " çalıştıktan sonra 2005'te kendi kliniğini açtı. Dr. Yılmaz, "
                  "kardiyovasküler cerrahi konusunda uzman ve hastalarına kişisel"
                  " bir yaklaşım benimseyen bir doktordur. Ayrıca, Türkiye Kardiyovasküler"
                  " Cerrahi Derneği üyesi ve cerrahi yayınların yazarı/hakemidir.",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                sizedBox,
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Randevu Oluştur'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
