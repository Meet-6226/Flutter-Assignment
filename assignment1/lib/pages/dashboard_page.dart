import 'package:flutter/material.dart';
import '../data/food_data.dart';
import '../models/food_item.dart';
import '../models/user_profile.dart';
import '../widgets/header_bar.dart';
import '../widgets/food_card.dart';
import '../widgets/food_detail_dialog.dart';

class DashboardPage extends StatefulWidget {
  final UserProfile profile;
  final VoidCallback onProfileTap;
  final Function(String foodName, int qty, double total) onOrderPlaced;
  final bool isMobile;
  final bool isTablet;
  final bool isDesktop;

  const DashboardPage({
    super.key,
    required this.profile,
    required this.onProfileTap,
    required this.onOrderPlaced,
    required this.isMobile,
    required this.isTablet,
    required this.isDesktop,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String _selectedCategory = 'All';
  String _searchQuery = '';

  List<FoodItem> get _filteredFoods {
    return FoodData.foodItems.where((food) {
      final matchesCategory =
          _selectedCategory == 'All' || food.category == _selectedCategory;
      final matchesSearch = _searchQuery.isEmpty ||
          food.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          food.category.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          food.description.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  void _handleOrder(FoodItem food, int qty, double total) {
    widget.onOrderPlaced(food.name, qty, total);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                '$qty x ${food.name} added to your order (Total: ₹${total.toInt()})!',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.deepPurple[700],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final crossAxisCount = widget.isMobile
        ? 1
        : widget.isTablet
            ? 2
            : 4;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(widget.isMobile ? 16 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Bar
          HeaderBar(
            profile: widget.profile,
            onSearchChanged: (query) => setState(() => _searchQuery = query),
            onProfileTap: widget.onProfileTap,
            isMobile: widget.isMobile,
          ),
          const SizedBox(height: 28),

          // Categories Filter Section: "What's on your mind?"
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "What's on your mind?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              if (_selectedCategory != 'All' || _searchQuery.isNotEmpty)
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _selectedCategory = 'All';
                      _searchQuery = '';
                    });
                  },
                  icon: const Icon(Icons.clear, size: 16, color: Colors.deepPurple),
                  label: const Text('Reset', style: TextStyle(color: Colors.deepPurple)),
                ),
            ],
          ),
          const SizedBox(height: 14),

          // Horizontal Categories Chips
          SizedBox(
            height: 42,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: FoodData.categories.length,
              itemBuilder: (context, index) {
                final cat = FoodData.categories[index];
                final isSelected = _selectedCategory == cat;

                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) setState(() => _selectedCategory = cat);
                    },
                    selectedColor: Colors.deepPurple,
                    backgroundColor: isDark ? const Color(0xFF1E1B2E) : const Color(0xFFF3E8FF),
                    labelStyle: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : (isDark ? Colors.grey[300] : Colors.black87),
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: BorderSide(
                        color: isSelected
                            ? Colors.deepPurple
                            : (isDark ? Colors.transparent : Colors.grey[300]!),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 28),

          // Food Items Grid / Empty State
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Popular Near You 🔥',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              Text(
                '${_filteredFoods.length} items',
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          if (_filteredFoods.isEmpty) ...[
            Container(
              padding: const EdgeInsets.all(40),
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1B2E) : Colors.grey[50],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Icon(Icons.sentiment_dissatisfied_rounded, size: 64, color: Colors.deepPurple),
                  const SizedBox(height: 16),
                  Text(
                    'No tasty matches found 😔',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Try searching for something else or browse categories.',
                    style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ] else ...[
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _filteredFoods.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: widget.isMobile ? 1.1 : 0.85,
              ),
              itemBuilder: (context, index) {
                final food = _filteredFoods[index];
                return FoodCard(
                  food: food,
                  onTap: () {
                    FoodDetailDialog.show(
                      context,
                      food,
                      (qty, total) => _handleOrder(food, qty, total),
                    );
                  },
                  onOrder: () => _handleOrder(food, 1, food.price),
                );
              },
            ),
          ],
          const SizedBox(height: 36),

          // Recommended Banner Teaser
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.deepPurple, Colors.purple],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'RECOMMENDED FOR YOU',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Get 30% OFF on Woodfired Pizzas!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Use promo code PIZZA30 at checkout today.',
                        style: TextStyle(fontSize: 12, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {},
                  child: const Text('Order Now', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
