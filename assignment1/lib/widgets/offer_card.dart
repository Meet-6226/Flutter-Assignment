import 'package:flutter/material.dart';
import '../models/offer.dart';

class OfferCard extends StatefulWidget {
  final OfferModel offer;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;

  const OfferCard({
    super.key,
    required this.offer,
    required this.onTap,
    required this.onFavoriteToggle,
  });

  @override
  State<OfferCard> createState() => _OfferCardState();
}

class _OfferCardState extends State<OfferCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        transform: _isHovered ? Matrix4.translationValues(0, -4, 0) : Matrix4.identity(),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1B2E) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? Colors.deepPurple.withValues(alpha: 0.25)
                  : (isDark ? Colors.black38 : Colors.deepPurple.withValues(alpha: 0.05)),
              blurRadius: _isHovered ? 14 : 8,
              offset: Offset(0, _isHovered ? 6 : 3),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Image Section with Stack Badges
                SizedBox(
                  height: 140,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: Image.network(
                            widget.offer.imageUrl,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                color: isDark ? Colors.grey[900] : const Color(0xFFF3E8FF),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                    strokeWidth: 2,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: isDark ? Colors.grey[900] : const Color(0xFFF3E8FF),
                              child: const Icon(Icons.local_offer, size: 40, color: Colors.deepPurple),
                            ),
                          ),
                        ),
                      ),
                      // Discount Badge
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.deepPurple, Colors.purple],
                            ),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(color: Colors.black26, blurRadius: 4),
                            ],
                          ),
                          child: Text(
                            widget.offer.discountLabel,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      // Animated Favorite Heart Toggle Button
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Material(
                          color: Colors.black.withValues(alpha: 0.5),
                          shape: const CircleBorder(),
                          child: InkWell(
                            onTap: widget.onFavoriteToggle,
                            customBorder: const CircleBorder(),
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 200),
                                transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
                                child: Icon(
                                  widget.offer.isFavorite
                                      ? Icons.favorite_rounded
                                      : Icons.favorite_border_rounded,
                                  key: ValueKey<bool>(widget.offer.isFavorite),
                                  color: widget.offer.isFavorite ? Colors.redAccent : Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Card Body Content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category Tag
                        Text(
                          widget.offer.category.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Offer Title
                        Text(
                          widget.offer.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Short Description
                        Text(
                          widget.offer.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? Colors.grey[400] : Colors.grey[600],
                            height: 1.3,
                          ),
                        ),
                        const Spacer(),
                        const SizedBox(height: 8),
                        // Validity & CTA Button Alignment
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.access_time_rounded, size: 13, color: Colors.deepPurple),
                                const SizedBox(width: 4),
                                Text(
                                  widget.offer.validity,
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: isDark ? Colors.grey[400] : Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'View Offer',
                                    style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 3),
                                  Icon(Icons.arrow_forward_rounded, size: 12, color: Colors.deepPurple),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
