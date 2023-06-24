import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class Constants {
  static final String ROOT_URL = "http://192.168.0.186/fitness/";
  static final String FOOD_ADDFOOD_URL = ROOT_URL + "food/addFood.php";
  static final String FOOD_GETFOOD_URL = ROOT_URL + "food/getFood.php";
  static final String TRACKER_ADDFOOD_URL = ROOT_URL + "tracker/addFood.php";
  static final String TRACKER_GETFOOD_URL = ROOT_URL + "tracker/getFood.php";
  static final String TRACKER_DELETEFOOD_URL = ROOT_URL + "tracker/deleteFood.php";
  static final String ADD_DETAILS = ROOT_URL + "user/addDetails.php";

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
  static getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static DateTime getCurrentDateTime() {
    DateTime now = new DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    return date;
  }
  static String getCurrentDate() {
    DateTime now = new DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    String date1 = date.toString().replaceAll("00:00:00.000", "");
    String date2 = date1.toString().replaceAll("-", ",");
    return date1;
  }

  static String getCurrentDay(){
    DateTime date = DateTime.now();
    String dateFormat = DateFormat('EEEE').format(date);
    return dateFormat;
  }
}
