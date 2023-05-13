import 'dart:convert';

import 'package:flutter_application_1/constants_widget.dart';
import 'package:flutter_application_1/imports.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart' as Toast;

class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  addFood(
    String food,
    String weight,
    String calorie,
    String protien,
    String carbs,
    String fat,
  ) async {
    if (food.isNotEmpty &&
        weight.isNotEmpty &&
        calorie.isNotEmpty &&
        protien.isNotEmpty &&
        carbs.isNotEmpty &&
        fat.isNotEmpty) {
      var response = await http.post(Uri.parse(Constants.ADDFOOD_URL), body: {
        "food": food,
        "weight": weight,
        "calorie": calorie,
        "protien": protien,
        "carbs": carbs,
        "fat": fat,
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        Toast.Toast.show(data.toString());
        print(data.toString());
      } else {
        Toast.Toast.show("Failed");
      }
    } else {
      Toast.Toast.show("Enter Proper Details");
    }
  }

  @override
  Widget build(BuildContext context) {
    Toast.ToastContext().init(context);
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: Constants.backgroundgrey,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(
              height: Constants.getScreenHeight(context),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Stack(
                    children: [
                      ConstantsWidget.getFadedContainer(
                          double.infinity,
                          Constants.backgroundgreyinvisible,
                          Constants.backgroundgrey,
                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Column(
                                children: [
                                  Text(
                                    "Food Details",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  getTextField(foodName, "Food Name", 20),
                                  getTextField(weight, "Food Weight", 10),
                                  getTextField(calorie, "Calorie", 10),
                                  getTextField(protien, "Protien", 10),
                                  getTextField(carbs, "Carbs", 10),
                                  getTextField(fat, "Fat", 10),
                                  GestureDetector(
                                    onTap: () {
                                      addFood(
                                          foodName.text,
                                          weight.text,
                                          calorie.text,
                                          protien.text,
                                          carbs.text,
                                          fat.text);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: ConstantsWidget.getBottomButton(
                                          "Add Food", 10, 0),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                      ConstantsWidget.getTopLeftButton(Icons.arrow_back),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  TextEditingController foodName = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController calorie = TextEditingController();
  TextEditingController protien = TextEditingController();
  TextEditingController carbs = TextEditingController();
  TextEditingController fat = TextEditingController();

  Widget getTextField(
      TextEditingController controller, String hint, double ptop) {
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
