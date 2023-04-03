import 'package:telesaglikk/MongoDb.dart';
import 'package:telesaglikk/components/custom_buttons.dart';
import 'package:telesaglikk/constants.dart';
import 'package:telesaglikk/models/students_model.dart';
import 'package:telesaglikk/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:telesaglikk/screens/resetpassword_screen/resetpassword_screen.dart';
import 'package:telesaglikk/screens/signup_screen/signup_screen.dart';

late bool _passwordVisible;

class LoginScreen extends StatefulWidget {
  static String routeName = 'LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //validate our form now
  final _formKey = GlobalKey<FormState>();

  //changes current state
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //when user taps anywhere on the screen, keyboard hides
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: kBkrColor,
        body: Column(

          children: [
            Container(

              width: 100.w,
              height: 35.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(

                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hoş Geldiniz',
                          style: Theme.of(context).textTheme.subtitle1),
                      Text('Lütfen Giriş Yapınız',
                          style: Theme.of(context).textTheme.subtitle1),
                      sizedBox,
                    ],
                  ),
                  Image.asset(
                    'assets/images/logobb.png',
                    height: 20.h,
                    width: 40.w,
                  ),
                  SizedBox(
                    height: kDefaultPadding / 2,
                  ),
                ],
              ),
            ),

            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                decoration: BoxDecoration(
                  color: kOtherColor,
                  //reusable radius,
                  borderRadius: kTopBorderRadius,
                ),

                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        sizedBox,
                        buildEmailField(),
                        sizedBox,
                        buildPasswordField(),
                        sizedBox,

                        ElevatedButton(
                          onPressed: () {

                            // try {
                            //
                            //   }
                            // } catch (e) {
                            //
                            // }


                            if (_formKey.currentState!.validate()) {
                              Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
                            }
                          },
                          child: Text(
                            'Giriş',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: kBkrColor, // background
                            onPrimary: Colors.white, // foreground
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                            fixedSize: Size(180, 50),

                          ),

                        ),

                        sizedBox,

                        Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(context, RessetpasswordScreen.routeName, (route) => true);
                            },
                            child: Text(
                              'Şifremi Unuttum',

                              style: TextStyle(color: Colors.white,
                                fontSize: 8,),
                              textAlign: TextAlign.end,



                            ),
                            style: ElevatedButton.styleFrom(

                              primary: kBkrColor, //Colors.cyan, // background
                              onPrimary: Colors.white, // foreground
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              fixedSize: Size(100, 20),

                            ),

                          ),
                        ),
                        sizedBox,
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(context, SignupScreen.routeName, (route) => true);
                            },
                            child: Text(
                              'Kayıt Ol',

                              style: TextStyle(color: Colors.white,
                                fontSize: 10,),
                              textAlign: TextAlign.end,



                            ),
                            style: ElevatedButton.styleFrom(

                              primary: kBkrColor, // background
                              onPrimary: Colors.white, // foreground
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              fixedSize: Size(100, 20),

                            ),

                          ),
                        )


                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextFormField buildEmailField() {
    return TextFormField(
      textAlign: TextAlign.start,
      keyboardType: TextInputType.emailAddress,
      style: kInputTextStyle,
      decoration: InputDecoration(
        labelText: 'Email Giriniz',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        //for validation
        RegExp regExp = new RegExp(emailPattern);
        if (value == null || value.isEmpty) {
          return 'Lütfen Bir Mail Giriniz';
          //if it does not matches the pattern, like
          //it not contains @
        } else if (!regExp.hasMatch(value)) {
          return 'Lütfen Geçerli Bir Mail Giriniz';
        }
      },
    );
  }

  TextFormField buildPasswordField() {
    return TextFormField(
      obscureText: _passwordVisible,
      textAlign: TextAlign.start,
      keyboardType: TextInputType.visiblePassword,
      style: kInputTextStyle,
      decoration: InputDecoration(
        labelText: 'Şifre',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
          icon: Icon(
            _passwordVisible
                ? Icons.visibility_off_outlined
                : Icons.visibility_off_outlined,
          ),
          iconSize: kDefaultPadding,
        ),
      ),
      validator: (value) {
        if (value!.length < 5) {
          return '5 Karakterden Daha Uzun Olmalı';
        }
      },
    );
  }

  // Widget _snapdata(){
  //
  //   return FutureBuilder(
  //       future: MongoDataBase.getQueryData(),
  //       builder: (context, AsyncSnapshot snapshot){
  //         if(snapshot.connectionState == ConnectionState.waiting){
  //           return Center (
  //             child: CircularProgressIndicator(),
  //           );
  //         }else{
  //           if(snapshot.hasData){
  //             return ListView.builder(
  //                 itemCount: snapshot.data.length,
  //                 itemBuilder: (context,index){
  //                   return dataSorgu(Student.fromJson(snapshot.data[index]));
  //                 }
  //             );
  //           }
  //         }
  //       }
  //   );
  //
  // }
  //
  // Widget dataSorgu(Student student) {
  //
  //
  //
  // }


}