import 'dart:convert';
import 'dart:io';

import 'package:flutter_application_1/calorie_tracker/add_food.dart';
import 'package:flutter_application_1/calorie_tracker/all_food.dart';
import 'package:flutter_application_1/calorie_tracker/bmr.dart';
import 'package:flutter_application_1/constants_widget.dart';
import 'package:flutter_application_1/imports.dart';
import 'package:flutter_application_1/models/all_food_model.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart' as Toast;

class CalorieTracker extends StatefulWidget {
  const CalorieTracker({super.key});

  @override
  State<CalorieTracker> createState() => _CalorieTrackerState();
}

class _CalorieTrackerState extends State<CalorieTracker> {
  double initialCalorie = 0;
  double initialProtein = 0;
  double initialCarbs = 0;
  double initialFat = 0;
  List<AllFoodModel> foodList = [];
  bool removeItem = true;
  DateTime selectedDate = Constants.getCurrentDateTime();
  String Date = Constants.getCurrentDate();

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
          spinnerMode: false,
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

  getFood(String date) async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });
    setState(() {
      foodList.clear();
      initialCalorie = 0;
      initialProtein = 0;
      initialCarbs = 0;
      initialFat = 0;
    });

    var response = await http.get(Uri.parse(Constants.TRACKER_GETFOOD_URL+"?date="+date));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var array in data) {
        setState(() {
          foodList.add(AllFoodModel(
              array['foodid'].toString(),
              array['date'].toString(),
              array['day'],
              array['food'],
              array['weight'].toString(),
              array['calorie'].toString(),
              array['protien'].toString(),
              array['carbs'].toString(),
              array['fat'].toString()));
          initialCalorie += array['calorie'];
          initialProtein += array['protien'];
          initialCarbs += array['carbs'];
          initialFat += array['fat'];
        });
        print(foodList.length.toString());
      }
    }
    Navigator.pop(context);
  }

  getList() {
    return Expanded(
      child: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: ListView.builder(
            itemCount: foodList.length.toInt(),
            itemBuilder: (context, position) {
              return Dismissible(
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.all(13),
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Icon(Icons.delete),
                ),
                key: UniqueKey(),
                onDismissed: (DismissDirection direction) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("ok"),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                        label: "undo",
                        onPressed: () {
                          removeItem = false;
                          getFood(Date);
                        }),
                  ));
                  setState(() {
                    foodList.removeAt(position);
                    Future.delayed(const Duration(milliseconds: 4000), () {
                      if (removeItem == true) {
                        deleteFood(foodList[position].foodid);
                      }else{
                        removeItem = true;
                      }
                    });
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(11),
                  margin:
                      EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Constants.mygrey, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              foodList[position].food,
                              style: listItemText(
                                  Colors.black, 15, FontWeight.w900),
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  foodList[position].calorie + " Kcal",
                                  style: listItemText(
                                      Colors.grey, 10, FontWeight.w900),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  foodList[position].weight + " G",
                                  style: listItemText(
                                      Colors.grey, 10, FontWeight.w900),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  foodList[position].protien,
                                  style: listItemText(
                                      Colors.black, 15, FontWeight.w900),
                                ),
                                Text(
                                  "Protien",
                                  style: listItemText(
                                      Colors.green, 10, FontWeight.w900),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  foodList[position].carbs,
                                  style: listItemText(
                                      Colors.black, 15, FontWeight.w900),
                                ),
                                Text(
                                  "Carbs",
                                  style: listItemText(
                                      Colors.orange, 10, FontWeight.w900),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  foodList[position].fat,
                                  style: listItemText(
                                      Colors.black, 15, FontWeight.w900),
                                ),
                                Text(
                                  "Fat",
                                  style: listItemText(
                                      Colors.blue, 10, FontWeight.w900),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  deleteFood(String id) async {
    var response = await http.post(Uri.parse(Constants.TRACKER_DELETEFOOD_URL),
        body: {"foodid": id});
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      Toast.Toast.show(data["message"]);
      getFood(Date);
    }
  }

  TextStyle listItemText(Color color, double size, FontWeight fontWeight) {
    return TextStyle(
        fontFamily: "Poppins",
        fontWeight: fontWeight,
        fontSize: size,
        color: color);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      getFood(Date);
    });
  }

  Widget build(BuildContext context) {
    Toast.ToastContext().init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Constants.backgroundgrey.withAlpha(200),
        leading: ConstantsWidget.getTopLeftButton(Icons.arrow_back,
            Alignment.center, 0, () => Navigator.pop(context)),
        title: Align(
          alignment: Alignment.center,
          child: Text(
            "Calorie Tracker",
            style: GoogleFonts.dmSans(
                fontSize: 14, fontWeight: FontWeight.w800, color: Colors.black),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return BMR();
              }));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(
                Icons.settings,
                color: Colors.black,
                size: 22,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
          child: Container(
        child: SingleChildScrollView(
          child: Container(
            height: Constants.getScreenHeight(context),
            child: Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 0),
                    child: CalendarTimeline(
                      initialDate: (selectedDate),
                      firstDate: DateTime(2022, 1, 1),
                      lastDate: DateTime(2030, 1, 1),
                      onDateSelected: (date) {
                        selectedDate = date;
                        Date = selectedDate.toString().replaceAll("00:00:00.000", "");
                        getFood(Date);
                      },
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
                        padding:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Column(children: [
                          getSlider(initialCalorie, 2400, "Total Calorie",
                              Constants.myred, 110, 17, 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              getSlider(initialProtein, 120, "Protien",
                                  Colors.green, 80, 15, 10),
                              getSlider(initialCarbs, 220, "Carbs",
                                  Colors.orange, 80, 15, 10),
                              getSlider(initialFat, 90, "Fat", Colors.blue, 80,
                                  15, 10),
                            ],
                          )
                        ]),
                      ),
                    ),
                  ),
                  getList(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          (MaterialPageRoute(builder: (context) {
                            return AddFood();
                          })));
                    },
                    child: ConstantsWidget.getBottomButton("Add Food"),
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
