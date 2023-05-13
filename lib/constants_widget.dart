import 'package:flutter_application_1/imports.dart';

class ConstantsWidget {

  static TextStyle listItemText(Color color, double size, FontWeight fontWeight) {
    return TextStyle(
        fontFamily: "Poppins",
        fontWeight: fontWeight,
        fontSize:  size,
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

  static BoxDecoration getContainerBorder(
      Color bgcolor, Color color, double radius, double width) {
    var decoration = BoxDecoration(
      border: Border.all(color: color, width: width),
      borderRadius: BorderRadius.all(
        Radius.circular(radius),
      ),
      color: bgcolor,
    );
    return decoration;
  }

  static Container getTopLeftButton(IconData iconData) {
    var button = Container(
      margin: EdgeInsets.only(left: 20),
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(color: Constants.myred, width: 1),
      ),
      child: Icon(iconData),
    );
    return button;
  }

  static Align getBottomButton(String text, double pbottom, double ptop) {
    var button = Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: pbottom, left: 10, right: 10, top: ptop),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            color: Constants.myred,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Text(
          text,
          style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ),
    );
    return button;
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

  static Widget getTextField(
    double width,
    double ptop,
    String hint,
      TextEditingController? controller
  ) {
    var textfield = Container(
      height: 45,
      width: double.infinity,
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
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
