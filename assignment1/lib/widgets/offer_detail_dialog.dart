import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/offer.dart';

class OfferDetailDialog extends StatelessWidget {
  final OfferModel offer;
  final VoidCallback onClaimOffer;

  const OfferDetailDialog({
    super.key,
    required this.offer,
    required this.onClaimOffer,
  });

  static void show(BuildContext context, OfferModel offer, VoidCallback onClaimOffer) {
    showDialog(
      context: context,
      builder: (context) => OfferDetailDialog(
        offer: offer,
        onClaimOffer: onClaimOffer,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: isDark ? const Color(0xFF1E1B2E) : Colors.white,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 480, maxHeight: 650),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Header with Badges
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                    child: SizedBox(
                      height: 220,
                      width: double.infinity,
                      child: Image.network(
                        offer.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: isDark ? Colors.grey[900] : const Color(0xFFF3E8FF),
                          child: const Icon(Icons.local_offer_rounded, size: 60, color: Colors.deepPurple),
                        ),
                      ),
                    ),
                  ),
                  // Close Button
                  Positioned(
                    top: 12,
                    right: 12,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close_rounded, color: Colors.white),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.black45,
                      ),
                    ),
                  ),
                  // Discount Tag Badge
                  Positioned(
                    bottom: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.deepPurple, Colors.purple],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(color: Colors.black26, blurRadius: 6),
                        ],
                      ),
                      child: Text(
                        offer.discountLabel,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  // Category Badge
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        offer.category,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      offer.title,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Validity Info
                    Row(
                      children: [
                        const Icon(Icons.access_time_rounded, size: 16, color: Colors.deepPurple),
                        const SizedBox(width: 6),
                        Text(
                          offer.validity,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Offer Details',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.grey[300] : Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      offer.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark ? Colors.grey[400] : Colors.grey[600],
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Promo Code Box
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey[900] : const Color(0xFFF3E8FF),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.deepPurple.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'PROMO CODE',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                                  letterSpacing: 1,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                offer.offerCode,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.deepPurple,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ],
                          ),
                          OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.deepPurple,
                              side: const BorderSide(color: Colors.deepPurple),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: offer.offerCode));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Code ${offer.offerCode} copied to clipboard!'),
                                  duration: const Duration(seconds: 2),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            icon: const Icon(Icons.copy_rounded, size: 16),
                            label: const Text('Copy'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Claim Offer Action Button
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 2,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          onClaimOffer();
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.local_offer_rounded),
                            SizedBox(width: 8),
                            Text(
                              'Claim Offer',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
