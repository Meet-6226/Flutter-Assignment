import 'package:flutter/material.dart';
import '../data/food_data.dart';
import '../models/order.dart';

class OrdersPage extends StatefulWidget {
  final List<OrderModel> dynamicOrders;

  const OrdersPage({
    super.key,
    required this.dynamicOrders,
  });

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  String _selectedFilter = 'All';

  List<OrderModel> get _allOrders => [...widget.dynamicOrders, ...FoodData.orders];

  List<OrderModel> get _filteredOrders {
    if (_selectedFilter == 'All') return _allOrders;
    if (_selectedFilter == 'Active') {
      return _allOrders.where((o) => o.status == OrderStatus.pending || o.status == OrderStatus.preparing).toList();
    }
    if (_selectedFilter == 'Completed') {
      return _allOrders.where((o) => o.status == OrderStatus.delivered).toList();
    }
    if (_selectedFilter == 'Cancelled') {
      return _allOrders.where((o) => o.status == OrderStatus.cancelled).toList();
    }
    return _allOrders;
  }

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.preparing:
        return Colors.orange;
      case OrderStatus.pending:
        return Colors.purple;
      case OrderStatus.cancelled:
        return Colors.red;
    }
  }

  void _handleReorder(OrderModel order) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.refresh, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Reordered ${order.items.first.foodName}! Items added to active order.',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.deepPurple[700],
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final filters = ['All', 'Active', 'Completed', 'Cancelled'];

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.receipt_long_rounded, color: Colors.deepPurple, size: 28),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'My Food Orders',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  Text(
                    'Track active orders and reorder your past favorite meals',
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Filter Status Chips
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final filter = filters[index];
                final isSelected = _selectedFilter == filter;

                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: FilterChip(
                    label: Text(filter),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) setState(() => _selectedFilter = filter);
                    },
                    selectedColor: Colors.deepPurple,
                    backgroundColor: isDark ? const Color(0xFF1E1B2E) : const Color(0xFFF3E8FF),
                    labelStyle: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : (isDark ? Colors.grey[300] : Colors.black87),
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),

          // Orders List
          if (_filteredOrders.isEmpty) ...[
            Container(
              padding: const EdgeInsets.all(40),
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1B2E) : Colors.grey[50],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Icon(Icons.shopping_bag_outlined, size: 60, color: Colors.deepPurple),
                  const SizedBox(height: 12),
                  Text(
                    'No orders found for "$_selectedFilter"',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _filteredOrders.length,
              itemBuilder: (context, index) {
                final order = _filteredOrders[index];
                final statusColor = _getStatusColor(order.status);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E1B2E) : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: isDark ? Colors.black26 : Colors.deepPurple.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  order.id,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? Colors.white : Colors.black87,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '• ${order.dateTime}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDark ? Colors.grey[400] : Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: statusColor.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                order.statusText,
                                style: TextStyle(
                                  color: statusColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Divider(),
                        const SizedBox(height: 8),
                        Column(
                          children: order.items.map((item) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${item.quantity}x ${item.foodName}',
                                    style: TextStyle(
                                      color: isDark ? Colors.grey[300] : Colors.grey[800],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    '₹${(item.price * item.quantity).toInt()}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: isDark ? Colors.grey[300] : Colors.grey[800],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 8),
                        const Divider(),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Amount: ₹${order.totalPrice.toInt()}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                            if (order.status == OrderStatus.delivered)
                              OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.deepPurple,
                                  side: const BorderSide(color: Colors.deepPurple),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () => _handleReorder(order),
                                icon: const Icon(Icons.refresh, size: 16),
                                label: const Text('Reorder')
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}
