class OfferModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String discountLabel;
  final int discountPercent;
  final String category;
  final String validity;
  final String offerCode;
  bool isFavorite;
  final DateTime createdAt;

  OfferModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.discountLabel,
    this.discountPercent = 20,
    required this.category,
    required this.validity,
    required this.offerCode,
    this.isFavorite = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  OfferModel copyWith({
    bool? isFavorite,
  }) {
    return OfferModel(
      id: id,
      title: title,
      description: description,
      imageUrl: imageUrl,
      discountLabel: discountLabel,
      discountPercent: discountPercent,
      category: category,
      validity: validity,
      offerCode: offerCode,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt,
    );
  }
}
