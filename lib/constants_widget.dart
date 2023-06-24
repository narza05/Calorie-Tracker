import 'dart:ui';

import 'package:flutter_application_1/imports.dart';

class ConstantsWidget {
  static TextStyle listItemText(
      Color color, double size, FontWeight fontWeight) {
    return TextStyle(
        fontFamily: "Poppins",
        fontWeight: fontWeight,
        fontSize: size,
        color: color);
  }

  static Widget getBasicScreen(BuildContext context, Widget child) {
    var screen = Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints.tightFor(
                height: Constants.getScreenHeight(context),
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
    return screen;
  }

  static getAppBar(String title, Widget? widget) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: 50,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.arrow_back,
                size: 20,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                    fontFamily: "Poppins", fontWeight: FontWeight.bold),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: widget,
            ),
          ],
        ),
      ),
    );
  }


  static getContainerBorder(Color color, double radius) {
    return BoxDecoration(
        color: color, borderRadius: BorderRadius.all(Radius.circular(radius)));
  }

  static Widget getTopLeftButton(IconData iconData, AlignmentGeometry align,
      double ptop, Function() ontap) {
    var button = GestureDetector(
      onTap: ontap,
      child: Align(
        alignment: align,
        child: Container(
          margin: EdgeInsets.only(top: ptop, left: 20, right: 20),
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            border:
                Border.all(color: Constants.mygrey.withOpacity(0), width: 1),
          ),
          child: Icon(
            iconData,
            color: Colors.black,
            size: 22,
          ),
        ),
      ),
    );
    return button;
  }

  static getBottomButton(String text) {
    return Align(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: Constants.myred
        ),
        child: Center(child: Text(text, style: TextStyle(
            color: Colors.white,
            fontFamily: "Poppins",
            fontSize: 16
        ),)),
      ),
    );
  }

  static Widget getFadedContainer(
      double width, Color color1, Color color2, Widget child) {
    var container = Expanded(
      child: Container(
        width: width,
        foregroundDecoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color1,
              color2,
            ],
            begin: Alignment(0, -0.7),
            end: Alignment(0, -1),
            stops: [0, 1],
          ),
        ),
        child: child,
      ),
    );
    return container;
  }

  static Widget getTextField(double width, double ptop, String hint,
      TextEditingController? controller) {
    var textfield = Container(
      height: 45,
      width: double.infinity,
      margin: EdgeInsets.only(left: 10, right: 10, top: ptop),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: EdgeInsets.all(0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(width: 2, color: Constants.mygrey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(width: 2, color: Constants.mygrey),
          ),
        ),
      ),
    );
    return textfield;
  }
}
