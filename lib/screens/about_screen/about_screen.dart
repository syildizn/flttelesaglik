import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart ';
import '../assignment_screen/assignment_screen.dart';
import '../general_screen/general_screen.dart';
import '../home_screen/home_screen.dart';
import '../my_profile/my_profile.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);
  static String routeName = 'AboutScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homepagefont,
      appBar: AppBar(
        backgroundColor: kBkrColor,
        title: Text('Hakkımızda'),
      ),
      body: SingleChildScrollView(scrollDirection:Axis.vertical ,
        child: Column(
          children: [
            SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.34,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/backround.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            sizedBox,
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "Telesağlık platformu, hastaların doktorlarla görüntülü olarak iletişim kurabildiği, "
                        "online randevu oluşturabildiği ve muayene olabildiği bir dijital sağlık hizmetidir."
                        " Bu platform, kullanıcıların doktorlarıyla etkileşime geçmelerini sağlayan bir sanal ortam sağlar. "
                        "Hastalar, cihazlarından (bilgisayar, akıllı telefon veya tablet) telesağlık uygulamasına erişerek randevu alabilir"
                        " ve ilgili doktorla bir görüntülü görüşme yapabilir. Telesağlık platformu, kullanıcılara çeşitli sağlık hizmetlerine erişim imkanı sunar."
                        " Hastalar, genel sağlık kontrolü, akut hastalık durumları, kronik rahatsızlıkların takibi, ilaç danışmanlığı, "
                        "laboratuvar sonuçlarının değerlendirilmesi gibi konularda doktorlarıyla görüşebilir ve gerektiğinde "
                        "uzaktan muayene olabilir. Ayrıca, doktorlar hastalık tanısı koymak, tedavi planı oluşturmak veya hastaların mevcut "
                        "tedavilerini yönetmek için telesağlık platformunu kullanabilirler.",

                    style: TextStyle(fontSize: 15, color: Colors.black)),
              ),
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
