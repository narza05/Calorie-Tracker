import 'package:flutter_application_1/calorie_tracker/add_food.dart';
import 'package:flutter_application_1/calorie_tracker/all_food.dart';
import 'package:flutter_application_1/constants_widget.dart';
import 'package:flutter_application_1/imports.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class CalorieTracker extends StatefulWidget {
  const CalorieTracker({super.key});

  @override
  State<CalorieTracker> createState() => _CalorieTrackerState();
}

class _CalorieTrackerState extends State<CalorieTracker> {
  double initial = 122;

  SleekCircularSlider getSlider(
      double initial,
      double max,
      String title,
      Color progresscolor,
      double slidersize,
      double text1size,
      double text2size) {
    var sliderTotal = SleekCircularSlider(
      innerWidget: (percentage) {
        int per = (percentage.toInt());
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$per",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: text1size,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold),
              ),
              Text(
                title,
                style: TextStyle(
                    color: Constants.mygrey,
                    fontSize: text2size,
                    fontFamily: "Poppins"),
              ),
            ],
          ),
        );
      },
      appearance: CircularSliderAppearance(
          size: slidersize,
          customColors: CustomSliderColors(
              trackColor: Constants.mygrey,
              progressBarColor: progresscolor,
              shadowMaxOpacity: 0)),
      initialValue: initial,
      min: 0,
      max: max,
      onChange: (double value) {
        print(value);
      },
    );
    return sliderTotal;
  }

  @override
  Widget build(BuildContext context) {
    Duration duration = Duration(seconds: 4);

    return Scaffold(
      body: SafeArea(
          child: Container(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(
              height: Constants.getScreenHeight(context),
            ),
            child: Stack(children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstantsWidget.getTopLeftButton(Icons.arrow_back),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: CalendarTimeline(
                        initialDate: (Constants.getCurrentDate()),
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
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          child: Column(children: [
                            getSlider(1900, 2400, "Total Calorie",
                                Constants.myred, 130, 17, 9),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                getSlider(100, 120, "Protien", Colors.amber,
                                    100, 15, 8),
                                getSlider(initial, 220, "Carbs", Colors.green,
                                    100, 15, 8),
                                getSlider(
                                    70, 90, "Fat", Colors.blue, 100, 15, 8),
                              ],
                            )
                          ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        (MaterialPageRoute(builder: (context) {
                          return AllFood();
                        })));
                  },
                  child: ConstantsWidget.getBottomButton("Add Food", 10,0))
            ]),
          ),
        ),
      )),
    );
  }
}
