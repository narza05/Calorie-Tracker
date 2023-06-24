// ignore_for_file: prefer_const_constructors
import 'package:flutter_application_1/calorie_tracker/calorie_tracker.dart';
import 'package:flutter_application_1/constants_widget.dart';
import 'package:flutter_application_1/imports.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Locale _locale = const Locale('en', '');

  void setLocale(Locale value) {
    print(value);
    setState(() {
      _locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Constants.backgroundgrey,
        image: DecorationImage(
            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop),
            image: AssetImage("assets/homebg.jpg"),fit: BoxFit.cover),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Constants.backgroundgrey.withOpacity(0.1), Colors.red.withOpacity(0.1)],begin: Alignment.topCenter, stops: [0,1]),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
          constraints: BoxConstraints.tightFor(
            height: Constants.getScreenHeight(context),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Stack(
              children: [
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ConstantsWidget.getTopLeftButton(Icons.menu_rounded, Alignment.topLeft, 0, (){}),
                        Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Text(
                            "Hello Ankush!",
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 100, left: 20, right: 20),
                      child: Row(
                        children: [
                          homeFeatures("Calorie Tracker", Icons.directions_run,
                              () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return CalorieTracker();
                            }));
                          }),
                          SizedBox(
                            width: 10,
                          ),
                          homeFeatures("BMI", Icons.calculate, () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return CalorieTracker();
                            }));
                          }),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
            ),
          ),
        ),
      ),
    ));
  }
}

class homeFeatures extends StatelessWidget {
  String text = "";
  IconData icon;
  Function() ontap = () {};

  homeFeatures(this.text, this.icon, this.ontap);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          height: 100,
          decoration: ConstantsWidget.getContainerBorder( Colors.white, 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 35,
                color: Constants.myred,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                text,
                style: TextStyle(
                    fontSize: 11,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
