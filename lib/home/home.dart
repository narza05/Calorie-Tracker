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
        body: SafeArea(
            child: Container(
      color: Constants.backgroundgrey,
      height: double.infinity,
      width: double.infinity,
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
                        ConstantsWidget.getTopLeftButton(Icons.menu_rounded),
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
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
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: CalendarTimeline(
                        initialDate: DateTime(2022, 1, 1),
                        firstDate: DateTime(2022, 1, 1),
                        lastDate: DateTime(2030, 1, 1),
                        onDateSelected: (date) => print(date),
                        leftMargin: 20,
                        monthColor: Constants.mygrey,
                        dayColor: Constants.mygrey,
                        activeDayColor: Colors.white,
                        activeBackgroundDayColor: Constants.myred,
                        dotsColor: Constants.mygrey,
                        selectableDayPredicate: (date) => date.day != 23,
                        locale: 'en_ISO',
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
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
    )));
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
          decoration: ConstantsWidget.getContainerBorder(
              Colors.white, Colors.white, 25, 0),
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
