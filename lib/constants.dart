import 'package:flutter/material.dart';

class Constants {
  static final String ROOT_URL = "http://192.168.0.186/fitness/";
  static final String ADDFOOD_URL = ROOT_URL + "food/addFood.php";
  static final String GETFOOD_URL = ROOT_URL + "food/getFood.php";

  static final Color backgroundgrey = Color(0xfff8f8f8);
  static final Color backgroundgreyinvisible = Color.fromARGB(0, 248, 248, 248);
  static final Color myred = Color(0xffea564c);
  static final Color myredfade = Color.fromARGB(30, 234, 87, 76);
  static final Color mygrey = Color.fromARGB(255, 172, 172, 172);

  static double getScreenHeight(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    final mq = height - padding.top - padding.bottom;
    return mq;
  }

  static DateTime getCurrentDate() {
    DateTime now = new DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    String date1 = date.toString().replaceAll("00:00:00.000", "");
    String date2 = date1.toString().replaceAll("-", ",");
    return date;
  }
}
