class CarCategory {
  final int carId;
  final int categoryId;

  CarCategory({required this.carId, required this.categoryId});

  factory CarCategory.fromJson(Map<String, dynamic> json) {
    return CarCategory(carId: json['car_id'], categoryId: json['category_id']);
  }
}
