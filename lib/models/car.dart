class Car {
  final int id;
  final String name;
  final String brand;
  final String category;
  final String? description;
  final String? engineType;
  final String? transmission;
  final String? fuelType;
  final int? seats;
  final bool acStatus;
  final double basePrice;
  final String imageUrl;
  final bool isAvailable;

  Car({
    required this.id,
    required this.name,
    required this.brand,
    required this.category,
    this.description,
    this.engineType,
    this.transmission,
    this.fuelType,
    this.seats,
    required this.acStatus,
    required this.basePrice,
    required this.imageUrl,
    required this.isAvailable,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      category: json['category'],
      description: json['description'],
      engineType: json['engine_type'],
      transmission: json['transmission'],
      fuelType: json['fuel_type'],
      seats: json['seats'],
      acStatus: json['ac_status'] ?? true,
      basePrice: (json['base_price'] as num).toDouble(),
      imageUrl: json['image_url'],
      isAvailable: json['is_available'] ?? true,
    );
  }
}
