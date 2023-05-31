import 'package:telesaglikk/constants.dart';
import 'package:flutter/material.dart';

class GeneralScreen extends StatelessWidget {
  const GeneralScreen({Key? key}) : super(key: key);
  static String routeName = 'GeneralScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            child: Text("Bu sayfa halen yapım aşamasındadır. "
                "Tahmini tamamlanma tarihi: 30/02/2032",style: TextStyle(fontSize: 45,color: kBkrColor)),
          ),
        ],
      ),
    );
  }
}
