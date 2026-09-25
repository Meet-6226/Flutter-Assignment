import 'package:flutter/material.dart';
import '../models/user_profile.dart';

class HeaderBar extends StatelessWidget {
  final UserProfile profile;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onProfileTap;
  final bool isMobile;

  const HeaderBar({
    super.key,
    required this.profile,
    required this.onSearchChanged,
    required this.onProfileTap,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good Morning, ${profile.name.split(" ")[0]}! 👋',
                    style: TextStyle(
                      fontSize: isMobile ? 20 : 26,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'What are you craving today?',
                    style: TextStyle(
                      fontSize: isMobile ? 13 : 15,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            // Profile Avatar Button
            GestureDetector(
              onTap: onProfileTap,
              child: Tooltip(
                message: 'My Account & Profile',
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.deepPurple, width: 2),
                  ),
                  child: CircleAvatar(
                    radius: isMobile ? 20 : 24,
                    backgroundImage: NetworkImage(profile.avatarUrl),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Search Field
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
            onChanged: onSearchChanged,
            style: TextStyle(color: isDark ? Colors.white : Colors.black87),
            decoration: InputDecoration(
              hintText: 'Search for pizza, burger, biryani, pasta...',
              hintStyle: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.grey[500] : Colors.grey[400],
              ),
              prefixIcon: const Icon(Icons.search_rounded, color: Colors.deepPurple),
              suffixIcon: IconButton(
                icon: const Icon(Icons.tune_rounded, color: Colors.grey, size: 20),
                onPressed: () {},
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
        ),
      ],
    );
  }
}
