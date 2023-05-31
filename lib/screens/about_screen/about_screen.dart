import 'package:flutter/material.dart';

import '../../constants.dart ';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);
  static String routeName = 'AboutScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hakkımızda'),
      ),
      body: Column(
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
        ],
      ),
    );
  }
}
