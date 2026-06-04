class Package {
  final int id;
  final int carId;
  final String packageName;
  final double price;
  final String currency;
  final String? description;

  Package({
    required this.id,
    required this.carId,
    required this.packageName,
    required this.price,
    required this.currency,
    this.description,
  });

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      id: json['id'],
      carId: json['car_id'],
      packageName: json['package_name'],
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] ?? 'QAR',
      description: json['description'],
    );
  }
}
