class AllFoodModel {
  String food = "";
  String weight = "";
  String calorie = "";
  String protien = "";
  String carbs = "";
  String fat = "";

  AllFoodModel(
      this.food, this.weight, this.calorie, this.protien, this.carbs, this.fat);

  factory AllFoodModel.fromJson(Map<String, dynamic> json) {
    return AllFoodModel(
        json["food"].toString(),
        json["weight"].toString(),
        json["calorie"].toString(),
        json["protien"].toString(),
        json["carbs"].toString(),
        json["fat"].toString());
  }
}
