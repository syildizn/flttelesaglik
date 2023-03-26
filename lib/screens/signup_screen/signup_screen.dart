import 'package:flutter/material.dart';
import 'package:telesaglikk/components/custom_buttons.dart';
import 'package:telesaglikk/constants.dart';
import 'package:telesaglikk/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:telesaglikk/screens/login_screen/login_screen.dart';
import 'package:telesaglikk/screens/resetpassword_screen/resetpassword_screen.dart';
import 'package:telesaglikk/screens/signup_screen/signup_screen.dart';
import 'package:google_fonts/google_fonts.dart';


late bool _passwordVisible;

class SignupScreen extends StatefulWidget{
  static String routeName = 'SignupScreen';
  @override
  State<StatefulWidget> createState() {

    return _SignupScreenState();
  }

}

class _SignupScreenState extends State<SignupScreen>{

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
                      Text('KAYIT OL',
                          style: Theme.of(context).textTheme.subtitle1),
                      Text('Lütfen Bilgilerinizi Giriniz',
                          style: //Theme.of(context).textTheme.bodyMedium,
                        TextStyle(color: Colors.white,
                          fontSize: 17),),
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
                  //key: _formKey,
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        sizedBox,
                        buildEmailField(),
                        sizedBox,
                        buildPasswordField(),
                        sizedBox,
                        buildNameField(),
                        sizedBox,
                        buildLastNameField(),
                        sizedBox,
                        buildDepartmentField(),
                        sizedBox,
                        buildSchoolNumberField(),
                        sizedBox,

                        ElevatedButton(

                          onPressed: () {
                            if(_formKey.currentState!.validate()){
                              String message = "Hesabınız onaylandığında size e-mail gönderilecektir";
                              var alert = AlertDialog(
                                backgroundColor: kBkrColor,
                                title: Text("Kayıt Başarılı",style: GoogleFonts.sourceSansPro(
                                  textStyle: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.normal,
                                    color: Colors.white,
                                  ),
                                ),),
                                content: Text(
                                  message,
                                  style: GoogleFonts.sourceSansPro(
                                    textStyle: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );

                              //print(message);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(builder: (context) => LoginScreen()),
                                      );
                                    },
                                    child: Container(
                                      //color: kBkrColor,
                                      color: Colors.transparent,
                                      child: alert,
                                    ),
                                  );
                                },
                              );
                            }

                          },
                          child: Text(
                            'Kayıt Ol',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: kBkrColor, // background
                            onPrimary: Colors.white, // foreground
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                            fixedSize: Size(180, 30),

                          ),
                          //color: Colors.blue, // Burada butonun rengini değiştirdik
                          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),

                        sizedBox,





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

  buildNameField() {
    return TextFormField(
      textAlign: TextAlign.start,
      keyboardType: TextInputType.name,
      style: kInputTextStyle,
      decoration: InputDecoration(
        labelText: 'Adınızı Giriniz',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        //for validation
        //RegExp regExp = new RegExp(emailPattern);
        if (value == null || value.isEmpty) {
          return 'Lütfen Bir Ad Giriniz';
          //if it does not matches the pattern, like
          //it not contains @
        } else if (value.length<2) {
          return 'Lütfen Geçerli Bir Ad Giriniz';
        }
      },
    );




  }

  buildLastNameField() {
    return TextFormField(
      textAlign: TextAlign.start,
      keyboardType: TextInputType.name,
      style: kInputTextStyle,
      decoration: InputDecoration(
        labelText: 'Soyadınızı Giriniz',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        //for validation
        //RegExp regExp = new RegExp(emailPattern);
        if (value == null || value.isEmpty) {
          return 'Lütfen Bir Soyad Giriniz';
          //if it does not matches the pattern, like
          //it not contains @
        } else if (value.length<2) {
          return 'Lütfen Geçerli Bir Soyad Giriniz';
        }
      },
    );


  }

  buildDepartmentField() {
    return TextFormField(
      textAlign: TextAlign.start,
      keyboardType: TextInputType.name,
      style: kInputTextStyle,
      decoration: InputDecoration(
        labelText: 'Bölümünüzü Giriniz',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        //for validation
        //RegExp regExp = new RegExp(emailPattern);
        if (value == null || value.isEmpty) {
          return 'Lütfen Bir Bölüm Giriniz';
          //if it does not matches the pattern, like
          //it not contains @
        } else if (value.length<2) {
          return 'Lütfen Geçerli Bir Bölüm Giriniz';
        }
      },
    );

  }

  buildSchoolNumberField() {

    return TextFormField(
      textAlign: TextAlign.start,
      keyboardType: TextInputType.number,
      style: kInputTextStyle,
      decoration: InputDecoration(
        labelText: 'Okul Numaranızı Giriniz',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (value) {
        //for validation
        //RegExp regExp = new RegExp(emailPattern);
        if (value == null || value.isEmpty) {
          return 'Lütfen Bir Numara Giriniz';
          //if it does not matches the pattern, like
          //it not contains @
        } else if (value.length<2) {
          return 'Lütfen Geçerli Bir Numara Giriniz';
        }
      },
    );

  }
}