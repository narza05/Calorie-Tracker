import 'dart:convert';
import 'package:flutter_application_1/calorie_tracker/food.dart';
import 'package:flutter_application_1/constants_widget.dart';
import 'package:flutter_application_1/imports.dart';
import 'package:flutter_application_1/models/all_food_model.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart' as Toast;

class AllFood extends StatefulWidget {
  const AllFood({super.key});

  @override
  State<AllFood> createState() => _AllFoodState();
}

class _AllFoodState extends State<AllFood> {
  List<AllFoodModel> foodList = [];
  int foodListIndex = 2;

  getFoodList() {
    return Expanded(
      child: ListView.builder(
          itemCount: foodList.length.toInt(),
          itemBuilder: (context, position) {
            return getFoodListItem(position);
          }),
    );
  }

  Widget getFoodListItem(int posi) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return Food(foodList[posi].food,double.parse(foodList[posi].weight),double.parse(foodList[posi].calorie),double.parse(foodList[posi].protien),double.parse(foodList[posi].carbs),double.parse(foodList[posi].fat), foodList[posi]);
        }));
      },
      child: Container(
        padding: EdgeInsets.all(13),
        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
        decoration: BoxDecoration(
            border: Border.all(color: Constants.mygrey, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  foodList[posi].food,
                  style: listItemText(Colors.black, 20, FontWeight.w900),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      foodList[posi].calorie + " Kcal",
                      style: listItemText(Colors.grey, 11, FontWeight.w900),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      foodList[posi].weight + " G",
                      style: listItemText(Colors.grey, 11, FontWeight.w900),
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
                      foodList[posi].protien,
                      style: listItemText(Colors.black, 18, FontWeight.w900),
                    ),
                    Text(
                      "Protien",
                      style: listItemText(Colors.green, 11, FontWeight.w900),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      foodList[posi].carbs,
                      style: listItemText(Colors.black, 18, FontWeight.w900),
                    ),
                    Text(
                      "Carbs",
                      style: listItemText(Colors.orange, 11, FontWeight.w900),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      foodList[posi].fat,
                      style: listItemText(Colors.black, 18, FontWeight.w900),
                    ),
                    Text(
                      "Fat",
                      style: listItemText(Colors.blue, 11, FontWeight.w900),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  TextStyle listItemText(Color color, double size, FontWeight fontWeight) {
    return TextStyle(
        fontFamily: "Poppins",
        fontWeight: fontWeight,
        fontSize:  size,
        color: color);
  }

  Future<List<AllFoodModel>> getFood() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
    var response = await http.post(
      Uri.parse(Constants.GETFOOD_URL),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var array in data) {
        print(array["food"]);
        setState(() {
          foodList.add(AllFoodModel.fromJson(array));
        });
        print(foodList.length.toString());
      }
    }
    Navigator.of(context).pop();
    return foodList;
  }

  update() {
    getFood().then((value) {
      setState(() {
        foodList.addAll(value);
        print(foodList.length);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      update();
    });
  }

  Widget build(BuildContext context) {
    return ConstantsWidget.getBasicScreen(
      context,
      Stack(
        children: [
          Column(
            children: [
              getFoodList(),
              TextButton(
                onPressed: () {
                  update();
                },
                child: Text("Button"),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    foodList.clear();
                  });
                },
                child: Text("delete"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
