class AllFoodModel {
  String date = "";
  String day = "";
  String foodid = "";
  String food = "";
  String weight = "";
  String calorie = "";
  String protien = "";
  String carbs = "";
  String fat = "";

  AllFoodModel(this.foodid,this.date,this.day,
      this.food, this.weight, this.calorie, this.protien, this.carbs, this.fat);

  factory AllFoodModel.fromJson(Map<String, dynamic> json) {
    return AllFoodModel(
        json["foodid"].toString(),
        json["date"].toString(),
        json["day"].toString(),
        json["food"].toString(),
        json["weight"].toString(),
        json["calorie"].toString(),
        json["protien"].toString(),
        json["carbs"].toString(),
        json["fat"].toString());
  }
}
