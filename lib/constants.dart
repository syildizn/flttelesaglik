import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';


//mongoDb

const DB_CONNECTION_STRING = "mongodb+srv://syzbakircayprojects:bakircay123@clustersyzproject.0fg8bny.mongodb.net/BakircayTeleSaglik?retryWrites=true&w=majority";
const Collection_Name = "students";



//colors
const Color kPrimaryColor = Color(0xFF345FB4);
const Color kSecondaryColor = Color(0xFF6789CA);
const Color kTextBlackColor = Color(0xFF313131);
const Color kTextWhiteColor = Color(0xFFFFFFFF);
const Color kContainerColor = Color(0xFF777777);
const Color kOtherColor = Color(0xFFF4F6F7);
const Color kTextLightColor = Color(0xFFA5A5A5);
const Color kErrorBorderColor = Color(0xFFE74C3C);
const Color kBkrColor = Color.fromRGBO(0, 165, 181, 1.0);
const Color homecard1 = Color.fromRGBO(104,209,169,1.0);
const Color homecard2 = Color.fromRGBO(137,101,223,1.0);
const Color homecard3 = Color.fromRGBO(255,203,67,1.0);
const Color homecard4 = Color.fromRGBO(240,54,103,1.0);
const Color homecard5 = Color.fromRGBO(104,121,225,1.0);
const Color homecard6 = Color.fromRGBO(236,106,84,1.0);
const Color homefont = Color.fromRGBO(250, 255, 255, 1);




//rgba(104,209,169,255)

//default value
const kDefaultPadding = 20.0;

const sizedBox = SizedBox(
  height: kDefaultPadding,
);
const kWidthSizedBox = SizedBox(
  width: kDefaultPadding,
);

const kHalfSizedBox = SizedBox(
  height: kDefaultPadding / 2,
);

const kHalfWidthSizedBox = SizedBox(
  width: kDefaultPadding / 2,
);

final kTopBorderRadius = BorderRadius.only(
  topLeft: Radius.circular(SizerUtil.deviceType == DeviceType.tablet ? 40 : 20),
  topRight:
  Radius.circular(SizerUtil.deviceType == DeviceType.tablet ? 40 : 20),
);

final kBottomBorderRadius = BorderRadius.only(
  bottomRight: Radius.circular(SizerUtil.deviceType == DeviceType.tablet ? 40 : 20),
  bottomLeft:
  Radius.circular(SizerUtil.deviceType == DeviceType.tablet ? 40 : 20),
);

final kInputTextStyle = GoogleFonts.poppins(
    color: kTextBlackColor,
    fontSize: 11.sp,
    fontWeight: FontWeight.w500
);

//validation for mobile
const String mobilePattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';

//validation for email
const String emailPattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';