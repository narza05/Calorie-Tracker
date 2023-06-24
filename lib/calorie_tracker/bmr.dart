import 'dart:ui';
import 'package:flutter_application_1/calorie_tracker/bmr_result.dart';
import 'package:flutter_application_1/imports.dart';
import 'package:toast/toast.dart' as Toast;

class BMR extends StatefulWidget {
  const BMR({Key? key}) : super(key: key);

  @override
  State<BMR> createState() => _BMRState();
}

class _BMRState extends State<BMR> {
  TextEditingController age = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();

  Color activeColor = Constants.myred;
  Color inactiveColor = Colors.grey.withOpacity(0.5);

  late Color maleColor = inactiveColor;
  late Color femaleColor = inactiveColor;
  String gender = "";
  double bmrText = 0;

  bool visibility = true;

  updateColor(int index) {
    setState(() {
      if (index == 1) {
        gender = "male";
        maleColor = activeColor;
        femaleColor = inactiveColor;
      } else if (index == 2) {
        gender = "female";
        maleColor = inactiveColor;
        femaleColor = activeColor;
      }
    });
  }

  calculate() {
    //10W + 6.25H - 5A + 5 MEN
    //10W + 6.25H - 5A - 161 WOMEN
    if (age.text.isNotEmpty && age.text.isNotEmpty && age.text.isNotEmpty &&
        gender != "") {
      setState(() {
        gender == "male" ?
        bmrText = (10 * double.parse(weight.text)) +
            (6.25 * double.parse(height.text)) -
            (5 * double.parse(age.text)) + 5 :
        bmrText = (10 * double.parse(weight.text)) +
            (6.25 * double.parse(height.text)) -
            (5 * double.parse(age.text)) + 5;
      });
      Toast.Toast.show("done");
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return BMRResult(bmrText);
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    Toast.ToastContext().init(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Stack(children: [
                Column(
                  children: [
                    Padding(
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
                                "BMR",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Column(
                        children: [
                          Visibility(
                            visible: false,
                            child: Text(
                              "Fill Details",
                              style: TextStyle(
                                  color: Constants.myred,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Poppins",
                                  fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text("Age", style: TextStyle(
                            fontFamily: "Poppins",
                          ),),
                          getTextfield("Age", age),
                          SizedBox(
                            height: 15,
                          ),
                          Text("Height (cm)", style: TextStyle(
                            fontFamily: "Poppins",
                          ),),
                          getTextfield("Height", height),
                          SizedBox(
                            height: 15,
                          ),
                          Text("Weight (kg)", style: TextStyle(
                            fontFamily: "Poppins",
                          ),),
                          getTextfield("Weight", weight),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 45,
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      updateColor(1);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                          color: maleColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Text(
                                        "Male",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      updateColor(2);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                          color: femaleColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Text(
                                        "Female",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          buildGestureDetector("Calculate", () {
                            calculate();
                          }),
                        ],
                      ),
                    )
                  ],
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }

  GestureDetector buildGestureDetector(String title, Function() ontap) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
          height: 45,
          decoration: BoxDecoration(
              color: Constants.myred,
              borderRadius:
              BorderRadius.all(Radius.circular(20))),
          child: Center(
              child: Text(
                title,
                style: TextStyle(color: Colors.white),
              ))),
    );
  }

  getTextfield(String hint, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: TextField(
        keyboardType: TextInputType.number,
        controller: controller,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          // hintText: hint,
          contentPadding: EdgeInsets.all(0),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide:
              BorderSide(color: Colors.grey.withOpacity(0.2), width: 2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Constants.myred, width: 2)),
        ),
      ),
    );
  }
}
