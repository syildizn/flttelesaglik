import 'package:flutter_svg/svg.dart';
import 'package:telesaglikk/constants.dart';
import 'package:flutter/material.dart';

import '../assignment_screen/assignment_screen.dart';
import '../home_screen/home_screen.dart';
import '../my_profile/my_profile.dart';

class GeneralScreen extends StatelessWidget {
  const GeneralScreen({Key? key}) : super(key: key);
  static String routeName = 'GeneralScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: homepagefont,
      appBar: AppBar(
        backgroundColor: kBkrColor,
        title: Text('Yapım Aşamasında'),
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
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                  "Bu sayfa halen yapım aşamasındadır. "
                  "Tahmini tamamlanma tarihi: 30/02/2032",
                  style: TextStyle(fontSize: 25, color: kBkrColor)),
            ),
          ),
        ],
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
