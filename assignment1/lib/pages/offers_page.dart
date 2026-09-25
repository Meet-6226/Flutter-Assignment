import 'package:flutter/material.dart';
import '../data/food_data.dart';
import '../models/offer.dart';
import '../models/user_profile.dart';
import '../widgets/offer_card.dart';
import '../widgets/offer_detail_dialog.dart';

class OffersPage extends StatefulWidget {
  final UserProfile? profile;
  final VoidCallback? onProfileTap;

  const OffersPage({
    super.key,
    this.profile,
    this.onProfileTap,
  });

  @override
  State<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  String _selectedCategory = 'All';
  String _searchQuery = '';
  String _sortBy = 'Popular';
  late List<OfferModel> _offers;

  @override
  void initState() {
    super.initState();
    _offers = List.from(FoodData.offers);
  }

  static const List<String> offerCategories = [
    'All',
    'Pizza Combos',
    'Burger Meals',
    'Indian Feasts',
    'Italian Bundles',
    'Breakfast Combos',
    'Asian Wok Packs',
    'Dessert Boxes',
    'Family Mega Deals',
  ];

  List<OfferModel> get _filteredAndSortedOffers {
    List<OfferModel> result = _offers.where((offer) {
      final matchesCategory = _selectedCategory == 'All' ||
          offer.title.toLowerCase().contains(_selectedCategory.replaceAll(' Combos', '').replaceAll(' Meals', '').replaceAll(' Feasts', '').replaceAll(' Bundles', '').replaceAll(' Packs', '').replaceAll(' Deals', '').replaceAll(' Boxes', '').toLowerCase()) ||
          offer.category.toLowerCase().contains(_selectedCategory.toLowerCase());
      final matchesSearch = _searchQuery.isEmpty ||
          offer.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          offer.category.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          offer.description.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          offer.offerCode.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    if (_sortBy == 'Highest Discount') {
      result.sort((a, b) => b.discountPercent.compareTo(a.discountPercent));
    } else if (_sortBy == 'Newest') {
      result.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } else if (_sortBy == 'Ending Soon') {
      result.sort((a, b) => a.validity.compareTo(b.validity));
    }
    // Default Popular: keep default list order
    return result;
  }

  void _handleClaimOffer(OfferModel offer) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                '${offer.title} claimed! Use code ${offer.offerCode} at checkout.',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.deepPurple[700],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  void _toggleFavorite(OfferModel offer) {
    setState(() {
      offer.isFavorite = !offer.isFavorite;
    });
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          offer.isFavorite
              ? 'Saved "${offer.title}" to favorites ❤️'
              : 'Removed "${offer.title}" from favorites',
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;

    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;

    final crossAxisCount = isMobile
        ? 1
        : isTablet
            ? 2
            : 4;

    final userProfile = widget.profile ?? FoodData.defaultProfile;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Bar
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Exclusive Food Offers & Deals 🎉',
                      style: TextStyle(
                        fontSize: isMobile ? 20 : 26,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Delicious offers, specially for you! Save more, enjoy better.',
                      style: TextStyle(
                        fontSize: isMobile ? 12 : 14,
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: widget.onProfileTap,
                child: Tooltip(
                  message: 'My Profile',
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.deepPurple, width: 2),
                    ),
                    child: CircleAvatar(
                      radius: isMobile ? 20 : 24,
                      backgroundImage: NetworkImage(userProfile.avatarUrl),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Working Search Input Field
          Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E1B2E) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: isDark ? Colors.black26 : Colors.deepPurple.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TextField(
              onChanged: (query) => setState(() => _searchQuery = query),
              style: TextStyle(color: isDark ? Colors.white : Colors.black87),
              decoration: InputDecoration(
                hintText: 'Search offers (e.g. pizza, burger, drinks, BOGO)...',
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: isDark ? Colors.grey[500] : Colors.grey[400],
                ),
                prefixIcon: const Icon(Icons.search_rounded, color: Colors.deepPurple),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded, size: 20),
                        onPressed: () => setState(() => _searchQuery = ''),
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Category Chips Section
          SizedBox(
            height: 42,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: offerCategories.length,
              itemBuilder: (context, index) {
                final cat = offerCategories[index];
                final isSelected = _selectedCategory == cat;

                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    child: ChoiceChip(
                      label: Text(cat),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) setState(() => _selectedCategory = cat);
                      },
                      selectedColor: Colors.deepPurple,
                      backgroundColor:
                          isDark ? const Color(0xFF1E1B2E) : const Color(0xFFF3E8FF),
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
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),

          // Sort Dropdown & Offer Count Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Available Deals (${_filteredAndSortedOffers.length})',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              Row(
                children: [
                  Text(
                    'Sort by: ',
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E1B2E) : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isDark ? Colors.grey[800]! : Colors.grey[300]!,
                      ),
                    ),
                    child: DropdownButton<String>(
                      value: _sortBy,
                      underline: const SizedBox(),
                      dropdownColor: isDark ? const Color(0xFF1E1B2E) : Colors.white,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                      items: ['Popular', 'Highest Discount', 'Newest', 'Ending Soon']
                          .map((option) => DropdownMenuItem(value: option, child: Text(option)))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => _sortBy = val);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Offers Grid / Empty State
          if (_filteredAndSortedOffers.isEmpty) ...[
            Container(
              padding: const EdgeInsets.all(40),
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1B2E) : Colors.grey[50],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Icon(Icons.local_offer_outlined, size: 64, color: Colors.deepPurple),
                  const SizedBox(height: 16),
                  Text(
                    'No offers found 😔',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Try searching for another food item or reset your filter.',
                    style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[600]),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _selectedCategory = 'All';
                        _searchQuery = '';
                      });
                    },
                    child: const Text('Clear Filters'),
                  ),
                ],
              ),
            ),
          ] else ...[
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _filteredAndSortedOffers.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: isMobile ? 1.05 : 0.85,
              ),
              itemBuilder: (context, index) {
                final offer = _filteredAndSortedOffers[index];
                return OfferCard(
                  offer: offer,
                  onTap: () {
                    OfferDetailDialog.show(
                      context,
                      offer,
                      () => _handleClaimOffer(offer),
                    );
                  },
                  onFavoriteToggle: () => _toggleFavorite(offer),
                );
              },
            ),
          ],
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
