import 'package:flutter/material.dart';

enum ProductCategory {
  all('All', Icons.grid_view_rounded),
  electronics('Electronics', Icons.devices_rounded),
  audio('Audio', Icons.headphones_rounded),
  wearables('Wearables', Icons.watch_rounded),
  footwear('Footwear', Icons.roller_skating_rounded),
  accessories('Accessories', Icons.shopping_bag_rounded),
  home('Home', Icons.home_rounded);

  final String label;
  final IconData icon;

  const ProductCategory(this.label, this.icon);
}

class Product {
  final String id;
  final String name;
  final ProductCategory category;
  final double price;
  final double rating;
  final int reviewCount;
  final String description;
  final bool isAvailable;
  final IconData icon;
  final Color themeColor;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.isAvailable,
    required this.icon,
    required this.themeColor,
  });

  String get formattedPrice => '\$${price.toStringAsFixed(2)}';
}

final List<Product> sampleProducts = [
  const Product(
    id: 'prod-001',
    name: 'Sony WH-1000XM5 Wireless Headphones',
    category: ProductCategory.audio,
    price: 349.99,
    rating: 4.8,
    reviewCount: 1420,
    description:
        'Industry-leading noise cancellation with two processors and 8 microphones for exceptional sound quality and crystal-clear hands-free calling.',
    isAvailable: true,
    icon: Icons.headphones_rounded,
    themeColor: Color(0xFF1E88E5),
  ),
  const Product(
    id: 'prod-002',
    name: 'Apple MacBook Pro 14" M3',
    category: ProductCategory.electronics,
    price: 1599.00,
    rating: 4.9,
    reviewCount: 890,
    description:
        'Supercharged by the next-generation M3 chip with up to 22 hours of battery life and Liquid Retina XDR display.',
    isAvailable: true,
    icon: Icons.laptop_mac_rounded,
    themeColor: Color(0xFF5E35B1),
  ),
  const Product(
    id: 'prod-003',
    name: 'Nike Air Zoom Pegasus 40',
    category: ProductCategory.footwear,
    price: 130.00,
    rating: 4.6,
    reviewCount: 650,
    description:
        'Responsive cushioning provides an energized ride for everyday road running with engineered mesh upper for lightweight breathability.',
    isAvailable: true,
    icon: Icons.directions_run_rounded,
    themeColor: Color(0xFFE53935),
  ),
  const Product(
    id: 'prod-004',
    name: 'Garmin Fenix 7 Pro Solar',
    category: ProductCategory.wearables,
    price: 799.99,
    rating: 4.7,
    reviewCount: 340,
    description:
        'Multisport GPS smartwatch with solar charging lens, built-in LED flashlight, and advanced training metrics.',
    isAvailable: true,
    icon: Icons.watch_rounded,
    themeColor: Color(0xFF00897B),
  ),
  const Product(
    id: 'prod-005',
    name: 'Bellroy Classic Backpack Plus',
    category: ProductCategory.accessories,
    price: 189.00,
    rating: 4.5,
    reviewCount: 290,
    description:
        'Weather-resistant urban backpack with dedicated 16" laptop compartment and lumbar support for all-day commuting.',
    isAvailable: false,
    icon: Icons.backpack_rounded,
    themeColor: Color(0xFF6D4C41),
  ),
  const Product(
    id: 'prod-006',
    name: 'Dyson V15 Detect Cordless Vacuum',
    category: ProductCategory.home,
    price: 749.99,
    rating: 4.7,
    reviewCount: 1100,
    description:
        'Intelligent cordless vacuum with laser illumination that reveals invisible dust and automatically adapts suction power.',
    isAvailable: true,
    icon: Icons.cleaning_services_rounded,
    themeColor: Color(0xFF8E24AA),
  ),
  const Product(
    id: 'prod-007',
    name: 'Logitech MX Master 3S Wireless Mouse',
    category: ProductCategory.electronics,
    price: 99.99,
    rating: 4.8,
    reviewCount: 2310,
    description:
        'Quiet Clicks and 8K DPI track-on-glass sensor with MagSpeed electromagnetic scrolling for supreme precision and speed.',
    isAvailable: true,
    icon: Icons.mouse_rounded,
    themeColor: Color(0xFF00ACC1),
  ),
  const Product(
    id: 'prod-008',
    name: 'Bose SoundLink Flex Bluetooth Speaker',
    category: ProductCategory.audio,
    price: 149.00,
    rating: 4.6,
    reviewCount: 940,
    description:
        'Waterproof IP67 portable outdoor speaker with deep bass, clear treble, and PositionIQ technology for optimal acoustic balance.',
    isAvailable: true,
    icon: Icons.speaker_rounded,
    themeColor: Color(0xFFFB8C00),
  ),
  const Product(
    id: 'prod-009',
    name: 'Adidas Ultraboost Light Running Shoes',
    category: ProductCategory.footwear,
    price: 190.00,
    rating: 4.4,
    reviewCount: 420,
    description:
        'The lightest Ultraboost ever made with 30% lighter Light BOOST material and Linear Energy Push system for explosive push-off.',
    isAvailable: false,
    icon: Icons.snowshoeing_rounded,
    themeColor: Color(0xFF3949AB),
  ),
  const Product(
    id: 'prod-010',
    name: 'Ray-Ban Wayfarer Classic Polarized',
    category: ProductCategory.accessories,
    price: 210.00,
    rating: 4.7,
    reviewCount: 780,
    description:
        'Iconic timeless sunglasses featuring 100% UV protection polarized green classic G-15 lenses and durable acetate frame.',
    isAvailable: true,
    icon: Icons.visibility_rounded,
    themeColor: Color(0xFF263238),
  ),
  const Product(
    id: 'prod-011',
    name: 'Philips Hue Smart Bridge Starter Kit',
    category: ProductCategory.home,
    price: 129.99,
    rating: 4.5,
    reviewCount: 560,
    description:
        'Smart lighting kit with Bridge and 3 color-changing LED bulbs compatible with Alexa, Google Home, and Apple HomeKit.',
    isAvailable: true,
    icon: Icons.lightbulb_rounded,
    themeColor: Color(0xFFFDD835),
  ),
  const Product(
    id: 'prod-012',
    name: 'Samsung Galaxy Watch 6 Classic',
    category: ProductCategory.wearables,
    price: 399.99,
    rating: 4.6,
    reviewCount: 680,
    description:
        'Signature rotating bezel with body composition analysis, advanced sleep coaching, and sapphire crystal glass display.',
    isAvailable: true,
    icon: Icons.watch_outlined,
    themeColor: Color(0xFF039BE5),
  ),
];
