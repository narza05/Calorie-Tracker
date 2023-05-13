import 'package:flutter_application_1/constants_widget.dart';
import 'package:flutter_application_1/imports.dart';
import 'package:flutter_application_1/models/all_food_model.dart';

class Food extends StatefulWidget {
  AllFoodModel model;
  String food="";
  double weight=0,calorie=0,protien=0,carbs=0,fat=0;
  Food(this.food,this.weight,this.calorie,this.protien,this.carbs,this.fat, this.model);

  @override
  State<Food> createState() => _FoodState();
}

class _FoodState extends State<Food> {
  TextEditingController weightText = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return ConstantsWidget.getBasicScreen(
        context,
        Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.food,
                          style: ConstantsWidget.listItemText(Colors.black, 20, FontWeight.w900),
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${widget.calorie.toStringAsFixed(2)} Kcal",
                              style: ConstantsWidget.listItemText(Colors.grey, 11, FontWeight.w900),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              "${widget.protien.toStringAsFixed(2)}",
                              style: ConstantsWidget.listItemText(Colors.black, 18, FontWeight.w900),
                            ),
                            Text(
                              "Protien",
                              style: ConstantsWidget.listItemText(Colors.green, 11, FontWeight.w900),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "${widget.carbs.toStringAsFixed(2)}",
                              style: ConstantsWidget.listItemText(Colors.black, 18, FontWeight.w900),
                            ),
                            Text(
                              "Carbs",
                              style: ConstantsWidget.listItemText(Colors.orange, 11, FontWeight.w900),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "${widget.fat.toStringAsFixed(2)}",
                              style: ConstantsWidget.listItemText(Colors.black, 18, FontWeight.w900),
                            ),
                            Text(
                              "Fat",
                              style: ConstantsWidget.listItemText(Colors.blue, 11, FontWeight.w900),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10,right: 10),
                  child: TextField(
                    maxLength: 5,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    controller: weightText,
                    onChanged: (text){
                      setState(() {
                        print(text);
                        if(text == "" || int.parse(text) == 0) {
                          widget.calorie = double.parse(widget.model.calorie);
                          widget.protien = double.parse(widget.model.protien);
                          widget.carbs = double.parse(widget.model.carbs);
                          widget.fat = double.parse(widget.model.fat);
                        }else{
                          widget.calorie = (double.parse(widget.model.calorie)/(double.parse(widget.model.weight))) * double.parse(text);
                          widget.protien = (double.parse(widget.model.protien)/(double.parse(widget.model.weight))) * double.parse(text);
                          widget.carbs = (double.parse(widget.model.carbs)/(double.parse(widget.model.weight))) * double.parse(text);
                          widget.fat = (double.parse(widget.model.fat)/(double.parse(widget.model.weight))) * double.parse(text);
                          print(widget.calorie);
                          print(widget.protien);
                          print(widget.carbs);
                          print(widget.fat);
                        }
                        // widget.calorie = widget.calorie/double.parse(text);
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "${widget.weight}",
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
                ),
                ConstantsWidget.getBottomButton("Add Food", 0, 10),
              ],
            ),
          ],
        ));
  }
}
