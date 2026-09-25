class FoodItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final double rating;
  final String category;
  final String imageUrl;
  final String prepTime;
  final int calories;
  final bool isPopular;

  const FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.category,
    required this.imageUrl,
    this.prepTime = '15-20 min',
    this.calories = 350,
    this.isPopular = true,
  });
}
