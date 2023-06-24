import 'dart:convert';

import 'package:flutter_application_1/imports.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart' as Toast;

class BMRResult extends StatefulWidget {
  double result = 0;

  BMRResult(this.result);

  @override
  State<BMRResult> createState() => _BMRResultState();
}

class _BMRResultState extends State<BMRResult> {
  TextEditingController calorie = TextEditingController();

  addDetail(String calorie) async {
    var response = await http
        .post(Uri.parse(Constants.ADD_DETAILS), body: {"calorie": calorie});
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      Toast.Toast.show(data['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    Toast.ToastContext().init(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints.tightFor(
                  height: Constants.getScreenHeight(context)),
              child: Column(
                children: [
                  ConstantsWidget.getAppBar("BMR", null),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        // Text(
                        //   "Result",
                        //   style: TextStyle(fontFamily: "Poppins", fontSize: 13),
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              "${widget.result}",
                              style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w900,
                                  fontSize: 35),
                            ),
                            Text(
                              "Calories/day",
                              style: TextStyle(
                                  fontFamily: "Poppins", fontSize: 12),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              buildExpanded(
                                  "Sedentary: little or no exercise", 1.2),
                              buildExpanded("Exercise 1-3 times/week", 1.37),
                              buildExpanded("Exercise 4-5 times/week", 1.46),
                              buildExpanded(
                                  "Daily exercise or intense exercise 3-4 times/week",
                                  1.55),
                              buildExpanded(
                                  "Intense exercise 6-7 times/week", 1.72),
                              buildExpanded(
                                  "Very intense exercise daily, or physical job",
                                  1.9),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: SizedBox(
                            height: 45,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: calorie,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12),
                              decoration: InputDecoration(
                                  hintText: "Set Daily Calorie Target",
                                  contentPadding: EdgeInsets.all(0),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 1))),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        if(calorie.text.isNotEmpty) {
                          addDetail(calorie.text);
                        }
                      },
                      child: ConstantsWidget.getBottomButton("Done")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Expanded buildExpanded(String title, double factor) {
    return Expanded(
      child: Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Constants.mygrey.withOpacity(0.2),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Text(
                  title,
                  style: TextStyle(fontSize: 12, fontFamily: "Poppins"),
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      "${(widget.result * factor).toStringAsFixed(0)}",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontFamily: "Poppins",
                          fontSize: 15),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Kcal/day",
                      style: TextStyle(fontFamily: "Poppins", fontSize: 9),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
