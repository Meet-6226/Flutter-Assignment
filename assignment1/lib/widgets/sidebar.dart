import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onPageSelected;
  final bool isTablet;

  const SideMenu({
    super.key,
    required this.selectedIndex,
    required this.onPageSelected,
    this.isTablet = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final menuItems = [
      {'icon': Icons.home_rounded, 'title': 'Home'},
      {'icon': Icons.local_offer_rounded, 'title': 'Offers'},
      {'icon': Icons.receipt_long_rounded, 'title': 'Orders'},
      {'icon': Icons.account_circle_rounded, 'title': 'Profile & Settings'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1B2E) : Colors.white,
        border: Border(
          right: BorderSide(
            color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 24),
          // Logo & App Name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment:
                  isTablet ? MainAxisAlignment.center : MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.local_pizza_rounded,
                    size: 28,
                    color: Colors.deepPurple,
                  ),
                ),
                if (!isTablet) ...[
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      'FooddySpot',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Menu Items List
          Expanded(
            child: ListView.builder(
              itemCount: menuItems.length,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemBuilder: (context, index) {
                final item = menuItems[index];
                final isSelected = selectedIndex == index;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                    child: InkWell(
                      onTap: () => onPageSelected(index),
                      borderRadius: BorderRadius.circular(14),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: EdgeInsets.symmetric(
                          horizontal: isTablet ? 12 : 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? (isDark
                                  ? Colors.deepPurple.withValues(alpha: 0.3)
                                  : Colors.deepPurple.withValues(alpha: 0.12))
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(14),
                          border: isSelected
                              ? Border.all(color: Colors.deepPurple.withValues(alpha: 0.4))
                              : null,
                        ),
                        child: Row(
                          mainAxisAlignment: isTablet
                              ? MainAxisAlignment.center
                              : MainAxisAlignment.start,
                          children: [
                            Icon(
                              item['icon'] as IconData,
                              color: isSelected
                                  ? Colors.deepPurple
                                  : (isDark ? Colors.grey[400] : Colors.grey[600]),
                              size: 22,
                            ),
                            if (!isTablet) ...[
                              const SizedBox(width: 14),
                              Flexible(
                                child: Text(
                                  item['title'] as String,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? Colors.deepPurple
                                        : (isDark ? Colors.grey[300] : Colors.grey[700]),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Footer Special Offer Banner
          if (!isTablet)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[900] : const Color(0xFFF3E8FF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.deepPurple,
                      radius: 16,
                      child: Icon(Icons.flash_on, color: Colors.white, size: 16),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Special Offer',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black87,
                            ),
                          ),
                          Text(
                            '30% OFF Pizzas',
                            style: TextStyle(
                              fontSize: 10,
                              color: isDark ? Colors.grey[400] : Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
